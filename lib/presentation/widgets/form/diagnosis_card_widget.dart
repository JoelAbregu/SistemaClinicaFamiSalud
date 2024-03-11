import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
 
import 'text_input_form_widget.dart';

class CardDiagnostico extends StatefulWidget {
  final String diagnostico;
  final TextEditingController controllerProcedimiento1;
  final TextEditingController controllerProcedimiento2;
  final void Function(dynamic)? diagnosticoProbabilidad;
  final void Function(dynamic)? examen1;
  final void Function(dynamic)? examen2;
  final RadioGroupController diagnosticoProbabilidadController;
  final RadioGroupController examen1Controller;
  final RadioGroupController examen2Controller;
  final Widget minimize;
  final int indexDefault;
  final Widget dropDown;
  final String diagnosisDescription;

  const CardDiagnostico({
    super.key,
    required this.diagnostico,
    required this.examen1,
    required this.examen2,
    required this.controllerProcedimiento1,
    required this.controllerProcedimiento2,
    required this.diagnosticoProbabilidad,
    this.minimize = const SizedBox(height: 5),
    this.indexDefault = -1,
    required this.diagnosticoProbabilidadController,
    required this.examen1Controller,
    required this.examen2Controller,
    required this.dropDown,
    required this.diagnosisDescription,
  });

  @override
  State<CardDiagnostico> createState() => _CardDiagnosticoState();
}

class _CardDiagnosticoState extends State<CardDiagnostico> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.2,
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 242, 188, 11),
                Color.fromARGB(255, 255, 207, 51),
              ])),
      child: Column(
        children: [
          widget.minimize,
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
            child: Column(
              children: [
                widget.dropDown,
                const SizedBox(height: 5),
                Text(
                  widget.diagnosisDescription,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                const SizedBox(height: 10),
                RadioGroup(
                  controller: widget.diagnosticoProbabilidadController,
                  values: const ["Definitivo", "Presuntivo"],
                  indexOfDefault: widget.indexDefault,
                  orientation: RadioGroupOrientation.horizontal,
                  onChanged: (value) {
                    widget.diagnosticoProbabilidad!(value);
                  },
                  decoration: const RadioGroupDecoration(
                    spacing: 10.0,
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    activeColor: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                _buildContainer(
                  controller: widget.controllerProcedimiento1,
                  onChanged: widget.examen1,
                  controllerRadio: widget.examen1Controller,
                ),
                const SizedBox(height: 15),
                _buildContainer(
                  controller: widget.controllerProcedimiento2,
                  onChanged: widget.examen2,
                  controllerRadio: widget.examen2Controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer({
    required TextEditingController controller,
    required void Function(dynamic)? onChanged,
    required RadioGroupController controllerRadio,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.2,
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ], borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            RadioGroup(
              controller: controllerRadio,
              values: const ["Eco", "Far", "Lab", "Rx"],
              indexOfDefault: widget.indexDefault,
              orientation: RadioGroupOrientation.horizontal,
              onChanged: (value) {
                onChanged!(value);
              },
              decoration: const RadioGroupDecoration(
                spacing: 10.0,
                labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                activeColor: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            BoxText(
              controll: controller,
              text: "Procedimiento",
              keyboardType: TextInputType.text,
              limit: 100,
            ),
          ],
        ),
      ),
    );
  }
}
