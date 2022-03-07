import 'package:assoya/models/user_profile.dart';
import 'package:assoya/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class Gender {
  String? key;
  String? value;
  Gender({this.key, this.value});
}

class UserProfileForm extends StatefulWidget {
  UserProfile? userProfile;
  UserProfileForm({Key? key}) : super(key: key);

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<Gender> genders = [
    Gender(key: "", value: "Selectionner votre genre"),
    Gender(key: "Homme", value: "H"),
    Gender(key: "Femme", value: "F")
  ];

  @override
  void initState() {
    initUserProfile();
    // TODO: implement initState
    super.initState();
  }

  initUserProfile() async {
    var prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString("auth_user");
    print(userData.toString());

    Provider.of<AuthProvider>(context, listen: false).userProfile =
        UserProfile.fromJson(convert.jsonDecode(userData!));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: ((context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: FormBuilder(
                    key: _formKey,
                    initialValue: provider.userProfile!.toFormJson(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          name: 'login',
                          decoration: InputDecoration(
                            labelText: 'Pseudonyme',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        FormBuilderFilePicker(
                          name: "photo",
                          type: FileType.image,
                          decoration: InputDecoration(
                              labelText: "Photo de Profil",
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          maxFiles: 1,
                          previewImages: true,
                          onChanged: (val) => print(val),
                          selector: Row(
                            children: <Widget>[
                              Icon(Icons.file_upload),
                              Text('Uploader'),
                            ],
                          ),
                          onFileLoading: (val) {
                            print(val);
                          },
                        ),
                        FormBuilderTextField(
                          name: 'name',
                          decoration: InputDecoration(
                            labelText: 'Nom',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        FormBuilderTextField(
                          name: "last_name",
                          decoration: InputDecoration(
                            labelText: "Prénom",
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        FormBuilderTextField(
                          keyboardType: TextInputType.emailAddress,
                          name: "email",
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: "Email",
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.email(context),
                          ]),
                        ),
                        FormBuilderPhoneField(
                          name: 'telephone',
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: 'Numéro de Téléphone',
                            hintText: 'Hint',
                          ),
                          defaultSelectedCountryIsoCode: "CI",
                          priorityListByIsoCode: ['CI'],
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            // FormBuilderValidators.max(context, 14),
                          ]),
                        ),
                        FormBuilderDateTimePicker(
                          name: 'date_naissance',
                          // onChanged: _onChanged,
                          inputType: InputType.date,
                          decoration: InputDecoration(
                            labelText: 'Date de naissance',
                          ),
                          format: DateFormat('yyyy-MM-dd'),
                          // initialTime: TimeOfDay(hour: 8, minute: 0),

                          // enabled: true,
                        ),
                        FormBuilderDropdown(
                          name: 'sexe',
                          decoration: InputDecoration(
                            labelText: 'Genre',
                          ),
                          allowClear: true,
                          hint: Text('Selectionner votre Genre'),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: genders
                              .map((gender) => DropdownMenuItem<String>(
                                    value: gender.key,
                                    child: Text("${gender.value}"),
                                  ))
                              .toList(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: (provider.status == WorkStatus.None ||
                                      provider.status == WorkStatus.Error)
                                  ? MaterialButton(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      child: Text(
                                        "Modifier Profil",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        _formKey.currentState!.save();
                                        if (_formKey.currentState!.validate()) {
                                          print(_formKey.currentState!.value);
                                          provider.formData = Map.from(
                                              _formKey.currentState!.value);
                                          await provider.doUpdateProfile();
                                          // Get.toNamed("/user_profile_page");
                                        } else {
                                          print("validation failed");
                                        }
                                      },
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.orange,
                                      backgroundColor: Colors.blue,
                                    )),
                            ),
                          ],
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      );
    }));
  }
}

class ApiImage {
  final String imageUrl;
  final String id;
  ApiImage({
    required this.imageUrl,
    required this.id,
  });
}
