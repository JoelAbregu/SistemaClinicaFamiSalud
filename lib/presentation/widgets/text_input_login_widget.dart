import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    super.key,
    required this.control,
    required this.hintext,
    required this.keyboard,
    required this.limit,
    required this.oscurePassword,
 
  });

  final TextEditingController control;
  final String hintext;
  final TextInputType keyboard;
  final int limit;
  final bool oscurePassword;
 
  @override
  Widget build(BuildContext context) {
    final inputStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        style: BorderStyle.solid,
        width: 2,
        color: Colors.white,
      ),
    );
    return TextFormField(
      keyboardType: keyboard,
      controller: control,
      maxLength: limit,
      obscureText: oscurePassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: hintext,
        hintStyle: const TextStyle(color: Colors.white),
        counter: const Offstage(),
        enabledBorder: inputStyle,
        focusedBorder: inputStyle,
        border: inputStyle,
      ),
    );
  }
}
