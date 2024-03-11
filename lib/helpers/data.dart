import '../shared/user_data.dart';

class Data {
  static void initData() {
    DataDB.turno = '';
    DataDB.dni = '';
    DataDB.hc = '';
    DataDB.nombrePaciente = '';
    DataDB.financiacion = '';
    DataDB.distrito = '';
    DataDB.edadAnos = '';
    DataDB.edadMeses = '';
    DataDB.genero = '';
    DataDB.diagnostico1 = '';
    DataDB.probabilidadDiagnostico1 = '';
    DataDB.examen1_1 = '';
    DataDB.examen1_2 = '';
    DataDB.procedimiento1_1 = '';
    DataDB.procedimiento1_2 = '';
    DataDB.diagnostico2 = '';
    DataDB.probabilidadDiagnostico2 = '';
    DataDB.examen2_1 = '';
    DataDB.examen2_2 = '';
    DataDB.procedimiento2_1 = '';
    DataDB.procedimiento2_2 = '';
    DataDB.diagnostico3 = '';
    DataDB.probabilidadDiagnostico3 = '';
    DataDB.examen3_1 = '';
    DataDB.examen3_2 = '';
    DataDB.procedimiento3_1 = '';
    DataDB.procedimiento3_2 = '';
  }

  static Map<String, dynamic> assignData() {
    return {
      'doctor_id': DataDB.doctorId,
      'tipo_atencion': DataDB.tipoAtencion,
      'turno': DataDB.turno,
      'fecha': DataDB.fecha,
      'especialidad': DataDB.especialidad,
      'responsable': DataDB.responsable,
      'dni': DataDB.dni,
      'hc': DataDB.hc,
      'nombre_paciente': DataDB.nombrePaciente,
      'financiacion': DataDB.financiacion,
      'distrito': DataDB.distrito,
      'edad_anos': DataDB.edadAnos,
      'edad_meses': DataDB.edadMeses,
      'genero': DataDB.genero,
      'diagnostico1': DataDB.diagnostico1,
      'probabilidadDiagnostico1': DataDB.probabilidadDiagnostico1,
      'examen1_1': DataDB.examen1_1,
      'procedimiento1_1': DataDB.procedimiento1_1,
      'examen1_2': DataDB.examen1_2,
      'procedimiento1_2': DataDB.procedimiento1_2,
      'diagnostico2': DataDB.diagnostico2,
      'probabilidadDiagnostico2': DataDB.probabilidadDiagnostico2,
      'examen2_1': DataDB.examen2_1,
      'procedimiento2_1': DataDB.procedimiento2_1,
      'examen2_2': DataDB.examen2_2,
      'procedimiento2_2': DataDB.procedimiento2_2,
      'diagnostico3': DataDB.diagnostico3,
      'probabilidadDiagnostico3': DataDB.probabilidadDiagnostico3,
      'examen3_1': DataDB.examen3_1,
      'procedimiento3_1': DataDB.procedimiento3_1,
      'examen3_2': DataDB.examen3_2,
      'procedimiento3_2': DataDB.procedimiento3_2,
    };
  }
}
