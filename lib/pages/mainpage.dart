import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final String username;
  const MainPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenid@, $username"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => null, child: const Text("Administración")),
            ElevatedButton(
                onPressed: () => null, child: const Text("Reserva de turnos")),
            ElevatedButton(
                onPressed: () => null, child: const Text("Ficha Clínica"))
          ],
        ),
      ),
    );
  }
}
