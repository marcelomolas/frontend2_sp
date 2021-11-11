import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:segundo_parcial/objects/persona.dart';

const String url = 'equipoyosh.com';

class Reserva extends StatelessWidget {
  const Reserva({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reserva de turnos"),
      ),
      body: ReservaBody(),
    );
  }
}

class ReservaBody extends StatefulWidget {
  const ReservaBody({Key? key}) : super(key: key);

  @override
  _ReservaBodyState createState() => _ReservaBodyState();
}

class _ReservaBodyState extends State<ReservaBody> {
  late Future<List<Persona>> apiCall;

  @override
  void initState() {
    apiCall = obtenerDatosAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 400),
      child: FutureBuilder(
        future: apiCall,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView();
              } else {
                return const Center(
                  child: Text("hubo un error"),
                );
              }
            default:
              return const Center(
                child: Text("hubo un error"),
              );
          }
        },
      ),
    );
  }

  Future<List<Persona>> obtenerDatosAPI() async {
    var res = await http
        .get(Uri.https(
            url, "stock-nutrinatalia/persona/4/agenda/", {"fecha": "20190903"}))
        .timeout(const Duration(seconds: 5),
            onTimeout: () =>
                throw TimeoutException("Tiempo de espera agotado!"));
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body) as Map<String, dynamic>;
      var personasjson = json["lista"];
      List<Persona> personas = [];
      for (var personajson in personasjson) {
        personas.add(Persona.fromMap(personajson));
      }
      return personas;
    }
    throw Exception(
        "Error al hacer la llamada a la API. Código: ${res.statusCode}");
  }
}
