import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectionProvider extends ChangeNotifier {
  //todo Verifica la conexion
  bool connection = false;
  // Ejecuta cada 5 segundos la verificacion
  ConnectionProvider() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      verificationConnection();
    });
  }
  // Verifica la conexion
  Future<void> verificationConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      connection = false;
    } else {
      connection = true;
    }
    notifyListeners();
  }
}
