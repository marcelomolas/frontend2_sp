import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:segundo_parcial/objects/persona.dart';
import 'dart:convert';
import 'dart:async';

import 'package:segundo_parcial/widgets/postpersonas.dart';

class AddPersona extends StatefulWidget {
  const AddPersona({Key? key}) : super(key: key);

  @override
  _AddPersonaState createState() => _AddPersonaState();
}

class _AddPersonaState extends State<AddPersona> {
  PostPersona persona = PostPersona();

  final TextEditingController controlNombre = TextEditingController();
  final TextEditingController controlApellido = TextEditingController();
  final TextEditingController controlEmail = TextEditingController();
  final TextEditingController controlTelefono = TextEditingController();
  final TextEditingController controlRuc = TextEditingController();
  final TextEditingController controlCedula = TextEditingController();
  final TextEditingController controlTipoPersona = TextEditingController();
  final TextEditingController controlNacimiento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar Persona'),
        ),
        body: Container(
          child: Column(children: <Widget>[
            TextField(
              controller: controlNombre,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
              onChanged: (value) {
                //persona.nombre = value;
              },
            ),
            TextField(
              controller: controlApellido,
              decoration: InputDecoration(
                labelText: 'Apellido',
              ),
              onChanged: (value) {
                //persona.apellido = value;
              },
            ),
            TextField(
              controller: controlEmail,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
              ),
              onChanged: (value) {
                //persona.email = value;
              },
            ),
            TextField(
              controller: controlTelefono,
              decoration: InputDecoration(
                labelText: 'Número de teléfono',
              ),
              onChanged: (value) {
                //persona.telefono = value;
              },
            ),
            TextField(
              controller: controlRuc,
              decoration: InputDecoration(
                labelText: 'RUC',
              ),
              onChanged: (value) {
                //persona.ruc = value;
              },
            ),
            TextField(
              controller: controlCedula,
              decoration: InputDecoration(
                labelText: 'Número de cédula',
              ),
              onChanged: (value) {
                //persona.cedula = value;
              },
            ),
            TextField(
              controller: controlTipoPersona,
              decoration: InputDecoration(
                labelText: 'Tipo persona',
              ),
              onChanged: (value) {
                //persona.tipoPersona = value;
              },
            ),
            TextField(
              controller: controlNacimiento,
              decoration: InputDecoration(
                labelText: 'Fecha de nacimiento',
              ),
              onChanged: (value) {
                //persona.naciemiento = value;
              },
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final nombre = controlNombre.text;
            final apellido = controlApellido.text;
            final email = controlEmail.text;
            final telefono = controlTelefono.text;
            final ruc = controlRuc.text;
            final cedula = controlCedula.text;
            final tipoPersona = controlTipoPersona.text;
            final nacimiento = controlNacimiento.text;
            final Persona user = await persona.crearPersona(nombre, apellido,
                email, telefono, ruc, cedula, tipoPersona, nacimiento);

            Navigator.pushNamed(context, "/administracion");
          },
          child: Icon(Icons.add),
        ));
  }
}


// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Album> createAlbum(String title) async {
//   final response = await http.post(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );

//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }

// class Album {
//   final int id;
//   final String title;

//   Album({required this.id, required this.title});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() {
//     return _MyAppState();
//   }
// }

// class _MyAppState extends State<MyApp> {
//   final TextEditingController _controller = TextEditingController();
//   Future<Album>? _futureAlbum;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Create Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Create Data Example'),
//         ),
//         body: Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.all(8.0),
//           child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
//         ),
//       ),
//     );
//   }

//   Column buildColumn() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         TextField(
//           controller: _controller,
//           decoration: const InputDecoration(hintText: 'Enter Title'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _futureAlbum = createAlbum(_controller.text);
//             });
//           },
//           child: const Text('Create Data'),
//         ),
//       ],
//     );
//   }

//   FutureBuilder<Album> buildFutureBuilder() {
//     return FutureBuilder<Album>(
//       future: _futureAlbum,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Text(snapshot.data!.title);
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }

//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }