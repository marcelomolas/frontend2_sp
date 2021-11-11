import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:segundo_parcial/objects/ficha.dart';

class FichaListadoFecha extends StatelessWidget {

  final List<Ficha> fichas;

  const FichaListadoFecha({Key? key, required this.fichas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fichas.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '${fichas[index].idFicha}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column( mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnostico: ${fichas[index].diagnostico}, ${fichas[index].observacion}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)

                    ),
                    Text(
                      'Fisioterapeuta: ${fichas[index].idEmpleado!.nombre}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text('Paciente: ${fichas[index].idCliente!.nombre}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )),
                  ],
                )
              ],
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => {Navigator.pushNamed(context, "")},
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => {Navigator.pushNamed(context, "")})
            ]),
          ),
        );
      },
    );
  }
}
