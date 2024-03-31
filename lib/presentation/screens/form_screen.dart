// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:registro_diario_mobil_1_0_1/config/theme/apptheme.dart';
import 'package:registro_diario_mobil_1_0_1/helpers/data.dart';
import 'package:registro_diario_mobil_1_0_1/presentation/provider/connection_provider.dart';
import 'package:registro_diario_mobil_1_0_1/shared/cie10.dart';
import 'package:registro_diario_mobil_1_0_1/shared/user_data.dart';
import 'package:status_alert/status_alert.dart';
import '../../helpers/data_base_querys.dart';
import '../../helpers/api_querys.dart';
import '../widgets/form/text_input_form_widget.dart';
import '../widgets/form/cie.dart';
import '../widgets/form/diagnosis_card_widget.dart';
import '../widgets/form/drop_down_widget.dart';
import '../widgets/form/minimize_button_widget.dart';
import 'home_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({
    super.key,
  });

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
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

  //todo Controllers
  final controllResponsable =
      TextEditingController(text: "${UserData.firstName} ${UserData.lastName}");
  final controllEspecialidad = TextEditingController(text: UserData.specialty);
  final controllHc = TextEditingController();
  final controllDni = TextEditingController();
  final controllNombrePaciente = TextEditingController();
  final controllEdadAnos = TextEditingController();
  final controllEdadMeses = TextEditingController();
  final controllDiagnostico1 = TextEditingController();
  final controllDiagnostico2 = TextEditingController();
  final controllDiagnostico3 = TextEditingController();
  final controllProcedimiento1_1 = TextEditingController();
  final controllProcedimiento1_2 = TextEditingController();
  final controllProcedimiento2_1 = TextEditingController();
  final controllProcedimiento2_2 = TextEditingController();
  final controllProcedimiento3_1 = TextEditingController();
  final controllProcedimiento3_2 = TextEditingController();

  //todo Controllers Radio Group
  final controllTurno = RadioGroupController();
  final controllSexo = RadioGroupController();
  final controllDiagnosticoProbabilidad1 = RadioGroupController();
  final controllDiagnosticoProbabilidad2 = RadioGroupController();
  final controllDiagnosticoProbabilidad3 = RadioGroupController();
  final controllExamen1_1 = RadioGroupController();
  final controllExamen1_2 = RadioGroupController();
  final controllExamen2_1 = RadioGroupController();
  final controllExamen2_2 = RadioGroupController();
  final controllExamen3_1 = RadioGroupController();
  final controllExamen3_2 = RadioGroupController();

  bool boolResponsable = false;
  bool boolEspecialidad = false;
  bool boolFecha = false;
  bool boolHc = true;
  bool boolDni = true;
  int counterDiagnosis = 1;
  bool visibilityD2 = false;
  bool visibilityD3 = false;
  int indexDefaultRadio = -1;

  double fontSize = 14;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppTheme.colorPrimary, // Cambia el color aquí
    ));
    final query = MediaQuery.of(context);
    final providerConectivity = context.watch<ConnectionProvider>();
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: query.size.width * 0.05),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              boolResponsable = true;
                            });
                          },
                          child: BoxText(
                            controll: controllResponsable,
                            boolActive: boolResponsable,
                            text: "Responsable de atención",
                            keyboardType: TextInputType.text,
                            limit: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              boolEspecialidad = true;
                            });
                          },
                          child: BoxText(
                            controll: controllEspecialidad,
                            boolActive: boolEspecialidad,
                            text: "Especialidad",
                            keyboardType: TextInputType.text,
                            limit: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    boolHc = true;
                                  });
                                },
                                child: BoxText(
                                  boolActive: boolHc,
                                  controll: controllHc,
                                  text: 'H.C',
                                  keyboardType: TextInputType.number,
                                  functionDniHc: (value) {
                                    if (controllHc.text.length == 7) {
                                      setState(() {
                                        boolDni = false;
                                        controllDni.clear();
                                      });
                                    }
                                  },
                                  limit: 7,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    boolDni = true;
                                  });
                                },
                                child: BoxText(
                                  boolActive: boolDni,
                                  controll: controllDni,
                                  text: 'D.N.I',
                                  keyboardType: TextInputType.number,
                                  functionDniHc: (value) {
                                    if (controllDni.text.length == 8) {
                                      boolHc = false;
                                      controllHc.clear();
                                      consultDNIData(controllDni.text)
                                          .then((names) {
                                        if (names != null) {
                                          setState(() {
                                            controllNombrePaciente.text = names;
                                          });
                                        } else {
                                          return;
                                        }
                                      });
                                    }
                                  },
                                  limit: 8,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        BoxText(
                          controll: controllNombrePaciente,
                          text: "Nombres del paciente",
                          keyboardType: TextInputType.text,
                          limit: 30,
                        ),
                        const SizedBox(height: 10),
                        DropdownMenuWidget(
                          list: const [
                            "Particular",
                            "Rimac",
                            "Pacifico",
                            "La positiva",
                            "Mafre",
                            "La protectora",
                            "F.A.P",
                            "Fopasef",
                            "Chubb",
                            "Otro"
                          ],
                          title: 'Financiamiento',
                          onChanged: (String? value) {
                            DataDB.financiacion = value ?? '';
                          },
                        ),
                        const SizedBox(height: 15),
                        DropdownMenuWidget(
                          list: const [
                            "Pisco",
                            "San Andrés",
                            "San Clemente",
                            "Túpac Amaru Inca",
                            "Huancano",
                            "Humay",
                            "Independencia",
                            "Paracas",
                            "Otro"
                          ],
                          title: 'Distrito de procedencia ',
                          onChanged: (String? value) {
                            DataDB.distrito = value ?? '';
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: BoxText(
                                controll: controllEdadAnos,
                                text: "Edad (años)",
                                keyboardType: TextInputType.number,
                                limit: 2,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: BoxText(
                                controll: controllEdadMeses,
                                text: "Edad (meses)",
                                keyboardType: TextInputType.number,
                                limit: 2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Sexo",
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.w500),
                        ),
                        RadioGroup(
                          controller: controllSexo,
                          values: const ["Masculino", "Femenino"],
                          indexOfDefault: -1,
                          orientation: RadioGroupOrientation.horizontal,
                          onChanged: (value) {
                            DataDB.genero = value.toString();
                          },
                          decoration: RadioGroupDecoration(
                            spacing: 10.0,
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: fontSize),
                            activeColor: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CardDiagnostico(
                          diagnostico: DataDB.diagnostico1,
                          controllerProcedimiento1: controllProcedimiento1_1,
                          controllerProcedimiento2: controllProcedimiento1_2,
                          indexDefault: indexDefaultRadio,
                          diagnosticoProbabilidad: (value) {
                            DataDB.probabilidadDiagnostico1 = value;
                          },
                          examen1: (value) {
                            DataDB.examen1_1 = value;
                          },
                          examen2: (value) {
                            DataDB.examen1_2 = value;
                          },
                          diagnosticoProbabilidadController:
                              controllDiagnosticoProbabilidad1,
                          examen1Controller: controllExamen1_1,
                          examen2Controller: controllExamen1_2,
                          dropDown: SearchDropdown(
                            onChanged: (value) {
                              setState(() {
                                DataDB.diagnostico1 =
                                    value != null ? cie10Data[value].code : '';
                                FormData.diagnosisDescription1 = value != null
                                    ? cie10Data[value].description
                                    : '';
                              });
                            },
                          ),
                          diagnosisDescription: FormData.diagnosisDescription1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AnimatedOpacity(
                          opacity: visibilityD2 ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut,
                          child: Visibility(
                            visible: visibilityD2,
                            child: Column(
                              children: [
                                CardDiagnostico(
                                  diagnostico: DataDB.diagnostico2,
                                  controllerProcedimiento1:
                                      controllProcedimiento2_1,
                                  controllerProcedimiento2:
                                      controllProcedimiento2_2,
                                  indexDefault: indexDefaultRadio,
                                  diagnosticoProbabilidadController:
                                      controllDiagnosticoProbabilidad2,
                                  examen1Controller: controllExamen2_1,
                                  examen2Controller: controllExamen2_2,
                                  minimize: MinimizeButton(
                                    function: () {
                                      setState(() {
                                        visibilityD2 = false;
                                        counterDiagnosis--;
                                      });
                                    },
                                  ),
                                  diagnosticoProbabilidad: (value) {
                                    DataDB.probabilidadDiagnostico2 = value;
                                  },
                                  examen1: (value) {
                                    DataDB.examen2_1 = value;
                                  },
                                  examen2: (value) {
                                    DataDB.examen2_2 = value;
                                  },
                                  dropDown: SearchDropdown(
                                    onChanged: (value) {
                                      setState(() {
                                        DataDB.diagnostico2 = value != null
                                            ? cie10Data[value].code
                                            : '';
                                        FormData.diagnosisDescription2 =
                                            value != null
                                                ? cie10Data[value].description
                                                : '';
                                      });
                                    },
                                  ),
                                  diagnosisDescription:
                                      FormData.diagnosisDescription2,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: visibilityD2 ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut,
                          child: Visibility(
                            visible: visibilityD3,
                            child: Column(
                              children: [
                                CardDiagnostico(
                                  diagnostico: DataDB.diagnostico3,
                                  controllerProcedimiento1:
                                      controllProcedimiento3_1,
                                  controllerProcedimiento2:
                                      controllProcedimiento3_2,
                                  indexDefault: indexDefaultRadio,
                                  diagnosticoProbabilidadController:
                                      controllDiagnosticoProbabilidad3,
                                  examen1Controller: controllExamen3_1,
                                  examen2Controller: controllExamen3_2,
                                  minimize: MinimizeButton(
                                    function: () {
                                      setState(() {
                                        visibilityD3 = false;
                                        counterDiagnosis--;
                                      });
                                    },
                                  ),
                                  diagnosticoProbabilidad: (value) {
                                    DataDB.probabilidadDiagnostico3 = value;
                                  },
                                  examen1: (value) {
                                    DataDB.examen3_1 = value;
                                  },
                                  examen2: (value) {
                                    DataDB.examen3_2 = value;
                                  },
                                  dropDown: SearchDropdown(
                                    onChanged: (value) {
                                      setState(() {
                                        DataDB.diagnostico3 = value != null
                                            ? cie10Data[value].code
                                            : '';
                                        FormData.diagnosisDescription3 =
                                            value != null
                                                ? cie10Data[value].description
                                                : '';
                                      });
                                    },
                                  ),
                                  diagnosisDescription:
                                      FormData.diagnosisDescription3,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: query.size.width * 0.9,
                          child: Row(
                            children: [
                              ButtonIcon(
                                query: query,
                                function: () {
                                  setState(() {
                                    if (counterDiagnosis == 1) {
                                      visibilityD2 = true;
                                      counterDiagnosis++;
                                    } else if (counterDiagnosis == 2) {
                                      visibilityD3 = true;
                                      counterDiagnosis++;
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: Colors.black,
                                          content: Text(
                                            "Ya no puedes añadir mas diagnosticos",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                },
                                icon: Icons.add_circle_outline_sharp,
                                width: 0.2,
                                color: const Color(0xffFFC500),
                              ),
                              const Spacer(),
                              ButtonIcon(
                                query: query,
                                function: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.red,
                                          strokeWidth: 2,
                                        ),
                                      );
                                    },
                                  );
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FormScreen()),
                                    );
                                  });
                                },
                                icon: Icons.delete,
                                width: 0.2,
                                color: const Color(0xffBE0606),
                              ),
                              const Spacer(),
                              ButtonIcon(
                                query: query,
                                function: () {
                                  if (providerConectivity.connection == false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.black,
                                        content: Text(
                                          "Verifica tu conexión",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  } else if (controllResponsable
                                          .text.isNotEmpty &&
                                      DataDB.turno.isNotEmpty &&
                                      controllNombrePaciente.text.isNotEmpty &&
                                      DataDB.financiacion.isNotEmpty &&
                                      DataDB.distrito.isNotEmpty &&
                                      controllEdadAnos.text.isNotEmpty &&
                                      DataDB.genero.isNotEmpty &&
                                      DataDB.diagnostico1.isNotEmpty &&
                                      (controllDni.text.isNotEmpty ||
                                          controllHc.text.isNotEmpty)) {
                                    DataDB.responsable =
                                        controllResponsable.text;
                                    DataDB.especialidad =
                                        controllEspecialidad.text;
                                    DataDB.dni = controllDni.text;
                                    DataDB.hc = controllHc.text;
                                    DataDB.nombrePaciente =
                                        controllNombrePaciente.text;
                                    DataDB.edadAnos = controllEdadAnos.text;
                                    DataDB.edadMeses = controllEdadMeses.text;
                                    DataDB.procedimiento1_1 =
                                        controllProcedimiento1_1.text;
                                    DataDB.procedimiento1_2 =
                                        controllProcedimiento1_2.text;
                                    DataDB.procedimiento2_1 =
                                        controllProcedimiento2_1.text;
                                    DataDB.procedimiento2_2 =
                                        controllProcedimiento2_2.text;
                                    DataDB.procedimiento3_1 =
                                        controllProcedimiento3_1.text;
                                    DataDB.procedimiento3_2 =
                                        controllProcedimiento3_2.text;

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: const Text("Confirmación"),
                                          content: const Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                                "¿Estás seguro de guardar este registro?"),
                                          ),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              onPressed: () async {
                                                //todo ENVIO DE DATOS

                                                bool res = await DataBaseQuerys()
                                                    .insertRecordJournal(
                                                        Data.assignData());
                                                if (res == true) {
                                                  StatusAlert.show(
                                                    context,
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    subtitle: 'Envio exitoso',
                                                    configuration:
                                                        const IconConfiguration(
                                                            icon: Icons.done),
                                                    maxWidth: 260,
                                                  );
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return const FormScreen();
                                                  }));
                                                  Data.initData();
                                                  setState(() {});
                                                } else if (res == false) {
                                                  StatusAlert.show(
                                                    context,
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    subtitle:
                                                        'Ocurrio un error',
                                                    configuration:
                                                        const IconConfiguration(
                                                            icon: Icons.close),
                                                    maxWidth: 260,
                                                  );
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text("Sí"),
                                            ),
                                            CupertinoDialogAction(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.black,
                                        content: Text(
                                          "Llena todos los campos",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                icon: Icons.save,
                                width: 0.4,
                                color: const Color(0xff00B63E),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
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

class ButtonIcon extends StatelessWidget {
  final VoidCallback function;
  final IconData icon;
  final double width;
  final Color color;
  const ButtonIcon({
    super.key,
    required this.query,
    required this.function,
    required this.icon,
    required this.width,
    required this.color,
  });

  final MediaQueryData query;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          width: query.size.width * width,
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
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          )),
    );
  }
}
