// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:registro_diario_mobil_1_0_1/config/theme/apptheme.dart';
import 'package:registro_diario_mobil_1_0_1/presentation/widgets/button_degrade_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/data_base_querys.dart';
import '../../shared/user_data.dart';
import '../provider/connection_provider.dart';
import '../widgets/text_input_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _setIdInit();
    setState(() {
      UserData.id = 0;
      UserData.userName = "";
      UserData.password = "";
      UserData.firstName = "";
      UserData.lastName = "";
      UserData.specialty = "";
    });
  }

  //todo Agregar a SharedPreferences el valor de requiredLoading
  _setRequiredLoading(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData.id = await DataBase().getId(username, password);
    setState(() {
      prefs.setInt("dataId", UserData.id);
      prefs.setString("dataUserName", UserData.userName);
      prefs.setString("dataPassword", UserData.password);
      prefs.setString("dataFirstName", UserData.firstName);
      prefs.setString("dataLastName", UserData.lastName);
      prefs.setString("dataSpecialty", UserData.specialty);
    });
  }

  _setIdInit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt("dataId", 0);
    });
  }

  //todo Mostrar SnackBar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  bool _isLoading = false;
  final controllUser = TextEditingController();
  final controllPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    final query = MediaQuery.of(context);
    final connectionProvider = context.watch<ConnectionProvider>();
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/login.png",
            height: query.size.height * 1,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: query.size.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextInputWidget(
                  control: controllUser,
                  hintext: 'Usuario',
                  keyboard: TextInputType.text,
                  limit: 20,
                  oscurePassword: false,
                ),
                const SizedBox(height: 20),
                TextInputWidget(
                  control: controllPass,
                  hintext: 'Contraseña',
                  keyboard: TextInputType.visiblePassword,
                  limit: 20,
                  oscurePassword: true,
                ),
                const SizedBox(height: 40),
                ButtonDegrade(
                    padding: 13,
                    colors: [
                      AppTheme.colorFourth,
                      const Color.fromARGB(255, 255, 183, 0)
                    ],
                    text: "Ingresar",
                    function: () async {
                      if (controllUser.text.isEmpty ||
                          controllPass.text.isEmpty) {
                        showSnackBar("Llene todos los campos");
                        return;
                      }
                      if (connectionProvider.connection == false) {
                        showSnackBar("Verifique su conexión a internet");
                        return;
                      }
                      setState(() {
                        _isLoading = true; // Activar el estado de carga
                      });

                      bool? authenticationResult =
                          await DataBase().authenticateUser(
                        controllUser.text,
                        controllPass.text,
                      );

                      setState(() {
                        _isLoading = false; // Desactivar el estado de carga
                      });

                      if (authenticationResult == true) {
                        _setRequiredLoading(
                          controllUser.text,
                          controllPass.text,
                        );
                        int id = await DataBase()
                            .getId(controllUser.text, controllPass.text);
                        if (id != 0) {
                          Navigator.pushNamed(context, '/home');
                        }
                      } else if (authenticationResult == false) {
                        showSnackBar("Datos incorrectos");
                      }
                    })
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: SizedBox(
              width: query.size.width,
              child: const Text(
                "Desarrollado por Joel Abregu",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.colorFourth,
                    strokeWidth: 2,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
