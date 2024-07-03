import 'package:flutter/material.dart';

class custom_textfeild extends StatelessWidget {
  final String? labelText;
  final String? hinText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? icon;
  final TextInputType keyboardType;

  const custom_textfeild({
    Key? key,
    this.labelText,
    this.controller,
    this.hinText,
    this.icon,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hinText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: icon != null ? Icon(icon) : null,
      ),
    );
  }
}
