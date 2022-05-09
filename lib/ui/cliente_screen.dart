import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled2/model/Clientes.dart';
//nuevo para imagenes
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_format/date_format.dart';

File image;
String filename;

class ClienteScreen extends StatefulWidget {
  final Cliente cliente;
  ClienteScreen(this.cliente);
  @override
  _ClienteScreenState createState() => _ClienteScreenState();
}

final clienteReference = FirebaseDatabase.instance.reference().child('cliente');

class _ClienteScreenState extends State<ClienteScreen> {

  List<Cliente> items;

  TextEditingController _nombreController;
  TextEditingController _apellidoController;
  TextEditingController _direccionController;
  TextEditingController _ciudadController;
  TextEditingController _vehiculoController;
  TextEditingController _matriculaController;

  //nuevo imagen
  String clienteImage;

  pickerCam() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  pickerGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }
  //fin nuevo imagen

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreController = new TextEditingController(text: widget.cliente.nombre);
    _apellidoController = new TextEditingController(text: widget.cliente.apellido);
    _direccionController = new TextEditingController(text: widget.cliente.direccion);
    _ciudadController = new TextEditingController(text: widget.cliente.ciudad);
    _vehiculoController = new TextEditingController(text: widget.cliente.vehiculo);
    _matriculaController = new TextEditingController(text: widget.cliente.matricula);
    clienteImage = widget.cliente.clienteImage;
    print(clienteImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(

        //height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.blueAccent)),
                      padding: new EdgeInsets.all(5.0),
                      child: image == null ? Text('Add') : Image.file(image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.2),
                      child: new Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.blueAccent)),
                        padding: new EdgeInsets.all(5.0),
                        child: clienteImage == '' ? Text('Edit') : Image.network(clienteImage+'?alt=media'),
                      ),
                    ),
                    Divider(),
                    //nuevo para llamar imagen de la galeria o capturarla con la camara
                    new IconButton(
                        icon: new Icon(Icons.camera_alt), onPressed: pickerCam),
                    Divider(),
                    new IconButton(
                        icon: new Icon(Icons.image), onPressed: pickerGallery),
                  ],
                ),
                TextField(
                  controller: _nombreController,
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Nombre'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _apellidoController,
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person), labelText: 'Apellido'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _direccionController,
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.list), labelText: 'Direccion'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Divider(),
                TextField(
                  controller: _ciudadController,
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.monetization_on), labelText: 'Ciudad'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                ),
                Divider(),
                TextField(
                  controller: _vehiculoController,
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.shop), labelText: 'Vehiculo'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                ),
                Divider(),
                TextField(
                  controller: _matriculaController,
                  style:
                  TextStyle(fontSize: 17.0, color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(
                      icon: Icon(Icons.shop), labelText: 'Matricula'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.0),
                ),
                Divider(),
                FlatButton(
                    onPressed: () {
                      //nuevo imagen
                      if (widget.cliente.id != null) {
                        var now = formatDate(
                            new DateTime.now(), [yyyy, '-', mm, '-', dd]);
                        var fullImageName =
                            '${_nombreController.text}-$now' + '.jpg';
                        var fullImageName2 =
                            '${_nombreController.text}-$now' + '.jpg';

                        final StorageReference ref =
                        FirebaseStorage.instance.ref().child(fullImageName);
                        final StorageUploadTask task = ref.putFile(image);

                        var part1 =
                            'https://firebasestorage.googleapis.com/v0/b/flutterimagen.appspot.com/o/';//firestore

                        var fullPathImage = part1 + fullImageName2;

                        clienteReference.child(widget.cliente.id).set({
                          'nombre': _nombreController.text,
                          'apellido': _apellidoController.text,
                          'direccion': _direccionController.text,
                          'ciudad': _ciudadController.text,
                          'vehiculo': _vehiculoController.text,
                          'matricula': _matriculaController.text,
                          'ProductImage': '$fullPathImage'
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        //nuevo imagen
                        var now = formatDate(
                            new DateTime.now(), [yyyy, '-', mm, '-', dd]);
                        var fullImageName =
                            '${_nombreController.text}-$now' + '.jpg';
                        var fullImageName2 =
                            '${_nombreController.text}-$now' + '.jpg';

                        final StorageReference ref =
                        FirebaseStorage.instance.ref().child(fullImageName);
                        final StorageUploadTask task = ref.putFile(image);

                        var part1 =
                            'https://firebasestorage.googleapis.com/v0/b/flutterimagen.appspot.com/o/'; //firestore

                        var fullPathImage = part1 + fullImageName2;

                        clienteReference.push().set({
                          'nombre': _nombreController.text,
                          'apellido': _apellidoController.text,
                          'direccion': _direccionController.text,
                          'ciudad': _ciudadController.text,
                          'vehiculo': _vehiculoController.text,
                          'matricula': _matriculaController.text,
                          'ProductImage': '$fullPathImage'//nuevo imagen
                        }).then((_) {
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: (widget.cliente.id != null)
                        ? Text('Update')
                        : Text('Add')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}