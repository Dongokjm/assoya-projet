import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PassengerRideForm extends StatefulWidget {
  const PassengerRideForm({Key? key}) : super(key: key);

  @override
  _PassengerRideFormState createState() => _PassengerRideFormState();
}

class _PassengerRideFormState extends State<PassengerRideForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final kGoogleApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
  GoogleMapController? mapController;
  Position? _currentPosition;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'Lieu de départ',
                        decoration: InputDecoration(
                          labelText: 'Lieu de départ',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      FormBuilderTextField(
                        name: "Lieu d'arrivée",
                        decoration: InputDecoration(
                          labelText: "Lieu d'arrivée",
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      FormBuilderDateRangePicker(
                        name: 'date_range',
                        firstDate: DateTime(1970),
                        lastDate: DateTime(2030),
                        // format: DateFormat('yyyy-MM-dd'),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: 'Plage Horaire',
                          helperText: 'Helper text',
                          hintText: 'Hint text',
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: _kGooglePlex,
                          myLocationEnabled: true,
                          trafficEnabled: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: false,
                          onMapCreated: (GoogleMapController controller) {
                            setState(() {
                              mapController = controller;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              color: Theme.of(context).colorScheme.primary,
                              child: Text(
                                "Enregistrer",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  print(_formKey.currentState!.value);
                                } else {
                                  print("validation failed");
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: MaterialButton(
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text(
                                "Reset",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                _formKey.currentState!.reset();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )))
        ],
      )),
    );
  }
}
