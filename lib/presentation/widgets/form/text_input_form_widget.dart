import 'package:flutter/material.dart';

class BoxText extends StatefulWidget {
  const BoxText({
    super.key,
    required this.controll,
    this.boolActive = true,
    required this.text,
    this.iconSuffix,
    this.functionIcon,
    required this.keyboardType,
    this.functionDniHc,
    required this.limit,
  });

  final TextEditingController controll;
  final bool boolActive;
  final String text;
  final Widget? iconSuffix;
  final VoidCallback? functionIcon;
  final TextInputType keyboardType;
  final Function(String)? functionDniHc;
  final int limit;

  @override
  State<BoxText> createState() => _BoxTextState();
}

class _BoxTextState extends State<BoxText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controll,
      enabled: widget.boolActive,
      keyboardType: widget.keyboardType,
      style: const TextStyle(fontSize: 14),
      maxLength: widget.limit,
      decoration: InputDecoration(
        counter: const Offstage(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        labelText: widget.text,
        suffixIcon: widget.iconSuffix != null
            ? IconButton(
                icon: widget.iconSuffix!, onPressed: widget.functionIcon)
            : null,
      ),
      onChanged: widget.functionDniHc,
    );
  }
}
