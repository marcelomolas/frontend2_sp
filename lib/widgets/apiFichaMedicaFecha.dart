import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:segundo_parcial/pages/FichaListadoFecha.dart';
import 'package:segundo_parcial/pages/mainpage.dart';
import 'package:segundo_parcial/objects/ficha.dart';

const String url = 'equipoyosh.com';

class ApiFichaMedicaFecha extends StatefulWidget {

  final String fecha;

  const ApiFichaMedicaFecha({Key? key, required this.fecha}) : super(key: key);

  @override
  _ApiFichaMedicaFechaState createState() => _ApiFichaMedicaFechaState();
}

class _ApiFichaMedicaFechaState extends State<ApiFichaMedicaFecha> {
  late Future apiFichaMedicaFecha;
  @override
  void initState() {
    apiFichaMedicaFecha = getFichasFecha();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200, maxWidth: 400),
      child: FutureBuilder(
        future: apiFichaMedicaFecha,
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

  Future getFichasFecha() async {
    var res = await http
        .get(Uri.https(url, "/stock-nutrinatalia/fichaClinica",
        {"ejemplo":"{\"fechaDesdeCadena\":${widget.fecha.substring(0,7)},\"fechaHastaCadena\": ${widget.fecha.substring(8,15)}}"}))
        .timeout(const Duration(seconds: 25),
        onTimeout: () =>
        throw TimeoutException("Tiempo de espera agotado!"));
    print(res.statusCode);
    if (res.statusCode == 200) {
      var json = jsonDecode(utf8.decode(res.bodyBytes));
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

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FichaListadoFecha(fichas: fichas)));
    } else {
      throw Exception(
          "Error al hacer la llamada a la API. Código: ${res.statusCode}");
    }
  }

}

