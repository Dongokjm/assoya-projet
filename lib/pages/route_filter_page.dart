import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RouteFilterPage extends StatefulWidget {
  const RouteFilterPage({Key? key}) : super(key: key);

  @override
  _RouteFilterPageState createState() => _RouteFilterPageState();
}

class _RouteFilterPageState extends State<RouteFilterPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, bool> departs = {
    'Adjamé-Abobo': true,
    'Abobo-Cocody': false,
    'Treichville-Cocody': true,
    'Abobo-Yopougon': false,
  };

  Map<String, bool> heures = {
    'Avant 6:00': true,
    '6:00-12:00': false,
    '12:00-18:00': true,
    'Après 18:00': true,
  };

  Map<String, bool> destinations = {
    'Adjamé-Abobo': true,
    'Abobo-Cocody': false,
    'Treichville-Cocody': true,
    'Abobo-Yopougon': false,
  };

  Map<String, bool> prefs_conducteur = {
    'Animaux autorisé': true,
    'Non-fumeur': false,
    'Pièce vérifié': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Affinez votre recherche",
          style: TextStyle(color: Colors.blue),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderChoiceChip(
                      name: 'filter_chip',
                      decoration: InputDecoration(
                        labelText: "Départs",
                      ),
                      options: departs.keys.map((e) {
                        return FormBuilderFieldOption(
                            value: '${e}', child: Text('${e}'));
                      }).toList(),
                    ),
                    FormBuilderFilterChip(
                      name: 'choice_chip',
                      decoration: InputDecoration(
                        labelText: 'Heure de départ',
                      ),
                      options: heures.keys.map((e) {
                        return FormBuilderFieldOption(
                            value: '${e}', child: Text('${e}'));
                      }).toList(),
                    ),
                    FormBuilderChoiceChip(
                      name: 'filter_chip',
                      decoration: InputDecoration(
                        labelText: "Destinations",
                      ),
                      options: destinations.keys.map((e) {
                        return FormBuilderFieldOption(
                            value: '${e}', child: Text('${e}'));
                      }).toList(),
                    ),
                    FormBuilderSlider(
                      name: 'Note conducteur',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.min(context, 6),
                      ]),
                      onChanged: (value) {},
                      min: 0.0,
                      max: 10.0,
                      initialValue: 7.0,
                      divisions: 20,
                      activeColor: Colors.orange,
                      inactiveColor: Colors.blue[100],
                      decoration: InputDecoration(
                        labelText: 'Note du conducteur',
                      ),
                    ),
                    FormBuilderFilterChip(
                      name: 'choice_chip',
                      decoration: InputDecoration(
                        labelText: 'Heure de départ',
                      ),
                      options: prefs_conducteur.keys.map((e) {
                        return FormBuilderFieldOption(
                            value: '${e}', child: Text('${e}'));
                      }).toList(),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            color: Theme.of(context).colorScheme.secondary,
                            child: Text(
                              "Filtrer",
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
                        SizedBox(width: 20),
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
                ))
          ],
        ),
      ),
    );
  }
}
