import 'package:flutter/material.dart';
class ButtonDegrade extends StatelessWidget {
  final List<Color> colors;
  final double padding;
  final String text;
  final VoidCallback function;
  const ButtonDegrade({
    super.key,
    required this.colors,
    required this.text,
    required this.function,   this.padding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: LinearGradient(colors: colors)),
        child: Padding(
          padding:   EdgeInsets.symmetric(vertical: padding),
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
 