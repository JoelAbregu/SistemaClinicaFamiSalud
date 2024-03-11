import 'package:flutter/material.dart';
import 'package:registro_diario_mobil_1_0_1/shared/cie10.dart';
import 'package:registro_diario_mobil_1_0_1/shared/user_data.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';

class SearchDropdown extends StatefulWidget {
 
  final void Function(int?)? onChanged;
  const SearchDropdown({
    super.key,
    this.onChanged,
 
  });

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color.fromARGB(255, 0, 0, 0),
            width: 0.5,
          )),
      child: SearchableDropdown<int>(
        hintText: const Text('Diagnostico'),
        margin: const EdgeInsets.all(15),
        items: List.generate(
            cie10Data.length,
            (i) => SearchableDropdownMenuItem(
                value: i,
                label: cie10Data[i].code,
                child: Text(cie10Data[i].code))),
        onChanged: (int? value) {
          widget.onChanged?.call(value);
          FormData;
        },
      ),
    );
  }
}
