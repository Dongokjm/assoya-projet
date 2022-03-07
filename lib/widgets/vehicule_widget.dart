import 'package:assoya/models/vehicule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehiculeWidget extends StatefulWidget {
  Vehicule? vehicule;
  VehiculeWidget({Key? key, this.vehicule}) : super(key: key);

  @override
  _VehiculeWidgetState createState() => _VehiculeWidgetState();
}

class _VehiculeWidgetState extends State<VehiculeWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Get.toNamed("/vehicule_details", arguments: widget.vehicule);
        },
        child: Ink(
            child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(5),
          height: 370,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5, color: Colors.grey.shade300)),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "${widget.vehicule!.marque} ${widget.vehicule!.modele}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  "Matricule : ${widget.vehicule!.immatriculation}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: Chip(
                    backgroundColor: Colors.orange,
                    label: Text(
                      "${widget.vehicule!.nombrePlace} places",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Image.asset(
                "assets/images/car.jpeg",
                fit: BoxFit.cover,
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "${widget.vehicule!.typeCarburant}",
                        style: TextStyle(
                            fontWeight: FontWeight.w200, fontSize: 20),
                      ),
                      subtitle: Text(
                        "${widget.vehicule!.typeBoite}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      trailing: Chip(
                          backgroundColor: Colors.blue,
                          label: Text(
                            "${widget.vehicule!.anneeUtilisation}",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
