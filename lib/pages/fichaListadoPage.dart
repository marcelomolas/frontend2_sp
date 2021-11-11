import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:segundo_parcial/objects/ficha.dart';

const String url = 'equipoyosh.com';

class FichaListadoPage extends StatefulWidget {
  final List<Ficha> fichas;

  const FichaListadoPage({Key? key, required this.fichas}) : super(key: key);

  @override
  _FichaPageState createState() => _FichaPageState();

}

class _FichaPageState extends State<FichaListadoPage>{

  List<String> data = [];
  String _selectedLocation = '';

  Future<String> getSWData() async {
    var resBody = await getFichas();

    setState(() {
      data = _listFichas(resBody);
      this._selectedLocation = data.first;
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fichas"),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Administración'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, "/administracion");
                },
              ),
              ListTile(
                title: const Text('Reserva de turno'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, "/reserva");
                },
              ),
              ListTile(
                title: const Text('Ficha clínica'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pushNamed(context, "/ficha");
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: DropdownButton(
            items: data.map((location) {
              return DropdownMenuItem(
                child: new Text(location),
                value: location,
              );
            }).toList(),
            hint: Text('Please choose a text'), // Not necessary for Option 1
            onChanged: (String? value) {
              setState(() {
                _selectedLocation = value!;
              });
            },
            value: _selectedLocation,
          ),
        ),
    );
  }


}

List<Widget> _listFichasWidget(List<Ficha>data){
  List<Widget> fichas = [];

  for(var ficha in data) {

    if (ficha.idFicha! != null){
      fichas.add(Card(child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ficha.idFicha.toString())
          )
        ],
      )));
    }else{
      fichas.add(Card(child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("null")
          )
        ],
      )));
    }
  }
  return fichas;
}

List<String> _listFichas(List<Ficha>data){
  List<String> fichas = [];

  for(var ficha in data) {

    if (ficha.observacion != null){
      fichas.add(ficha.observacion.toString());
    }else{
      fichas.add("null");
    }
  }
  
  return fichas;
}

Future<List<Ficha>> getFichas() async {
  var res = await http
      .get(Uri.https(url, "/stock-nutrinatalia/fichaClinica"))
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
    return fichas;
  } else {
    throw Exception(
        "Error al hacer la llamada a la API. Código: ${res.statusCode}");
  }
}
