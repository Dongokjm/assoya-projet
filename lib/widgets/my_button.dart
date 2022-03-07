import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? text;
  final Color? color;
  // ignore: prefer_typing_uninitialized_variables
  final pressed;
  const MyButton({Key? key, this.text, this.pressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: MaterialButton(
        onPressed: pressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              text!.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
