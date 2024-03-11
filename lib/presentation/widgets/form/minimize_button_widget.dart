import 'package:flutter/material.dart';

class MinimizeButton extends StatelessWidget {
  final VoidCallback function;
  const MinimizeButton({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: function,
            child: const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.red,
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
