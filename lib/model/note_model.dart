import 'dart:convert';

NoteModel noteModelFromJson(String str) => NoteModel.fromJson(json.decode(str));

String noteModelToJson(NoteModel data) => json.encode(data.toJson());

class NoteModel {
  NoteModel({
    required this.title,
    required this.desc,
  });

  String title;
  String desc;

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        title: json["title"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "desc": desc,
      };

  Map<String, dynamic> toMap() => {
        "title": title,
        "desc": desc,
      };
}
