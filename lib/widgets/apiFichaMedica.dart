import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:segundo_parcial/pages/mainpage.dart';
import 'package:segundo_parcial/objects/ficha.dart';

const String url = 'equipoyosh.com';

class ApiFichaMedica extends StatefulWidget {
  final String username;

  const ApiFichaMedica({Key? key, required this.username}) : super(key: key);

  @override
  _ApiFichaMedicaState createState() => _ApiFichaMedicaState();
}

class _ApiFichaMedicaState extends State<ApiFichaMedica> {
  late Future apiFichaMedica;

  @override
  void initState() {
    apiFichaMedica = getFichas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 400),
      child: FutureBuilder(
        future: apiFichaMedica,
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

  Future getFichas() async {
    var res = await http
        .get(Uri.https(url, "/stock-nutrinatalia/fichaClinica"))
        .timeout(const Duration(seconds: 5),
        onTimeout: () =>
        throw TimeoutException("Tiempo de espera agotado!"));
    print(res.statusCode);
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body) as Map<String, dynamic>;
      var fichasjson = json["lista"];
      print(fichasjson);
      List<Ficha> fichas = [];
      for (var fichajson in fichasjson) {
        fichas.add(Ficha.fromMap(fichajson));
      }
      /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(username: widget.username)));
      */
      return fichas;
    } else {
      throw Exception(
          "Error al hacer la llamada a la API. Código: ${res.statusCode}");
    }
  }

}
