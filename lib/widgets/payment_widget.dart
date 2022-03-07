import 'package:assoya/models/payment.dart';
import 'package:flutter/material.dart';

class PaymentWidget extends StatefulWidget {
  Payment? item;
  PaymentWidget({Key? key, this.item}) : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
            color: Colors.grey.shade400,
            // set border color
            width: 0.8),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text("${widget.item!.ride}"),
            subtitle: Text("${widget.item!.code}"),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.item!.price} XOF",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Chip(
                      label: Text(
                        "${widget.item!.payment_type}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blueAccent.shade100,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
