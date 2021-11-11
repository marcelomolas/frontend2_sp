import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:segundo_parcial/objects/ficha.dart';

class FichaPage extends StatelessWidget {

  const FichaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/fichaList'),
                  child: const Text("Listar Fichas"))
            ],
          )),
    );
  }
}