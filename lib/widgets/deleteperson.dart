import 'dart:convert';

import 'package:segundo_parcial/objects/persona.dart';
import 'package:http/http.dart' as http;


class DeletePersona {

  Future<Persona> deletePersona(String id) async {
  var response = await http.delete(
    Uri.parse('https://equipoyosh.com/stock-nutrinatalia/persona/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON. After deleting,
    // you'll get an empty JSON `{}` response.
    // Don't return `null`, otherwise `snapshot.hasData`
    // will always return false on `FutureBuilder`.
    return Persona.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Error al eliminar el usuario');
  }
}

}
