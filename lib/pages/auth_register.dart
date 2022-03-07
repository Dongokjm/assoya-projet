import 'package:assoya/providers/auth_provider.dart';
import 'package:assoya/widgets/account_type.dart';
import 'package:assoya/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({Key? key}) : super(key: key);

  @override
  _AuthRegisterPageState createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
  final _accountTypeKey = GlobalKey<FormBuilderState>();
  final _baseInfokey = GlobalKey<FormBuilderState>();
  TextEditingController userTypeCtrl = TextEditingController();
  bool? is_driver = false;
  bool? is_passenger = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: ((context, provider, child) {
      return Scaffold(
          appBar: AppBar(
              title: Text(
                "Création de compte",
                style: TextStyle(color: Colors.blue),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.blue)),
          body: CoolStepper(
              config: CoolStepperConfig(
                  nextTextList: [
                    "Infos de base",
                    "Documents",
                  ],
                  backTextList: [
                    "Type de compte",
                    "Infos de base",
                  ],
                  ofText: "sur",
                  stepText: "Étape",
                  backText: "Précédent",
                  nextText: "Suivant",
                  finalText: "Terminer"),
              onCompleted: () async {
                provider.formData["ville_id"] = 1;
                provider.formData["pays_id"] = 53;
                provider.formData["commune_id"] = 53;
                provider.formData["pays_origine"] = "Côte d'Ivoire";
                print("[Form Data] ${provider.formData.toString()}");
                await provider.doRegister();

                //Get.toNamed("/home");
              },
              steps: [
                CoolStep(
                    title: "Type de compte",
                    subtitle: "Veuillez renseigner ces informations",
                    content: Container(
                        child: FormBuilder(
                      key: _accountTypeKey,
                      child: Column(
                        children: [
                          Opacity(
                              opacity: 0,
                              child: FormBuilderTextField(
                                name: "type_user",
                                controller: userTypeCtrl,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              AccountType(
                                types: AccountTypes.driver,
                                checked: is_driver!,
                                pressed: () {
                                  setState(() {
                                    is_driver = true;
                                    is_passenger = false;
                                    userTypeCtrl.text = "conducteur";
                                  });
                                },
                              ),
                              AccountType(
                                types: AccountTypes.passenger,
                                checked: is_passenger!,
                                pressed: () {
                                  setState(() {
                                    is_driver = false;
                                    is_passenger = true;
                                    userTypeCtrl.text = "passager";
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                    validation: () {
                      _accountTypeKey.currentState!.save();
                      if (_accountTypeKey.currentState!.validate()) {
                        provider.formData["type_user"] =
                            _accountTypeKey.currentState!.value["type_user"];
                        print(
                            "[Account Data] : ${_accountTypeKey.currentState!.value}");
                      } else {
                        print("validation failed");
                      }
                    }),
                CoolStep(
                    title: "Informations de base",
                    subtitle: "Veuillez renseigner ces informations",
                    content: Container(
                      child: FormBuilder(
                        key: _baseInfokey,
                        child: Column(
                          children: [
                            MyInputField(
                              hint: "Ex : John",
                              label: "Nom",
                              name: "name",
                              obscur: false,
                              type: TextInputType.text,
                              validator: null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyInputField(
                              hint: "Ex : Doe",
                              label: "Prénom",
                              name: "last_name",
                              obscur: false,
                              type: TextInputType.text,
                              validator: null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyInputField(
                              hint: "Ex : 225 00 00 00 00 ",
                              label: "Télephone",
                              name: "telephone",
                              obscur: false,
                              type: TextInputType.phone,
                              validator: null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyInputField(
                              hint: "Ex : test@mail.com",
                              label: "Email",
                              name: "email",
                              type: TextInputType.emailAddress,
                              obscur: false,
                              validator: (val) =>
                                  !isEmail(val) ? "Invalid Email" : null,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyInputField(
                              hint: "Ex : LightBot@225",
                              label: "Pseudonyme",
                              name: "login",
                              type: TextInputType.text,
                              obscur: false,
                              validator: null,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyInputField(
                              hint: "Ex : @Ziwa80Ti@",
                              label: "Mot de passe",
                              name: "password",
                              obscur: true,
                              type: TextInputType.text,
                              validator: null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyInputField(
                              hint: "Ex : @Ziwa80Ti@",
                              label: "Retaper Mot de passe",
                              name: "re-password",
                              obscur: true,
                              type: TextInputType.text,
                              validator: null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    validation: () {
                      _baseInfokey.currentState!.save();
                      if (_baseInfokey.currentState!.validate()) {
                        provider.formData["name"] =
                            _baseInfokey.currentState!.value["name"];
                        provider.formData["last_name"] =
                            _baseInfokey.currentState!.value["last_name"];
                        provider.formData["email"] =
                            _baseInfokey.currentState!.value["email"];
                        provider.formData["login"] =
                            _baseInfokey.currentState!.value["login"];
                        provider.formData["telephone"] =
                            _baseInfokey.currentState!.value["telephone"];
                        provider.formData["portable"] =
                            _baseInfokey.currentState!.value["telephone"];
                        provider.formData["password"] =
                            _baseInfokey.currentState!.value["password"];
                        print(
                            "[Base Info Data] : ${_baseInfokey.currentState!.value}");
                      } else {
                        print("validation failed");
                      }
                    }),
              ]));
    }));
  }
}
