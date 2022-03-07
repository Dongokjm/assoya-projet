import 'package:assoya/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({Key? key}) : super(key: key);

  @override
  _PointsPageState createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  BuildContext? dialogContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Vos points",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Container(
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1.0, color: Colors.grey)),
                child: Text(
                  "9800 points",
                  style: TextStyle(color: Colors.orange, fontSize: 40),
                ),
              ),
              SizedBox(
                height: 300,
              ),
              MyButton(
                pressed: () {
                  showAsBottomSheet();
                },
                color: Colors.blue,
                text: "Recharger des points",
              )
            ],
          ),
        ),
      ),
    );
  }

  void showAsBottomSheet() async {
    final result = await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        builder: (context, state) {
          return Container(
              height: 400,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Choisissez votre opérateur :",
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        child: InkWell(
                          onTap: () {
                            _showMyDialog(context);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Image.asset(
                                "assets/images/orange-money.jpeg",
                                width: 80,
                                height: 80,
                              )),
                        ),
                      ),
                      Material(
                        child: InkWell(
                          onTap: () {
                            _showMyDialog(context);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Image.asset(
                                "assets/images/moov-money.jpeg",
                                width: 80,
                                height: 80,
                              )),
                        ),
                      ),
                      Material(
                        child: InkWell(
                          onTap: () {
                            _showMyDialog(context);
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Image.asset(
                                "assets/images/mtn-money.png",
                                width: 80,
                                height: 80,
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ));
        },
      );
    });

    print(result); // This is the result.
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          dialogContext = context;
          return WillPopScope(
              onWillPop: () async {
                return Future.value(true);
              },
              child: AlertDialog(
                  title: Text('Ouverture de la page de paiement ...'),
                  content: Container(
                    height: MediaQuery.of(context).size.height / 6,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.open_in_new,
                            color: Colors.green,
                            size: 100,
                          ),
                        ],
                      ),
                    ),
                  )));
        });
  }
}
