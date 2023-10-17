import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  CustomText(
      {required this.text,
      required this.textType,
      required this.starOrNot,
      this.onChanged});

  String text;
  TextInputType textType;
  bool starOrNot;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) return 'This Field is Required';
        },
        onChanged: onChanged,
        keyboardType: textType,
        obscureText: starOrNot,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
