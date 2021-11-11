import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:segundo_parcial/objects/ficha.dart';
import 'package:segundo_parcial/widgets/apiFichaMedica.dart';
import 'package:segundo_parcial/widgets/apiFichaMedicaFecha.dart';

const String url = 'equipoyosh.com';

class FichaListadoPage extends StatefulWidget {
  final List<Ficha> fichas;

  const FichaListadoPage({Key? key, required this.fichas}) : super(key: key);

  @override
  _FichaPageState createState() => _FichaPageState();

}

class _FichaPageState extends State<FichaListadoPage>{
  final _fechaInicioKey = GlobalKey<FormState>();
  final _dateIniciocontroller = TextEditingController();
  final _fechaFinKey = GlobalKey<FormState>();
  final _dateFincontroller = TextEditingController();
  Widget encabezado = const Text("Consulta de fichas!");

  List<Ficha> data = [];
  int _idFicha = 0;

  Future<String> getSWData() async {
    var resBody = await getFichas();

    setState(() {
      data = resBody;
      print(data.first);
      this._idFicha = data.first.idFicha!;
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
        body: Column(
          children: [
            encabezado,
            Center(
              child: DropdownButton(
                items: data.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location.observacion.toString()),
                    value: location.idFicha,
                  );
                }).toList(),
                hint: Text('Please choose a text'), // Not necessary for Option 1
                onChanged: (int? value) {

                  setState(() {
                    _idFicha = value!;
                  });
                },
                value: _idFicha,
              ),
            ),
            Center(
              child: DateInicioForm(
                formKey: _fechaInicioKey,
                controlador: _dateIniciocontroller,
              ),
            ),
            Center(
              child: DateFinForm(
                formKey: _fechaFinKey,
                controlador: _dateFincontroller,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_fechaInicioKey.currentState!.validate() && _fechaFinKey.currentState!.validate()) {
                    encabezado = ApiFichaMedicaFecha(fecha: _dateIniciocontroller.value.text + _dateFincontroller.value.text );

                    setState(() {});
                  }
                },
                child: const Text("Consultar"))
          ],
        )
    );
  }


}


class DateInicioForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controlador;
  const DateInicioForm(
      {Key? key, required this.formKey, required this.controlador})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controlador,
          decoration: const InputDecoration(label: Text('Fecha Inicio')),
          maxLength: 30,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'No podes dejar vacío este campo!';
            }
          },
        ),
      ),
    );
  }
}
class DateFinForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controlador;
  const DateFinForm(
      {Key? key, required this.formKey, required this.controlador})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: formKey,
        child: TextFormField(
          controller: controlador,
          decoration: const InputDecoration(label: Text('Fecha Fin')),
          maxLength: 30,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'No podes dejar vacío este campo!';
            }
          },
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
