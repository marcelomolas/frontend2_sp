import 'package:flutter/material.dart';
import 'package:segundo_parcial/widgets/apicall.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget encabezado = const Text("Por fa, ingrese su usuario!");
  final _formKey = GlobalKey<FormState>();
  final _usernamecontroller = TextEditingController();
  final bool yainiciosesion = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            encabezado,
            const SizedBox(
              height: 20,
            ),
            UserNameForm(
              formKey: _formKey,
              controlador: _usernamecontroller,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    encabezado = ApiCall(
                      username: _usernamecontroller.value.text,
                    );
                    setState(() {});
                  }
                },
                child: const Text("Iniciar Sesión"))
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class UserNameForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controlador;
  const UserNameForm(
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
          decoration: const InputDecoration(label: Text('Usuario')),
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
