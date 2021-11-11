// ignore: file_names
// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:segundo_parcial/objects/persona.dart';

// url de la api
const String url = 'equipoyosh.com';

class FetchUser {
  Future<List<Persona>> getUserList() async {
    try {
      var response = await http
          .get(Uri.https(url, "/stock-nutrinatalia/persona",
              {"orderBy": "apellido", "orderDir": "asc"}))
          .timeout(const Duration(seconds: 5),
              onTimeout: () =>
                  throw TimeoutException("Tiempo de espera excedido"));
      if (response.statusCode == 200) {
        // se convierte a json
        var data = jsonDecode(response.body) as Map<String, dynamic>;
        //results = data.map((e) => Persona.fromMap(e)).toList();
        var personasjson = data["lista"];
        List<Persona> personas = [];
        for (var personajson in personasjson) {
          personas.add(Persona.fromMap(personajson));
        }

        return personas;
      } else {
        print('error en la API ${response.statusCode}');
      }
    } on Exception catch (e) {
      print('error ${e}');
    }
    throw Exception('Error en la llamada a la API');
  }
}
