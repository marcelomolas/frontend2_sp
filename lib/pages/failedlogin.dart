import 'package:flutter/material.dart';

class FailedLoginPage extends StatelessWidget {
  const FailedLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No encontramos su usuario en nuestra base de datos!"),
          const SizedBox(
            height: 10,
          ),
          const Text("Intente de nuevo!"),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              child: const Text("Reintentar"))
        ],
      )),
    );
  }
}
