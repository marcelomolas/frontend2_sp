import 'dart:convert';
import 'package:segundo_parcial/objects/persona.dart';
import 'package:http/http.dart' as http;

const String url = 'https://equipoyosh.com/stock-nutrinatalia/persona';

class PostPersona {
  Future<Persona> crearPersona(
      String nombre,
      String apellido,
      String email,
      String telefono,
      String ruc,
      String ci,
      String tipo,
      String nacimiento) async {
    print("entra");
    print(nombre);
    print(apellido);
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'apellido': apellido,
        'email': email,
        'telefono': telefono,
        'ruc': ruc,
        'cedula': ci,
        'tipoPersona': tipo,
        'fechaNacimiento': nacimiento,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      return Persona.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear Persona');
    }
  }
}
