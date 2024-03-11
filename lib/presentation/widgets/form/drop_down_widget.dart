import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatefulWidget {
  final List<String> list;
  final String title;
  final Function(String?)? onChanged;

  const DropdownMenuWidget({
    super.key,
    required this.list,
    required this.title,
    this.onChanged,
  });

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  String dropdownValue = '';
  @override
  void initState() {
    //
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return DropdownMenu<String>(
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
          widget.onChanged?.call(value);
        });
      },
      label: Text(
        widget.title,
        style: const TextStyle(fontSize: 14),
      ),
      width: query.size.width * 0.9,
      
      textStyle: const TextStyle(fontSize: 14),
      inputDecorationTheme: InputDecorationTheme(
        
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      dropdownMenuEntries:
          widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
