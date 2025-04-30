import 'package:flutter/material.dart';

class InputData extends StatelessWidget {
  final TextInputType type;
  final String hintText;
  final String labelText;
  final bool isPassword;
  final void Function(String?) saved;
  final String? Function(String?) extraValidate;

  const InputData({
    super.key,
    required this.type,
    required this.hintText,
    required this.labelText,
    required this.isPassword,
    required this.saved,
    required this.extraValidate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      keyboardType: type,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return "This field is required";
        }
        if (val.length < 6) {
          return "Less Characters";
        }
        return extraValidate(val);
      },
      onSaved: saved,
    );
  }
}
