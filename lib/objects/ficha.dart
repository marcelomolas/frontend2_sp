import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Ficha {
  int? idFicha;
  String? motivoConsulta;
  String? diagnostico;
  String? observacion;

  Ficha({
    this.idFicha,
    this.motivoConsulta,
    this.diagnostico,
    this.observacion,
  });

  Ficha copyWith({
    int? idFicha,
    String? motivoConsulta,
    String? diagnostico,
    String? observacion,
  }) {
    return Ficha(
      idFicha: idFicha ?? this.idFicha,
      motivoConsulta: motivoConsulta ?? this.motivoConsulta,
      diagnostico: diagnostico ?? this.diagnostico,
      observacion: observacion ?? this.observacion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idFicha': this.idFicha,
      'motivoConsulta': this.motivoConsulta,
      'diagnostico': this.diagnostico,
      'observacion': this.observacion,
    };
  }

  factory Ficha.fromMap(Map<String, dynamic> map) {
    return Ficha(
      idFicha: map['idFicha'],
      motivoConsulta: map['motivoConsulta'],
      diagnostico: map['diagnostico'],
      observacion: map['observacion']
    );
  }

  String toJson() => json.encode(toMap());

  factory Ficha.fromJson(String source) =>
      Ficha.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ficha(idFicha: $idFicha, motivoConsulta: $motivoConsulta, diagnostico: $diagnostico, observacion: $observacion)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ficha &&
        other.idFicha == idFicha &&
        other.motivoConsulta == motivoConsulta &&
        other.motivoConsulta == motivoConsulta &&
        other.observacion == observacion;
  }

  @override
  int get hashCode {
    return idFicha.hashCode ^
    motivoConsulta.hashCode ^
    diagnostico.hashCode ^
    observacion.hashCode;
  }
}