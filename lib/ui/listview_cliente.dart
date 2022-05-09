import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:untitled2/ui/cliente_screen.dart';
import 'package:untitled2/ui/cliente_information.dart';
import 'package:untitled2/model/Clientes.dart';

class ListViewCliente extends StatefulWidget {
  @override
  _ListViewClienteState createState() => _ListViewClienteState();
}

final clienteReference = FirebaseDatabase.instance.reference().child('cliente');

class _ListViewClienteState extends State<ListViewCliente> {
  List<Cliente> items;
  StreamSubscription<Event> _onClienteAddedSubscription;
  StreamSubscription<Event> _onClienteChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onClienteAddedSubscription =
        clienteReference.onChildAdded.listen(_onClienteAdded);
    _onClienteChangedSubscription =
        clienteReference.onChildChanged.listen(_onClienteUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _onClienteAddedSubscription.cancel();
    _onClienteChangedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Clientes List'),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.only(top: 3.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(
                      height: 1.0,
                    ),
                    Container(
                      padding: new EdgeInsets.all(3.0),
                      child: Card(
                        child: Row(
                          children: <Widget>[
                            //nuevo imagen
                            new Container(
                              padding: new EdgeInsets.all(5.0),
                              child: '${items[position].ClienteImage}' == ''
                                  ? Text('No image')
                                  : Image.network(
                                '${items[position].ClienteImage}' +
                                    '?alt=media',
                                fit: BoxFit.fill,
                                height: 57.0,
                                width: 57.0,
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                  title: Text(
                                    '${items[position].nombre}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${items[position].apellido}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  onTap: () => _navigateToClienteInformation(
                                      context, items[position])),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => _showDialog(context, position),
                            ),

                            //onPressed: () => _deleteCliente(context, items[position],position)),
                            IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: () =>
                                    _navigateToCliente(context, items[position])),
                          ],
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.pinkAccent,
          onPressed: () => _createNewCliente(context),
        ),
      ),
    );
  }

  //nuevo para que pregunte antes de eliminar un registro
  void _showDialog(context, position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.purple,
              ),
              onPressed: () =>
                  _deleteCliente(context, items[position], position,),
            ),
            new FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onClienteAdded(Event event) {
    setState(() {
      items.add(new Cliente.fromSnapShot(event.snapshot));
    });
  }

  void _onClienteUpdate(Event event) {
    var oldClienteValue =
    items.singleWhere((cliente) => cliente.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldClienteValue)] =
      new Cliente.fromSnapShot(event.snapshot);
    });
  }

  void _deleteCliente(
      BuildContext context, Cliente cliente, int position) async {
    await clienteReference.child(cliente.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
        Navigator.of(context).pop();
      });
    });
  }

  void _navigateToClienteInformation(
      BuildContext context, Cliente cliente) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClienteScreen(cliente)),
    );
  }

  void _navigateToProduct(BuildContext context, Cliente cliente) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ClienteInformation(cliente)),
    );
  }

  void _createNewCliente(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ClienteScreen(Cliente(null, '', '', '', '', '', ''))),
    );
  }


}