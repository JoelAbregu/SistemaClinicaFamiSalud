import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//todo Mandar el DNI a consultar
Future<Map<String, dynamic>> consultDNI(String dni) async {
  final url =
      'https://dniruc.apisperu.com/api/v1/dni/$dni?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImFicmVndW1hbnJpcXVlZkBnbWFpbC5jb20ifQ.cxwjQM4V4_-Z8GZ-NCfHswFWGHaoNHjASkg5P5YF3iw';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      return {
        'success': false,
        'error': 'Error en la solicitud HTTP: ${response.statusCode}'
      };
    }
  } catch (e) {
    return {'success': false, 'error': e.toString()};
  }
}

//todo Obtener nombre completo por DNI
Future<String?> consultDNIData(String dni) async {
  final resultado = await consultDNI(dni);
  if (resultado['success']) {
    return "${resultado['nombres']} ${resultado['apellidoPaterno']} ${resultado['apellidoMaterno']}";
  } else {
    // Devolvemos null si hay un error
    return null;
  }
}
