import 'package:assoya/models/vehicule.dart';
import 'package:assoya/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class VehiculeDetailsPage extends StatefulWidget {
  VehiculeDetailsPage({Key? key}) : super(key: key);

  @override
  _VehiculeDetailsPageState createState() => _VehiculeDetailsPageState();
}

class _VehiculeDetailsPageState extends State<VehiculeDetailsPage> {
  Vehicule? vehicule;
  BuildContext? dialogContext;
  @override
  void initState() {
    vehicule = Get.arguments;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            Get.arguments != null
                ? "${vehicule!.marque} - ${vehicule!.modele}"
                : "Voir véhicule",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: Colors.grey.shade300)),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "Matricule : ${vehicule!.immatriculation}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    trailing: Chip(
                        backgroundColor: Colors.orange,
                        label: Text(
                          "${vehicule!.nombrePlace} places",
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
                            "${vehicule!.typeCarburant}",
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 20),
                          ),
                          subtitle: Text(
                            "${vehicule!.typeBoite}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          trailing: Chip(
                              backgroundColor: Colors.blue,
                              label: Text(
                                "${vehicule!.anneeUtilisation}",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        ListTile(
                          title: Text(
                            "${vehicule!.couleur}",
                            style: TextStyle(
                                fontWeight: FontWeight.w200, fontSize: 20),
                          ),
                          trailing: Chip(
                              label: Text(
                            "${vehicule!.ptac} Kg",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.toNamed("/vehicule_form",
                                      arguments: vehicule);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                  size: 60,
                                )),
                            IconButton(
                                onPressed: () async {
                                  await _showConfirmDeleteDialog(
                                      context, provider);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 60,
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      );
    });
  }

  Future<void> _showConfirmDeleteDialog(
      BuildContext context, DataProvider provider) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          dialogContext = context;
          return AlertDialog(
            title: Text("Voulez-vous vraiment supprimé ?",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red)),
            content: Text(""),
            actions: [
              InkWell(
                child: Text(
                  "Oui",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                onTap: () async {
                  bool deleted = await provider.deleteVehicule(vehicule!.id!);
                  if (deleted) {
                    await provider.fetchCars();
                    Get.toNamed("/vehicule_list");
                  }
                },
              ),
              InkWell(
                child: Text(
                  "Non",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
  }
}
