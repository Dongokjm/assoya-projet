import 'package:assoya/models/api_image.dart';
import 'package:assoya/providers/auth_provider.dart';
import 'package:assoya/widgets/drawer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:provider/provider.dart';

class UserDocsForm extends StatefulWidget {
  const UserDocsForm({Key? key}) : super(key: key);

  @override
  _UserDocsFormState createState() => _UserDocsFormState();
}

class _UserDocsFormState extends State<UserDocsForm> {
  final _docFilekey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: ((context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     DrawerCard(
                //       title: "2",
                //       pressed: () {},
                //       icon: Icons.document_scanner,
                //       subtitle: "Documents d'identité",
                //     ),
                //     DrawerCard(
                //       title: "1",
                //       pressed: () {},
                //       icon: Icons.chrome_reader_mode,
                //       subtitle: "Documents des véhicules",
                //     ),
                //   ],
                // ),
                FormBuilder(
                  key: _docFilekey,
                  child: Column(
                    children: [
                      FormBuilderFilePicker(
                        name: "cni",
                        type: FileType.image,
                        decoration: InputDecoration(
                            labelText: "CNI",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        maxFiles: 2,
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
                      FormBuilderFilePicker(
                        type: FileType.image,
                        name: "permis",
                        decoration: InputDecoration(
                            labelText: "Permis de Conduire",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        maxFiles: 2,
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: (provider.status == WorkStatus.None ||
                              provider.status == WorkStatus.Error)
                          ? MaterialButton(
                              color: Theme.of(context).colorScheme.primary,
                              child: Text(
                                "Modifier",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                _docFilekey.currentState!.save();
                                if (_docFilekey.currentState!.validate()) {
                                  if (_docFilekey
                                          .currentState!.value["cni"].length >
                                      0) {
                                    provider.formData["cni_recto"] = _docFilekey
                                        .currentState!.value["cni"][0];
                                    provider.formData["cni_verso"] = _docFilekey
                                        .currentState!.value["cni"][1];
                                  }
                                  if (_docFilekey.currentState!.value["permis"]
                                          .length >
                                      0) {
                                    provider.formData["permis_recto"] =
                                        _docFilekey
                                            .currentState!.value["permis"][0];
                                    provider.formData["permis_verso"] =
                                        _docFilekey
                                            .currentState!.value["permis"][1];
                                  }
                                  print(_docFilekey.currentState!.value);
                                  provider.formData =
                                      Map.from(_docFilekey.currentState!.value);
                                  await provider.doUpdateProfile();
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
            ),
          ),
        ),
      );
    }));
  }
}
