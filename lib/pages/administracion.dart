import 'package:flutter/material.dart';
import 'package:segundo_parcial/objects/persona.dart';
import 'package:segundo_parcial/widgets/listaPersonas.dart';

class Administracion extends StatefulWidget {
  const Administracion({Key? key}) : super(key: key);

  @override
  _AdministracionState createState() => _AdministracionState();
}

class _AdministracionState extends State<Administracion> {
  FetchUser _personas = FetchUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administración'),
        elevation: 5,
      ),
      body: Container(
        child: FutureBuilder<List<Persona>>(
            future: _personas.getUserList(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: data!.length,
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
                                '${data[index].idPersona}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text(
                                'Cliente: ${data[index].apellido}, ${data[index].nombre}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                'Correo: ${data[index].email}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text('Teléfono: ${data[index].telefono}',
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
                          onPressed: () => {},
                        ),
                        IconButton(
                            icon: Icon(Icons.delete), onPressed: () => {})
                      ]),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
