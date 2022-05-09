import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Cliente {
  String _id;
  String _nombre;
  String _apellido;
  String _direccion;
  String _ciudad;
  String _vehiculo;
  String _matricula;

  Cliente(this._id,this._nombre,this._apellido,this._direccion,
      this._ciudad,this._vehiculo,this._matricula);

  Cliente.map(dynamic obj){
    this._nombre  = obj['nombre'];
    this._apellido = obj['apellido'];
    this._direccion = obj['direccion'];
    this._ciudad = obj['ciudad'];
    this._vehiculo = obj['vehiculo'];
    this._matricula = obj['matricula'];
  }

  String get id => _id;
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get direccion => _direccion;
  String get ciudad => _ciudad;
  String get vehiculo => _vehiculo;
  String get matricula => _matricula;

  Cliente.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _apellido = snapshot.value['apellido'];
    _direccion = snapshot.value['direccion'];
    _ciudad = snapshot.value['ciudad'];
    _vehiculo = snapshot.value['vehiculo'];
    _matricula = snapshot.value['matricula'];
  }
}