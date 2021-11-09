import 'dart:convert';

class Persona {
  int? idPersona;
  String? nombre;
  String? apellido;
  String? email;
  String? telefono;
  String? ruc;
  String? cedula;
  String? tipoPersona;
  String? usuarioLogin;
  String? fechaNacimiento;
  Persona({
    this.idPersona,
    this.nombre,
    this.apellido,
    this.email,
    this.telefono,
    this.ruc,
    this.cedula,
    this.tipoPersona,
    this.usuarioLogin,
    this.fechaNacimiento,
  });

  Persona copyWith({
    int? idPersona,
    String? nombre,
    String? apellido,
    String? email,
    String? telefono,
    String? ruc,
    String? cedula,
    String? tipoPersona,
    String? usuarioLogin,
    String? fechaNacimiento,
  }) {
    return Persona(
      idPersona: idPersona ?? this.idPersona,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      ruc: ruc ?? this.ruc,
      cedula: cedula ?? this.cedula,
      tipoPersona: tipoPersona ?? this.tipoPersona,
      usuarioLogin: usuarioLogin ?? this.usuarioLogin,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idPersona': idPersona,
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'telefono': telefono,
      'ruc': ruc,
      'cedula': cedula,
      'tipoPersona': tipoPersona,
      'usuarioLogin': usuarioLogin,
      'fechaNacimiento': fechaNacimiento,
    };
  }

  factory Persona.fromMap(Map<String, dynamic> map) {
    return Persona(
      idPersona: map['idPersona'] != null ? map['idPersona'] : null,
      nombre: map['nombre'] != null ? map['nombre'] : null,
      apellido: map['apellido'] != null ? map['apellido'] : null,
      email: map['email'] != null ? map['email'] : null,
      telefono: map['telefono'] != null ? map['telefono'] : null,
      ruc: map['ruc'] != null ? map['ruc'] : null,
      cedula: map['cedula'] != null ? map['cedula'] : null,
      tipoPersona: map['tipoPersona'] != null ? map['tipoPersona'] : null,
      usuarioLogin: map['usuarioLogin'] != null ? map['usuarioLogin'] : null,
      fechaNacimiento:
          map['fechaNacimiento'] != null ? map['fechaNacimiento'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Persona.fromJson(String source) =>
      Persona.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Persona(idPersona: $idPersona, nombre: $nombre, apellido: $apellido, email: $email, telefono: $telefono, ruc: $ruc, cedula: $cedula, tipoPersona: $tipoPersona, usuarioLogin: $usuarioLogin, fechaNacimiento: $fechaNacimiento)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Persona &&
        other.idPersona == idPersona &&
        other.nombre == nombre &&
        other.apellido == apellido &&
        other.email == email &&
        other.telefono == telefono &&
        other.ruc == ruc &&
        other.cedula == cedula &&
        other.tipoPersona == tipoPersona &&
        other.usuarioLogin == usuarioLogin &&
        other.fechaNacimiento == fechaNacimiento;
  }

  @override
  int get hashCode {
    return idPersona.hashCode ^
        nombre.hashCode ^
        apellido.hashCode ^
        email.hashCode ^
        telefono.hashCode ^
        ruc.hashCode ^
        cedula.hashCode ^
        tipoPersona.hashCode ^
        usuarioLogin.hashCode ^
        fechaNacimiento.hashCode;
  }
}
