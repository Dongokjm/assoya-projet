import 'package:assoya/models/passenger_route.dart';
import 'package:assoya/models/race.dart';
import 'package:assoya/widgets/passenger_route_widget.dart';
import 'package:assoya/widgets/race_widget.dart';
import 'package:flutter/material.dart';

class MyRaceListPage extends StatefulWidget {
  const MyRaceListPage({Key? key}) : super(key: key);

  @override
  _MyRaceListPageState createState() => _MyRaceListPageState();
}

class _MyRaceListPageState extends State<MyRaceListPage> {
  List<Race> data = [
    Race(
        route: PassengerRoute(
            date: "07/10/2021",
            origin: "Adjamé Marché",
            destination: "Cocody, Ambassade"),
        price: 500,
        start_hour: "9h00",
        end_hour: "10h00"),
    Race(
        route: PassengerRoute(
            date: "07/10/2021",
            origin: "Yopougon, Siporex",
            destination: "TreichVille, CHU"),
        price: 700,
        start_hour: "9h00",
        end_hour: "10h00"),
    Race(
        route: PassengerRoute(
            date: "07/10/2021",
            origin: "Riviera 2, Attoban",
            destination: "TreichVille, CHU"),
        price: 800,
        start_hour: "9h00",
        end_hour: "10h00"),
    Race(
        route: PassengerRoute(
            date: "07/10/2021",
            origin: "Yopougon, Ananerais",
            destination: "Port-Bouet, CHU"),
        price: 900,
        start_hour: "9h00",
        end_hour: "10h00")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Vous avez effectué ces courses ",
          style: TextStyle(fontSize: 15, color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ...data.map((e) {
                  return RaceWidget(
                    item: e,
                  );
                }).toList()
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
