import 'package:assoya/models/ride.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverRouteWidget extends StatefulWidget {
  Ride? item;

  DriverRouteWidget({Key? key, this.item}) : super(key: key);

  @override
  _DriverRouteWidgetState createState() => _DriverRouteWidgetState();
}

class _DriverRouteWidgetState extends State<DriverRouteWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Get.toNamed("/route_details", arguments: widget.item);
      },
      child: Ink(
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(top: 15),
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
                leading: Icon(
                  Icons.my_location,
                  size: 20,
                ),
                title: Text(
                  widget.item!.addresseDepart!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                ),
                // subtitle: Text("Tours de la Cité Administrative, Abidjan"),
              ),
              ListTile(
                leading: Icon(
                  Icons.flag,
                  size: 20,
                ),
                title: Text(
                  widget.item!.addresseArrivee!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                ),
                // subtitle: Text("Tours de la Cité Administrative, Abidjan"),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "${widget.item!.tarifConducteur!} XOF",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 25, color: Colors.orange.shade700),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "[ ${widget.item!.places!} places disponibles ]",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
