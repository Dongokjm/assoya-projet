import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class UserPreferencesForm extends StatefulWidget {
  const UserPreferencesForm({Key? key}) : super(key: key);

  @override
  _UserPreferencesFormState createState() => _UserPreferencesFormState();
}

class _UserPreferencesFormState extends State<UserPreferencesForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Mes Préférences",
              style: TextStyle(fontSize: 20),
            ),
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  FormBuilderCheckboxGroup(name: "preferences", options: [
                    FormBuilderFieldOption(
                      value: "0",
                      child: Text("Pas d'animaux"),
                    ),
                    FormBuilderFieldOption(
                      value: "1",
                      child: Text("Pas de fumeurs"),
                    ),
                    FormBuilderFieldOption(
                      value: "3",
                      child: Text("Pas de bagages"),
                    ),
                  ]),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).colorScheme.primary,
                          child: Text(
                            "Modifier",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              print(_formKey.currentState!.value);
                            } else {
                              print("validation failed");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MaterialButton(
                          color: Theme.of(context).colorScheme.secondary,
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _formKey.currentState!.reset();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
