import 'dart:math';

import 'package:assoya/providers/place_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();
final kGoogleApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
final kCountry = dotenv.env['COUNTRY'];

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold,
    String target, TextEditingController txtCtrl) async {
  GoogleMapsPlaces _places = GoogleMapsPlaces(
    apiKey: kGoogleApiKey,
    apiHeaders: await GoogleApiHeaders().getHeaders(),
  );
  PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
  final lat = detail.result.geometry?.location.lat;
  final lng = detail.result.geometry?.location.lng;
  txtCtrl.text = p.description!;
  if (target == "origin") {
    Provider.of<PlaceProvider>(scaffold.context, listen: false)
        .setOrigin(p.description!, LatLng(lat!, lng!));
  } else {
    Provider.of<PlaceProvider>(scaffold.context, listen: false)
        .setDestination(p.description!, LatLng(lat!, lng!));
  }

  if (Provider.of<PlaceProvider>(scaffold.context, listen: false)
              .origin_point !=
          null &&
      Provider.of<PlaceProvider>(scaffold.context, listen: false).destination !=
          null) {
    await Provider.of<PlaceProvider>(scaffold.context, listen: false)
        .boundCameraToOriginAndDestination();

    await Provider.of<PlaceProvider>(scaffold.context, listen: false)
        .createPolylines();
  }

  Get.back();

  // scaffold.showSnackBar(
  //   SnackBar(content: Text("${p.description} - $lat/$lng")),
  // );
}

// custom scaffold that handle search
// basically your widget need to extends [GooglePlacesAutocompleteWidget]
// and your state [GooglePlacesAutocompleteState]
class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
          apiKey: kGoogleApiKey!,
          sessionToken: Uuid().generateV4(),
          language: "fr",
          components: [Component(Component.country, kCountry!)],
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  String? target;
  TextEditingController txtCtrl = TextEditingController();

  @override
  void initState() {
    debugPrint("Get Argument : ${Get.arguments.toString()}");
    target = Get.arguments["target"];
    txtCtrl = Get.arguments["controller"];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: AppBarPlacesAutoCompleteTextField(
        cursorColor: null,
        textStyle: TextStyle(color: Colors.blue),
        textDecoration: InputDecoration(
          hintText: target == "origin"
              ? "Adresse d'origine ..."
              : "Adresse de destination ...",
          hintStyle: TextStyle(color: Colors.blue),
          suffixIcon: target == "origin"
              ? Icon(
                  Icons.my_location,
                  color: Colors.blue,
                )
              : Icon(
                  Icons.flag,
                  color: Colors.blue,
                ),
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.blue),
    );
    final body = PlacesAutocompleteResult(
        onTap: (p) {
          displayPrediction(
              p, searchScaffoldKey.currentState!, target!, txtCtrl);
        },
        logo: Center(
          child: target == "origin"
              ? Icon(
                  Icons.my_location,
                  size: 90,
                  color: Colors.orange.shade200,
                )
              : Icon(
                  Icons.flag,
                  size: 90,
                  color: Colors.orange.shade200,
                ),
        ));
    return Consumer<PlaceProvider>(builder: (context, provider, child) {
      return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
    });
  }

  @override
  void onResponseError(PlacesAutocompleteResponse? response) {
    super.onResponseError(response!);
    searchScaffoldKey.currentState!.showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse? response) {
    super.onResponse(response!);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState!.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
