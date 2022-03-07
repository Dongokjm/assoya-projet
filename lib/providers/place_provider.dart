import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceProvider extends ChangeNotifier {
  String? origin;
  String? destination;
  LatLng? origin_point;
  LatLng? destination_point;
  Set<Marker>? markers = {};
  double? southWestLatitude;
  double? southWestLongitude;
  double? northEastLatitude;
  double? northEastLongitude;
  GoogleMapController? mapController;
  String? originMarkerId;
  String? destinationMarkerId;
  // Object for PolylinePoints
  PolylinePoints? polylinePoints;
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];
  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};
  final kGoogleApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

  setOrigin(String a, LatLng b) {
    if (originMarkerId != null) {
      markers!.removeWhere((Marker element) => (element.markerId == "origin"));
    }
    origin = a;
    origin_point = b;

    originMarkerId = "origin";
    Marker originMarker = Marker(
        markerId: MarkerId(originMarkerId!),
        position: b,
        infoWindow: InfoWindow(title: "${a}"));
    markers!.add(originMarker);
    notifyListeners();
  }

//Bound camera to the Origin and Destination points
  boundCameraToOriginAndDestination() async {
    double miny = (origin_point!.latitude <= destination_point!.latitude)
        ? origin_point!.latitude
        : destination_point!.latitude;
    double minx = (origin_point!.longitude <= destination_point!.longitude)
        ? origin_point!.longitude
        : destination_point!.longitude;
    double maxy = (origin_point!.latitude <= destination_point!.latitude)
        ? destination_point!.latitude
        : origin_point!.latitude;
    double maxx = (origin_point!.longitude <= destination_point!.longitude)
        ? destination_point!.longitude
        : origin_point!.longitude;

    southWestLatitude = miny;
    southWestLongitude = minx;

    northEastLatitude = maxy;
    northEastLongitude = maxx;
    mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude!, northEastLongitude!),
          southwest: LatLng(southWestLatitude!, southWestLongitude!),
        ),
        50.0,
      ),
    );
    notifyListeners();
  }

  setDestination(String a, LatLng b) {
    if (destinationMarkerId != null) {
      markers!
          .removeWhere((Marker element) => (element.markerId == "destination"));
    }

    destination = a;
    destination_point = b;
    destinationMarkerId = "destination";
    Marker destinationMarker = Marker(
        markerId: MarkerId(destinationMarkerId!),
        position: b,
        infoWindow: InfoWindow(title: "${a}"));
    markers!.add(destinationMarker);

    notifyListeners();
  }

// Create the polylines for showing the route between two places
  createPolylines() async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();
    polylineCoordinates.clear();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints!
        .getRouteBetweenCoordinates(
      kGoogleApiKey!, // Google Maps API Key
      PointLatLng(origin_point!.latitude, origin_point!.longitude),
      PointLatLng(destination_point!.latitude, destination_point!.longitude),
      travelMode: TravelMode.driving,
    )
        .catchError((onError) {
      debugPrint("Get Route Error : ${onError.toString()}");
    });

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      debugPrint("Routes Coordinates :[${polylineCoordinates.length}]");
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;
    notifyListeners();
  }
}
