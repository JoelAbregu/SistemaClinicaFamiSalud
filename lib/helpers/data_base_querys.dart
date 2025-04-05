import 'package:mysql1/mysql1.dart';
import '../shared/user_data.dart';

class DataBaseQuerys {
  //todo  Datos de conexión
  final ConnectionSettings settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root', 
    password: '',
    db: 'famisalud',
  );

  //todo Método privado para establecer la conexión
  Future<MySqlConnection> _getConnection() async {
    return await MySqlConnection.connect(settings);
  }

  //todo Método privado para cerrar la conexión
  Future<void> _closeConnection(MySqlConnection conn) async {
    await conn.close();
  }

  //todo Verificar credenciales de usuario
  Future<bool> authenticateUser(String username, String password) async {
    try {
      var conn = await _getConnection();
      var result = await conn.query(
        'SELECT * FROM medico WHERE username = ? AND password = ?',
        [username, password],
      );
      await _closeConnection(conn);
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  //todo Obtener ID y datos de usuario
  Future<int> getId(String username, String password) async {
    try {
      var conn = await _getConnection();
      var id = await conn.query(
        'SELECT id FROM medico WHERE username = ? AND password = ?',
        [username, password],
      );
      var result = await conn.query(
        'SELECT username, password, first_name, last_name, specialty FROM medico WHERE id = ?',
        [id.first.fields['id']],
      );
      UserData.userName = result.first.fields['username'];
      UserData.password = result.first.fields['password'];
      UserData.firstName = result.first.fields['first_name'];
      UserData.lastName = result.first.fields['last_name'];
      UserData.specialty = result.first.fields['specialty'];
      await _closeConnection(conn);
      return id.first.fields['id'];
    } catch (e) {
      return 0;
    }
  }

  //todo Insertar registro
  Future<bool> insertRecordJournal(Map<String, dynamic> registro) async {
    try {
      var conn = await _getConnection();
      // Verificar campos vacíos y reemplazar con null si es necesario
      registro.forEach((key, value) {
        if (value == '') {
          registro[key] = null;
        }
      });
      await conn.query(
          'INSERT INTO registro_diario (doctor_id,tipo_atencion,turno,fecha,especialidad,responsable,dni,hc,nombre_paciente,financiacion,distrito,edad_anos,edad_meses,genero,diagnostico1,probabilidadDiagnostico1,examen1_1,procedimiento1_1,examen1_2,procedimiento1_2,diagnostico2,probabilidadDiagnostico2,examen2_1,procedimiento2_1,examen2_2,procedimiento2_2,diagnostico3,probabilidadDiagnostico3,examen3_1,procedimiento3_1,examen3_2,procedimiento3_2)'
          'VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)',
          [
            registro['doctor_id'],
            registro['tipo_atencion'],
            registro['turno'],
            registro['fecha'],
            registro['especialidad'],
            registro['responsable'],
            registro['dni'],
            registro['hc'],
            registro['nombre_paciente'],
            registro['financiacion'],
            registro['distrito'],
            registro['edad_anos'],
            registro['edad_meses'],
            registro['genero'],
            registro['diagnostico1'],
            registro['probabilidadDiagnostico1'],
            registro['examen1_1'],
            registro['procedimiento1_1'],
            registro['examen1_2'],
            registro['procedimiento1_2'],
            registro['diagnostico2'],
            registro['probabilidadDiagnostico2'],
            registro['examen2_1'],
            registro['procedimiento2_1'],
            registro['examen2_2'],
            registro['procedimiento2_2'],
            registro['diagnostico3'],
            registro['probabilidadDiagnostico3'],
            registro['examen3_1'],
            registro['procedimiento3_1'],
            registro['examen3_2'],
            registro['procedimiento3_2'],
          ]);
      await _closeConnection(conn);
      return true;
    } catch (e) {
      return false;
    }
  }

  //todo Contar registros por fecha y tipo de atención
  Future<int?> countRecordsByDateAndTypeAttention(
      String fecha, String tipoAtencion, int doctorId) async {
    try {
      if (fecha.isEmpty || tipoAtencion.isEmpty || doctorId <= 0) {
        throw ArgumentError('Invalid parameters provided.');
      }

      var conn = await _getConnection();

      var result = await conn.query(
        'SELECT COUNT(*) AS count FROM registro_diario WHERE fecha = ? AND tipo_atencion = ? AND doctor_id = ?',
        [fecha, tipoAtencion, doctorId],
      );

      if (result.isEmpty) {
        // No se encontraron registros que coincidan con los criterios
        await _closeConnection(conn);
        return 0;
      }

      var count = result.first.fields['count'] as int;
      await _closeConnection(conn);

      return count;
    } catch (e) {
      // Log the error for debugging purposes
      return null;
    }
  }
}
