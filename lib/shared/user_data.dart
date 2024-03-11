class UserData {
  static int id = 0;
  static String userName = "";
  static String password = "";
  static String firstName = "";
  static String lastName = "";
  static String specialty = "";
}

class FormData {
  static DateTime dateSelect = DateTime.now();
  static String image = "";
  static String diagnosisDescription1 = "";
  static String diagnosisDescription2 = "";
  static String diagnosisDescription3 = "";
  static int? diagnosisNumber;
}

//todo Datos de la BD (en español)
class DataDB {
  static int doctorId = UserData.id; //capturado
  static String tipoAtencion = ''; //capturado
  static String turno = ''; //capturado
  static String fecha = ''; //capturado
  static String especialidad = ''; //capturado
  static String responsable = ''; //capturado
  static String dni = ''; //capturado
  static String hc = ''; //capturado
  static String nombrePaciente = ''; //capturado
  static String financiacion = ''; //capturado
  static String distrito = ''; //capturado
  static String edadAnos = ''; //capturado
  static String edadMeses = ''; //capturado
  static String genero = ''; //capturado
  //todo DIAGNOSTICO 1 ----
  static String diagnostico1 = '';
  static String probabilidadDiagnostico1 = '';
  static String examen1_1 = '';
  static String examen1_2 = '';
  static String procedimiento1_1 = '';
  static String procedimiento1_2 = '';
  //todo DIAGNOSTICO 2 ----
  static String diagnostico2 = '';
  static String probabilidadDiagnostico2 = '';
  static String examen2_1 = '';
  static String examen2_2 = '';
  static String procedimiento2_1 = '';
  static String procedimiento2_2 = '';
  //todo DIAGNOSTICO 3 ---------------
  static String diagnostico3 = '';
  static String probabilidadDiagnostico3 = '';
  static String examen3_1 = '';
  static String examen3_2 = '';
  static String procedimiento3_1 = '';
  static String procedimiento3_2 = '';
}
