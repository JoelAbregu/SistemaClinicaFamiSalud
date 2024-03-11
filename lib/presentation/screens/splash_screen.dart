import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:registro_diario_mobil_1_0_1/presentation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/theme/apptheme.dart';
import '../../shared/user_data.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    UserData.id = 0;
    _getRequiredLoading();
    
  }

  //todo Obtener el valor de requiredLoading en SharedPreferences
  _getRequiredLoading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserData.id = prefs.getInt("dataId") ?? 0;
      UserData.userName = prefs.getString("dataUserName") ?? "";
      UserData.password = prefs.getString("dataPassword") ?? "";
      UserData.firstName = prefs.getString("dataFirstName") ?? "";
      UserData.lastName = prefs.getString("dataLastName") ?? "";
      UserData.specialty = prefs.getString("dataSpecialty") ?? "";
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppTheme.colorGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedSplashScreen(
          duration: 2000,
          splash: Image.asset("assets/splash.png"),
          nextScreen:
              UserData.id == 0 ? const LoginScreen() : const HomeScreen(),
          splashIconSize: query.size.width * 0.7,
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.transparent, // Hacer el fondo transparente
        ),
      ),
    );
  }
}
