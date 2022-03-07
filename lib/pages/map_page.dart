import 'dart:async';

import 'package:assoya/widgets/route_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final kGoogleApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
  GoogleMapController? mapController;
  Position? _currentPosition;
  ActionTypes? actionType;
  bool formVisible = false;
  final startAddressController = TextEditingController();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final searchScaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

//Get current user position
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        debugPrint('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController!.animateCamera(
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

//Get current user position's address
//   _getAddress() async {
//     try {
//       // Places are retrieved using the coordinates
//       List<Placemark> p = await placemarkFromCoordinates(
//           _currentPosition!.latitude, _currentPosition!.longitude);
//
//       // Taking the most probable result
//       Placemark place = p[0];
//
//       setState(() {
//         // Structuring the address
//         _currentAddress =
//             "${place.locality},${place.subLocality}, ${place.street}, ${place.country}";
//
//         debugPrint(place.toString());
//         // Update the text of the TextField
//         startAddressController.text = _currentAddress!;
//
//         // Setting the user's present location as the starting address
//         _startAddress = _currentAddress;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key, // Assign the key to Scaffold.
      // drawer: const DrawerMenu(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _goToTheLake,
      //   child: const Icon(Icons.car_rental),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
