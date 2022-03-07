import 'package:assoya/widgets/my_button.dart';
import 'package:flutter/material.dart';

enum ActionTypes {
  add,
  find,
}

class RouteForm extends StatefulWidget {
  ActionTypes? type;

  RouteForm({Key? key, required type}) : super(key: key);

  @override
  _RouteFormState createState() => _RouteFormState();
}

class _RouteFormState extends State<RouteForm> {
  String? _startAddress = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0, color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Column(
        children: [
          Container(
            height: 40.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.my_location),
                  border: InputBorder.none,
                  hintText: "Lieu de départ"),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 40.0,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.flag),
                  border: InputBorder.none,
                  hintText: "Lieu d'arrivée"),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          MyButton(
              text: widget.type == ActionTypes.add
                  ? "Ajouter ce trajet"
                  : "Trouver ce trajet",
              color: Colors.blue,
              pressed: () async {}),
        ],
      ),
    );
  }
}
