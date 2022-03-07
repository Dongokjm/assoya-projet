import 'package:assoya/providers/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class DriverRideForm extends StatefulWidget {
  const DriverRideForm({Key? key}) : super(key: key);

  @override
  _DriverRideFormState createState() => _DriverRideFormState();
}

class _DriverRideFormState extends State<DriverRideForm> {
  final _stepOnekey = GlobalKey<FormBuilderState>();
  final _stepTwokey = GlobalKey<FormBuilderState>();
  final _stepThreekey = GlobalKey<FormBuilderState>();

  TextEditingController originCtrl = TextEditingController();
  TextEditingController destinationCtrl = TextEditingController();
  final kGoogleApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
  // GoogleMapController? mapController;
  Position? _currentPosition;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  int _index = 0;

  //Get current user position
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        debugPrint('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        Provider.of<PlaceProvider>(context).mapController!.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    bearing: 192.8334901395799,
                    target: LatLng(position.latitude, position.longitude),
                    tilt: 59.440717697143555,
                    zoom: 19.151926040649414),
              ),
            );
      });
      // await _getAddress();
    }).catchError((e) {
      debugPrint(e);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(builder: (context, provider, child) {
      return Scaffold(
          body: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _buildStepperView(provider)));
    });
  }

  Widget _buildStepperView(PlaceProvider provider) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: ListTile(
            title: Text("Étape 1"),
            subtitle: Text("Selectionner l'origine et la destination"),
          ),
          content: Container(
            child: FormBuilder(
                key: _stepOnekey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: "origin",
                      readOnly: true,
                      controller: originCtrl,
                      decoration: InputDecoration(
                          label: Text("Adresse d'origine"),
                          border: InputBorder.none,
                          hintText: "Adresse d'origine ..."),
                      onTap: () {
                        Get.toNamed("/place_search", arguments: {
                          "target": "origin",
                          "controller": originCtrl
                        });
                      },
                    ),
                    FormBuilderTextField(
                      name: "destination",
                      readOnly: true,
                      controller: destinationCtrl,
                      decoration: InputDecoration(
                          label: Text("Adresse de destination"),
                          border: InputBorder.none,
                          hintText: "Adresse de destination ..."),
                      onTap: () {
                        Get.toNamed("/place_search", arguments: {
                          "target": "destination",
                          "controller": destinationCtrl
                        });
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        myLocationEnabled: true,
                        trafficEnabled: false,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        markers: Set<Marker>.from(provider.markers!),
                        polylines: Set<Polyline>.of(provider.polylines.values),
                        onMapCreated: (GoogleMapController controller) {
                          setState(() {
                            provider.mapController = controller;
                          });
                        },
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Step(
          title: ListTile(
            title: Text("Étape 2"),
            subtitle: Text(
                "Entrer les informations qui décrivent mieux votre trajet"),
          ),
          content: Container(
            child: FormBuilder(
                key: _stepTwokey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderTextField(
                      name: 'nbr_place',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Nombre de place disponible',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    FormBuilderTextField(
                      name: 'price',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Tarif / passager',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    Text(
                      "Selectionner vos préferences:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderCheckboxGroup(name: "preferences", options: [
                      FormBuilderFieldOption(
                        value: "0",
                        child: Text("Pas d'animaux"),
                      ),
                      FormBuilderFieldOption(
                        value: "1",
                        child: Text("Pas de fumeurs"),
                      ),
                      FormBuilderFieldOption(
                        value: "3",
                        child: Text("Pas de bagages"),
                      ),
                    ]),
                  ],
                )),
          ),
        ),
        Step(
          title: ListTile(
            title: Text("Étape Finale"),
            subtitle: Text(
                "Selectionner votre type de trajet et vos jours ouvrables"),
          ),
          content: Container(
            child: FormBuilder(
                key: _stepThreekey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type du trajet:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderDropdown(initialValue: 1, name: "type", items: [
                      DropdownMenuItem(
                          value: 1, child: Text("Trajet quotidien")),
                      DropdownMenuItem(
                          value: 2, child: Text("Trajet ponctuel")),
                    ]),
                    Text(
                      "Selectionner vos jours:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    FormBuilderFilterChip(name: "days", options: [
                      FormBuilderFieldOption(
                        value: "Lun",
                        child: Text("Lundi"),
                      ),
                      FormBuilderFieldOption(
                        value: "Mar",
                        child: Text("Mardi"),
                      ),
                      FormBuilderFieldOption(
                        value: "Mer",
                        child: Text("Mercredi"),
                      ),
                      FormBuilderFieldOption(
                        value: "Jeu",
                        child: Text("jeudi"),
                      ),
                      FormBuilderFieldOption(
                        value: "Ven",
                        child: Text("Vendredi"),
                      ),
                      FormBuilderFieldOption(
                        value: "Sam",
                        child: Text("Samedi"),
                      ),
                      FormBuilderFieldOption(
                        value: "Dim",
                        child: Text("Dimanche"),
                      ),
                    ]),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
