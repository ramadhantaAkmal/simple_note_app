import 'dart:convert';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  NoteModel({
    required this.id,
    required this.title,
    required this.desc,
  });

  int id;
  String title;
  String desc;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "desc": desc,
      };
}
