import 'package:flutter/material.dart';

class DrawerCard extends StatefulWidget {
  String? title;
  String? subtitle;
  IconData icon;
  var pressed;
  DrawerCard(
      {Key? key,
      this.title,
      this.subtitle,
      required this.icon,
      required this.pressed})
      : super(key: key);

  @override
  _DrawerCardState createState() => _DrawerCardState();
}

class _DrawerCardState extends State<DrawerCard> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: widget.pressed,
        child: Ink(
          child: Container(
            padding: EdgeInsets.all(8.0),
            height: 100,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(width: 0.5, color: Colors.grey)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.icon,
                  size: 35,
                  color: Colors.blue,
                ),
                Text(
                  widget.title!,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.subtitle!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black38, fontSize: 11),
                )
              ],
            ),
          ),
        ));
  }
}
