import 'package:assoya/models/ride.dart';
import 'package:assoya/providers/place_provider.dart';
import 'package:assoya/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

class RouteDetailsPage extends StatefulWidget {
  const RouteDetailsPage({Key? key}) : super(key: key);

  @override
  _RouteDetailsPageState createState() => _RouteDetailsPageState();
}

class _RouteDetailsPageState extends State<RouteDetailsPage>
    with SingleTickerProviderStateMixin {
  final String? kGoogleApiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
  Ride? ride;
  GoogleMapController? mapController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  ScrollController _scrollController = ScrollController();
  var top = 0.0;
  var days = ["L:0", "M:1", "M:1", "J:1", "V:0", "S:1", "D:0"];

  @override
  void initState() {
    ride = Get.arguments;
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      //  add your code which you want to execute after your build is complete
      printInfo(info: "Build Finished");
    });
    // WidgetsBinding.instance?.addPostFrameCallback((_) => initMap());
  }

  initMap() async {
    Provider.of<PlaceProvider>(context, listen: false).markers!.clear();
    Provider.of<PlaceProvider>(context, listen: false)
        .polylineCoordinates
        .clear();

    Provider.of<PlaceProvider>(context, listen: false).setOrigin(
        "origin",
        LatLng(double.parse(ride!.addressLatitude!),
            double.parse(ride!.addressLongitude!)));
    Provider.of<PlaceProvider>(context, listen: false).setDestination(
        "destination",
        LatLng(double.parse(ride!.addressDestLatitude!),
            double.parse(ride!.addressDestLongitude!)));
    if (Provider.of<PlaceProvider>(context, listen: false).origin_point !=
            null &&
        Provider.of<PlaceProvider>(context, listen: false).destination !=
            null) {
      await Provider.of<PlaceProvider>(context, listen: false)
          .boundCameraToOriginAndDestination();

      await Provider.of<PlaceProvider>(context, listen: false)
          .createPolylines();
    }
    printInfo(info: "Map Init Finished");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaceProvider>(builder: (context, provider, child) {
      return Scaffold(
          body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.blue),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: (top == 56.0) ? Colors.white : Colors.blue,
                    ),
                  ),
                ),
                expandedHeight: MediaQuery.of(context).size.height / 2.5,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  top = constraints.biggest.height;
                  debugPrint("Top [${top}]");
                  return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: top == 56.0 ? 1.0 : 0.0,
                        // opacity: 1.0,
                        child: Text(
                          "Audi A5 , 12345HT01",
                          style: TextStyle(color: Colors.blue),
                        )),
                    background: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      myLocationEnabled: true,
                      trafficEnabled: false,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      markers: Set<Marker>.from(provider.markers!),
                      polylines: Set<Polyline>.of(provider.polylines.values),
                      onMapCreated: (GoogleMapController controller) async {
                        setState(() {
                          provider.mapController = controller;
                        });

                        await Future.delayed(Duration(seconds: 2), () async {
                          if (mounted) {
                            await initMap();
                          }
                        });

                        printInfo(info: "Maps Created Finished");

                        // await provider.createPolylines();
                      },
                    ),
                  );
                }),
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0, color: Colors.white),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  ListTile(
                    title: Text("${ride!.addresseDepart}"),
                    subtitle: Text("${ride!.addresseArrivee}"),
                  ),
                  Image.asset("assets/images/car.jpeg"),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage(
                                          "assets/images/user_avatar.png"))),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Alex",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "WestWood",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "3.5 ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54),
                                            ),
                                            RatingBar.builder(
                                              initialRating: 1,
                                              minRating: 1,
                                              maxRating: 1,
                                              itemSize: 25,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 1,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${ride!.tarifConducteur} XOF",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade700),
                            ),
                            Text("[ ${ride!.places} places disponibles ]",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey.shade700))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text("${ride!.heureDepart}"),
                          trailing: Text("${ride!.heureArrivee}"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Les conditions du conducteur :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(lorem(paragraphs: 1, words: 30)),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 8,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: days.map((n) {
                              print(n.split(":")[1].toString());
                              return Chip(
                                backgroundColor:
                                    n.split(":")[1].toString() == "0"
                                        ? Colors.grey.shade400
                                        : Colors.blue,
                                padding: EdgeInsets.all(3),
                                labelPadding: EdgeInsets.all(10),
                                label: Text(
                                  n.split(":")[0].toString(),
                                  style: TextStyle(
                                      color: n.split(":")[1].toString() == "0"
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: MyButton(
                            text: "Réserver votre place",
                            color: Colors.orange,
                            pressed: () {},
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
    });
  }
}
