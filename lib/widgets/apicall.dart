import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:segundo_parcial/objects/persona.dart';
import 'package:segundo_parcial/pages/mainpage.dart';

const String url = 'equipoyosh.com';

class ApiCall extends StatefulWidget {
  final String username;

  const ApiCall({Key? key, required this.username}) : super(key: key);

  @override
  _ApiCallState createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  late Future apiCall;

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
              return Container();
            default:
              return const Center(
                child: Text("hubo un error"),
              );
          }
        },
      ),
    );
  }

  Future obtenerDatosAPI() async {
    var res = await http
        .get(Uri.https(url, "/stock-nutrinatalia/persona",
            {"ejemplo": "{\"soloUsuariosDelSistema\": \"true\"}"}))
        .timeout(const Duration(seconds: 5),
            onTimeout: () =>
                throw TimeoutException("Tiempo de espera agotado!"));
    print(res.statusCode);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body) as Map<String, dynamic>;
      var personasjson = json["lista"];
      List<Persona> personas = [];
      for (var personajson in personasjson) {
        personas.add(Persona.fromMap(personajson));
      }
      if (verificarUsuario(widget.username, personas)) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(username: widget.username)));
      } else {
        Navigator.pushReplacementNamed(context, "/failed");
      }
    } else {
      throw Exception(
          "Error al hacer la llamada a la API. Código: ${res.statusCode}");
    }
  }

  bool verificarUsuario(String username, List<Persona> personas) {
    bool existe = false;
    for (var persona in personas) {
      if (persona.usuarioLogin == username) existe = true;
    }
    return existe;
  }
}
