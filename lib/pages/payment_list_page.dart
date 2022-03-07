import 'package:assoya/models/payment.dart';
import 'package:assoya/widgets/payment_widget.dart';
import 'package:flutter/material.dart';

class PaymentListPage extends StatefulWidget {
  const PaymentListPage({Key? key}) : super(key: key);

  @override
  _PaymentListPageState createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage> {
  List<Payment> data = [
    Payment(
        code: "#PAI-34854",
        ride: "COUR-Y0P-COC-0012",
        date: "07-12-2020",
        price: 800,
        payment_type: "ASSOYA"),
    Payment(
        code: "#PAI-34954",
        ride: "COUR-Y0P-COC-0012",
        date: "07-12-2020",
        price: 400,
        payment_type: "ASSOYA"),
    Payment(
        code: "#PAI-34774",
        ride: "COUR-Y0P-COC-0012",
        date: "07-12-2020",
        price: 600,
        payment_type: "ASSOYA"),
    Payment(
        code: "#PAI-34811",
        ride: "COUR-Y0P-COC-0012",
        date: "07-12-2020",
        price: 500,
        payment_type: "ASSOYA"),
    Payment(
        code: "#PAI-34830",
        ride: "COUR-ABO-COC-0012",
        date: "07-12-2021",
        price: 450,
        payment_type: "ASSOYA"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Vos paiements :",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ...data.map((e) {
                  return PaymentWidget(
                    item: e,
                  );
                }).toList()
              ],
            ),
          )),
    );
  }
}
