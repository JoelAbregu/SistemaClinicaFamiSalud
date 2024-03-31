// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../config/theme/apptheme.dart';
import '../../helpers/data.dart';

import '../../helpers/data_base_querys.dart';
import '../../shared/user_data.dart';
import '../widgets/card_report_widget.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
    initializeDateFormatting('es_ES');
    DataDB.doctorId = UserData.id;
    fetchReports();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _scrollToSelectedDate();
    });
    fetchReports();
  }

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(_selectedDate.year - 1),
      lastDate: DateTime(_selectedDate.year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      _selectDate(picked);
      fetchReports();
    }
  }

  void _scrollToSelectedDate() {
    const double dayWidth = 68;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double totalWidth =
        DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day * dayWidth;
    final double scrollTo =
        ((_selectedDate.day - 1) * dayWidth + dayWidth / 2 - screenWidth / 2)
            .clamp(0.0, totalWidth - screenWidth);
    _scrollController.jumpTo(scrollTo);
  }

  String _getMonthName(DateTime date) {
    const List<String> months = [
      '',
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre'
    ];
    return months[date.month];
  }

  int? nReportEmergency;
  int? nReportAmbulatory;

// Define una función para realizar la consulta y actualizar el estado
  Future<void> fetchReports() async {
    final formatter = DateFormat('yyyy-MM-dd');
    String date = formatter.format(_selectedDate);

    setState(() {
      nReportEmergency = null;
      nReportAmbulatory = null;
    });

    // Realiza las consultas
    nReportEmergency = await DataBaseQuerys()
        .countRecordsByDateAndTypeAttention(date, "Emergencia", UserData.id);
    nReportAmbulatory = await DataBaseQuerys()
        .countRecordsByDateAndTypeAttention(date, "Ambulatorio", UserData.id);
    // Actualiza la interfaz de usuario con los resultados de la consulta
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppTheme.colorPrimary, // Cambia el color aquí
    ));
    final query = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: query.size.height * 0.02),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: query.size.width * 0.05),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          UserData.specialty,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        Text(
                          UserData.lastName,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      icon: const Icon(Icons.exit_to_app_outlined, size: 30),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      DateTime(_selectedDate.year, _selectedDate.month + 1, 0)
                          .day,
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final date =
                        DateTime(_selectedDate.year, _selectedDate.month, day);
                    final isSelected = _selectedDate.day == day;
                    return GestureDetector(
                      onTap: () async {
                        _selectDate(date);
                        fetchReports();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6, vertical: isSelected ? 15 : 25),
                        child: Container(
                          width: isSelected ? 65 : 55,
                          alignment: Alignment.center,
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
                            gradient: LinearGradient(
                              colors: isSelected
                                  ? AppTheme.colorGradient
                                  : [
                                      AppTheme.colorTertiary,
                                      AppTheme.colorTertiary
                                    ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            color: isSelected
                                ? AppTheme.colorPrimary
                                : AppTheme.colorTertiary,
                          ),
                          child: Text(
                            day.toString(),
                            style: TextStyle(
                              fontSize: isSelected ? 22 : 17,
                              fontWeight: isSelected
                                  ? FontWeight.w400
                                  : FontWeight.w300,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_getMonthName(_selectedDate)} ${_selectedDate.year}",
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 20),
                  CircleAvatar(
                    child: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDateFromPicker(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CardReport(
                      query: query,
                      title: 'Emergencia',
                      image: "assets/lottie/emergencia.json",
                      function: () => _navigateToFormScreen("Emergencia"),
                      numberReport: nReportEmergency == null
                          ? CircularProgressIndicator(
                              color: AppTheme.colorPrimary, strokeWidth: 1.5)
                          : Text(
                              nReportEmergency.toString(),
                              style: TextStyle(
                                color: AppTheme.colorPrimary,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    const SizedBox(height: 30),
                    CardReport(
                      query: query,
                      title: 'Ambulatorio',
                      image: "assets/lottie/ambulatorio.json",
                      function: () => _navigateToFormScreen("Ambulatorio"),
                      numberReport: nReportAmbulatory == null
                          ? CircularProgressIndicator(
                              color: AppTheme.colorPrimary, strokeWidth: 1)
                          : Text(
                              nReportAmbulatory.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: AppTheme.colorPrimary,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToFormScreen(String type) {
    DataDB.tipoAtencion = type;
    FormData.image = "assets/lottie/${type.toLowerCase()}.json";
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return FormScreen();
    }));
    Data.initData();
  }
}
