import 'package:assoya/providers/auth_provider.dart';
import 'package:assoya/widgets/my_button.dart';
import 'package:assoya/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({Key? key}) : super(key: key);

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  TextEditingController controller = TextEditingController();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '#####', filter: {"#": RegExp(r'[0-9]')});
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: ((context, provider, child) {
      return Scaffold(
          appBar: AppBar(
              title: Text(
                "Activation de votre compte",
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.blue)),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: FormBuilder(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      MyInputField(
                        label: "Code de vérification",
                        hint: "Code de vérification reçu par email",
                        name: "code",
                        type: TextInputType.text,
                        obscur: false,
                        validator: null,
                        controller: controller,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      (provider.status == WorkStatus.None ||
                              provider.status == WorkStatus.Error)
                          ? MyButton(
                              text: "Envoyer",
                              pressed: () async {
                                await provider.doVerifyAccount(controller.text);
                              },
                              color: Colors.orange,
                            )
                          : CircularProgressIndicator()
                    ],
                  ),
                )),
          ));
    }));
  }
}
