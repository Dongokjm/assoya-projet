import 'package:assoya/models/api_image.dart';
import 'package:assoya/models/vehicule.dart';
import 'package:assoya/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VehiculeForm extends StatefulWidget {
  Vehicule? vehicule;
  VehiculeForm({Key? key}) : super(key: key);

  @override
  _VehiculeFormState createState() => _VehiculeFormState();
}

class _VehiculeFormState extends State<VehiculeForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  final genderOptions = ["essence", "gasoil"];
  final typeBoites = ["boite automatique", "boite manuelle"];

  @override
  void initState() {
    // TODO: implement initState
    if (Get.arguments != null) {
      widget.vehicule = Get.arguments;
    } else {
      widget.vehicule = Vehicule();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            Get.arguments != null
                ? "Modifier ${widget.vehicule!.marque} - ${widget.vehicule!.modele}"
                : "Enregistrer véhicule",
            style: TextStyle(color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: FormBuilder(
                    key: _formKey,
                    initialValue: Get.arguments != null
                        ? widget.vehicule!.toFormJson()
                        : {},
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'marque',
                          decoration: InputDecoration(
                            labelText: 'Marque',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        FormBuilderTextField(
                          name: 'modele',
                          decoration: InputDecoration(
                            labelText: 'Modèle',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        FormBuilderTextField(
                          name: 'couleur',
                          decoration: InputDecoration(
                            labelText: 'Couleur',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        FormBuilderTextField(
                          name: 'immatriculation',
                          decoration: InputDecoration(
                            labelText: 'Matricule',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        FormBuilderDateTimePicker(
                          name: 'date_mise_en_service',
                          inputType: InputType.date,
                          format: DateFormat('yyyy-MM-dd'),
                          decoration: InputDecoration(
                            labelText: 'Date de mise en circulation',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        FormBuilderTextField(
                          name: 'nombre_place',
                          decoration: InputDecoration(
                            labelText: 'Nombre de places',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(context, 6),
                          ]),
                        ),
                        FormBuilderImagePicker(
                          name: 'photo',
                          decoration: const InputDecoration(
                              labelText: 'Image du véhicule'),
                          maxImages: 1,
                          displayCustomType: (obj) =>
                              obj is ApiImage ? obj.imageUrl : obj,
                          initialValue: [
                            ApiImage(
                              id: 'whatever',
                              imageUrl:
                                  'https://s1.cdn.autoevolution.com/images/gallery/MAZDA-6-Atenza-Sedan-3321_10.jpg',
                            ),
                          ],
                        ),
                        FormBuilderTextField(
                          name: 'annee_utilisation',
                          decoration: InputDecoration(
                            labelText: 'Année',
                          ),
                          onChanged: (value) {},
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.numeric(context),
                            FormBuilderValidators.max(
                                context, DateTime.now().year),
                          ]),
                          keyboardType: TextInputType.number,
                        ),
                        FormBuilderDropdown(
                          name: 'type_carburant',
                          decoration: InputDecoration(
                            labelText: 'Carburant',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Selectioner type carburant'),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: genderOptions
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text('$gender'),
                                  ))
                              .toList(),
                        ),
                        FormBuilderTextField(
                          name: 'ptac',
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'PTAC (Poids Total accepté)',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                          ]),
                        ),
                        FormBuilderDropdown(
                          name: 'type_boite',
                          decoration: InputDecoration(
                            labelText: 'Type de Boîte',
                          ),
                          // initialValue: 'Male',
                          allowClear: true,
                          hint: Text('Selectioner type de boîte'),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          items: typeBoites
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text('$gender'),
                                  ))
                              .toList(),
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
                                        "Terminer",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        _formKey.currentState!.save();
                                        if (_formKey.currentState!.validate()) {
                                          print(_formKey
                                              .currentState!.value['photo']);
                                          if (Get.arguments != null) {
                                            await provider.updateVehicule(
                                                _formKey.currentState!.value,
                                                widget.vehicule!.id!);
                                          } else {
                                            await provider.storeVehicule(
                                                _formKey.currentState!.value);
                                          }
                                          await provider.fetchCars();
                                          Get.toNamed("/vehicule_list");
                                        } else {
                                          print("validation failed");
                                        }
                                      },
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ),

                            // Expanded(
                            //   child: MaterialButton(
                            //     color: Theme.of(context).colorScheme.secondary,
                            //     child: Text(
                            //       "Reset",
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //     onPressed: () {
                            //       _formKey.currentState!.reset();
                            //     },
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      );
    });
  }
}
