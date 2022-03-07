import 'package:assoya/models/passenger_route.dart';
import 'package:assoya/widgets/passenger_route_widget.dart';
import 'package:flutter/material.dart';

class MyRideListPage extends StatefulWidget {
  const MyRideListPage({Key? key}) : super(key: key);

  @override
  _MyRideListPageState createState() => _MyRideListPageState();
}

class _MyRideListPageState extends State<MyRideListPage> {
  List<PassengerRoute> data = [
    PassengerRoute(
      origin: "Abobo,La gare",
      date: "02 ,Jan 2021",
      destination: "Cocody, St jean",
    ),
    PassengerRoute(
      origin: "Adjamé,Marché Gouro",
      date: "04 ,Avr 2021",
      destination: "TreichVille, CHU",
    ),
    PassengerRoute(
      origin: "Anyama,Mairie",
      date: "21 ,Jan 2021",
      destination: "Angré, St Xavier",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Vos Trajets publiés",
          style: TextStyle(color: Colors.blue),
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
                  return PassengerRouteWidget(
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
