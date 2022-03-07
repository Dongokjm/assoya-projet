import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assoya/providers/data_provider.dart';
import 'package:assoya/widgets/driver_route_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RouteListPage extends StatefulWidget {
  const RouteListPage({Key? key}) : super(key: key);

  @override
  _RouteListPageState createState() => _RouteListPageState();
}

class _RouteListPageState extends State<RouteListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Rechercher..."),
              )
            ],
          )),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed("/route_filter_page");
              },
              icon: Icon(
                Icons.tune,
                color: Colors.blue,
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue),
          shadowColor: Colors.white,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("D'autres avant vous ont publiés des trajets",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    DefaultTextStyle(
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        pause: Duration(milliseconds: 1500),
                        animatedTexts: [
                          TypewriterAnimatedText(
                              "Parcourez la liste,ou filtrez-la ..."),
                          TypewriterAnimatedText(
                              "Trouvez  l'itinéraire qui vous convient ..."),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ...provider.rides.map((e) {
                  return DriverRouteWidget(
                    item: e,
                  );
                }).toList()
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.orange,
        //   onPressed: () {},
        //   child: Icon(
        //     Icons.tune,
        //     size: 20,
        //   ),
        // ),
      );
    });
  }
}
