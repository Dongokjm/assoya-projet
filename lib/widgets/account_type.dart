import 'package:flutter/material.dart';

enum AccountTypes {
  driver,
  passenger,
}

class AccountType extends StatelessWidget {
  AccountTypes? types;
  bool checked;
  var pressed;
  AccountType({Key? key, this.types, required this.checked, this.pressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 1, color: Colors.grey.shade500)),
        child: MaterialButton(
          onPressed: pressed,
          child: Ink(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      types == AccountTypes.driver
                          ? Icons.drive_eta
                          : Icons.person,
                      size: 90,
                      color: Colors.blue,
                    ),
                    Text(
                      types == AccountTypes.driver ? "Conducteur" : "Passager",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    )
                  ],
                ),
                if (checked)
                  const Positioned(
                      top: 0,
                      child: Icon(
                        Icons.check_circle,
                        size: 40,
                        color: Colors.orange,
                      )),
              ],
            ),
          ),
        ));
  }
}
