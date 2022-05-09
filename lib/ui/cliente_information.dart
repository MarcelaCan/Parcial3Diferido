import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled2/model/Clientes.dart';


class ClienteInformation extends StatefulWidget {
  final Cliente cliente;
  ClienteInformation(this.cliente);
  @override
  _ClienteInformationState createState() => _ClienteInformationState();
}

final clienteReference = FirebaseDatabase.instance.reference().child('cliente');

class _ClienteInformationState extends State<ClienteInformation> {

  List<Cliente> items;

  String clienteImage;//nuevo

  @override
  void initState() {
    super.initState();
    clienteImage = widget.cliente.clienteImage;//nuevo
    print(clienteImage);//nuevo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion de Cliente y foto'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Container(
        height: 800.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                new Text("Nombre : ${widget.cliente.nombre}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Apellido : ${widget.cliente.apellido}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Direccion : ${widget.cliente.direccion}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Ciudad : ${widget.cliente.ciudad}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Vehiculo : ${widget.cliente.vehiculo}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                new Text("Matricula : ${widget.cliente.matricula}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                Container(
                  height: 300.0,
                  width: 300.0,
                  child: Center(
                    child: clienteImage == ''
                        ? Text('No Image')
                        : Image.network(clienteImage+'?alt=media'),//nuevo para traer la imagen de firestore
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}