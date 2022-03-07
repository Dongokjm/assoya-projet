import 'package:assoya/models/user.dart';
import 'package:assoya/providers/auth_provider.dart';
import 'package:assoya/widgets/my_button.dart';
import 'package:assoya/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({Key? key}) : super(key: key);

  @override
  _AuthLoginPageState createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  TextEditingController? loginCtrl = TextEditingController();
  TextEditingController? passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<AuthProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 35,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Bienvenue sur Assoya',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Text('Connectez-vous ou créez un compte pour débuter',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.5))),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            LottieBuilder.asset(
              "assets/lottie/tourists-by-car.json",
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            MyInputField(
              hint: "Ex : 00225 010202030",
              controller: loginCtrl,
              label: "Téléphone",
              name: "telephone",
              type: TextInputType.phone,
              obscur: false,
              validator: null,
              formatter: null,
            ),
            const SizedBox(
              height: 5,
            ),
            MyInputField(
              hint: "Ex : @Ziwa80Ti@",
              controller: passwordCtrl,
              label: "Password",
              name: "password",
              obscur: true,
              type: TextInputType.text,
              validator: null,
              formatter: null,
            ),
            const SizedBox(
              height: 10,
            ),
            (provider.status == WorkStatus.None ||
                    provider.status == WorkStatus.Error)
                ? MyButton(
                    text: "connexion",
                    color: Colors.blue,
                    pressed: () async {
                      await provider.doLogin(User(
                          login: loginCtrl!.text,
                          password: passwordCtrl!.text));
                    })
                : Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                      backgroundColor: Colors.blue,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            (provider.status == WorkStatus.None ||
                    provider.status == WorkStatus.Error)
                ? MyButton(
                    text: "Créer votre compte",
                    color: Colors.orange,
                    pressed: () async {
                      await Get.toNamed("/register");
                    })
                : Text("")
          ],
        ),
      );
    }));
  }
}
