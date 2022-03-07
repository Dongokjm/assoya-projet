import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class MyInputField extends StatelessWidget {
  String? label;
  String? name;
  String? hint;
  bool? obscur = false;
  TextInputType? type;
  dynamic validator;
  TextInputFormatter? formatter;
  TextEditingController? controller;

  MyInputField(
      {Key? key,
      this.hint,
      this.label,
      this.name,
      this.obscur,
      this.type,
      this.validator,
      this.formatter,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: Colors.blue,
                // set border color
                width: 1.0),
            // set border width
            borderRadius: const BorderRadius.all(
                Radius.circular(10.0)), // set rounded corner radius
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: formatter != null
                ? FormBuilderTextField(
                    keyboardType: type,
                    obscureText: obscur!,
                    inputFormatters: [formatter!],
                    controller: controller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusColor: Colors.white,
                        hintText: hint!,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                    name: name!,
                  )
                : FormBuilderTextField(
                    keyboardType: type,
                    obscureText: obscur!,
                    controller: controller,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusColor: Colors.white,
                        hintText: hint!,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15)),
                    name: name!,
                  ),
          ),
        )
      ],
    );
  }
}
