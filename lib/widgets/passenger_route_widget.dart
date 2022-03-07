import 'package:assoya/models/driver_route.dart';
import 'package:assoya/models/passenger_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassengerRouteWidget extends StatefulWidget {
  PassengerRoute? item;

  PassengerRouteWidget({Key? key, this.item}) : super(key: key);

  @override
  _PassengerRouteWidgetState createState() => _PassengerRouteWidgetState();
}

class _PassengerRouteWidgetState extends State<PassengerRouteWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        // Get.toNamed("/route_details");
      },
      child: Ink(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(top: 15, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
                color: Colors.grey.shade400,
                // set border color
                width: 0.8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.my_location),
                title: Text(
                  widget.item!.origin!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                subtitle: Text("Tours de la Cité Administrative, Abidjan"),
              ),
              ListTile(
                leading: Icon(Icons.flag),
                title: Text(
                  widget.item!.destination!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                subtitle: Text("Tours de la Cité Administrative, Abidjan"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
