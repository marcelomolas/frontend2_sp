import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:segundo_parcial/objects/persona.dart';

class Ficha {
  int? idFicha;
  String? motivoConsulta;
  String? diagnostico;
  String? observacion;
  Persona? idEmpleado;
  Persona? idCliente;

  Ficha({
    this.idFicha,
    this.motivoConsulta,
    this.diagnostico,
    this.observacion,
    this.idEmpleado,
    this.idCliente,
  });

  Ficha copyWith({
    int? idFicha,
    String? motivoConsulta,
    String? diagnostico,
    String? observacion,
    Persona? idEmpleado,
    Persona? idCliente,
  }) {
    return Ficha(
      idFicha: idFicha ?? this.idFicha,
      motivoConsulta: motivoConsulta ?? this.motivoConsulta,
      diagnostico: diagnostico ?? this.diagnostico,
      observacion: observacion ?? this.observacion,
      idEmpleado: idEmpleado ?? this.idEmpleado,
      idCliente: idCliente ?? this.idCliente,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idFicha': this.idFicha,
      'motivoConsulta': this.motivoConsulta,
      'diagnostico': this.diagnostico,
      'observacion': this.observacion,
      'idEmpleado': this.idEmpleado,
      'idCliente': this.idCliente,
    };
  }

  factory Ficha.fromMap(Map<String, dynamic> map) {
    return Ficha(
      idFicha: map['idFichaClinica'],
      motivoConsulta: map['motivoConsulta'],
      diagnostico: map['diagnostico'],
      observacion: map['observacion'],
      idEmpleado: Persona.fromMap(map['idEmpleado']) ,
      idCliente: Persona.fromMap(map['idCliente'])
    );
  }

  String toJson() => json.encode(toMap());

  factory Ficha.fromJson(String source) =>
      Ficha.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ficha(idFicha: $idFicha, motivoConsulta: $motivoConsulta, diagnostico: $diagnostico, observacion: $observacion,'
        'Fisioterapeuta: ${idEmpleado!.nombre}, Cliente: ${idCliente!.nombre})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ficha &&
        other.idFicha == idFicha &&
        other.motivoConsulta == motivoConsulta &&
        other.motivoConsulta == motivoConsulta &&
        other.observacion == observacion &&
        other.idEmpleado == idEmpleado &&
        other.idCliente == idCliente;
  }

  @override
  int get hashCode {
    return idFicha.hashCode ^
    motivoConsulta.hashCode ^
    diagnostico.hashCode ^
    observacion.hashCode ^
    idEmpleado.hashCode ^
    idCliente.hashCode;
  }
}