class NotificacionesModel {
  NotificacionesModel({this.id, this.titulo, this.mensaje, this.cuerpo});

  int id;
  String titulo;
  String mensaje;
  String cuerpo;

  factory NotificacionesModel.fromJson(Map<String, dynamic> json) =>
      NotificacionesModel(
        id: json["id"],
        titulo: json["titulo"],
        mensaje: json["mensaje"],
        cuerpo: json["cuerpo"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "mensaje": mensaje,
        "cuerpo": cuerpo,
      };
}
