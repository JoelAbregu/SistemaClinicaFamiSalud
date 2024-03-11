// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../config/theme/apptheme.dart';
import '../../shared/user_data.dart';
import 'home_screen.dart';

class FormUltrasoundsCScreen extends StatefulWidget {
  const FormUltrasoundsCScreen({super.key});

  @override
  State<FormUltrasoundsCScreen> createState() => _FormUltrasoundsCScreenState();
}

class _FormUltrasoundsCScreenState extends State<FormUltrasoundsCScreen> {
  DateTime selectedDate = DateTime.now();
  String dateString = '';
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    formatDate();
    formatDateDB();
    assignTurno();
    FormData.diagnosisDescription1 = '';
    FormData.diagnosisDescription2 = '';
    FormData.diagnosisDescription3 = '';
  }

  void formatDate() {
    initializeDateFormatting('es_ES', null);
    final formatter = DateFormat('MMMM dd \'del\' yyyy', 'es_ES');
    dateString = formatter.format(selectedDate);
    dateString = dateString.substring(0, 1).toUpperCase() +
        dateString.substring(1).toLowerCase();
  }

  void assignTurno() {
    int currentHour = currentTime.hour;
    if (currentHour >= 7 && currentHour < 19) {
      DataDB.turno = 'Mañana';
    } else {
      DataDB.turno = 'Tarde';
    }
  }

  void formatDateDB() {
    final formatter = DateFormat('yyyy-MM-dd');
    dateString = formatter.format(selectedDate);
    DataDB.fecha = dateString;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 95,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.2,
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    gradient: LinearGradient(
                      colors: AppTheme.colorGradient,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen())),
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white, size: 23)),
                        const Spacer(),
                        Column(
                          children: [
                            Lottie.asset(FormData.image, height: 55),
                            const SizedBox(height: 10),
                            Text(
                              dateString,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const SizedBox(
                          width: 38,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
