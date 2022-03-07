import 'package:assoya/models/vehicule.dart';
import 'package:assoya/providers/data_provider.dart';
import 'package:assoya/widgets/vehicule_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class VehiculeListPage extends StatefulWidget {
  const VehiculeListPage({Key? key}) : super(key: key);

  @override
  _VehiculeListPageState createState() => _VehiculeListPageState();
}

class _VehiculeListPageState extends State<VehiculeListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Vos véhicules",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue),
        ),
        body: provider.cars.length > 0
            ? SingleChildScrollView(
                child: Column(
                children: provider.cars.map((e) {
                  return VehiculeWidget(
                    vehicule: e,
                  );
                }).toList(),
              ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () async {
                          await provider.fetchCars();
                        },
                        icon: Icon(
                          Icons.restart_alt,
                          size: 50,
                        )),
                    Text("Pas de données")
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Get.toNamed("/vehicule_form", arguments: null);
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
