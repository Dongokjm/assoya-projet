// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  SpashScreenState createState() => SpashScreenState();
}

class SpashScreenState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InitApp();
  }

  InitApp() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    await Future.delayed(Duration(seconds: 2)).then((value) {
      if (token == null) {
        Get.toNamed("/login");
      } else {
        Get.toNamed("/home");
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
              child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Image.asset(
                    'assets/images/assoya.png',
                  ))),
          Visibility(
            visible: true,
            child: Positioned.fill(
              bottom: 50,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                    backgroundColor: Colors.blue,
                  )),
            ),
          ),
        ],
      ),
    ));
  }
}
