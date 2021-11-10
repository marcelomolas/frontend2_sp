import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final String username;
  const MainPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        title: Text("Bienvenid@, $username"),
      ),

    );
  }
}
