class NoteModel {
  int? id;
  String title;
  String subtitle;
  NoteModel({this.id, required this.title, required this.subtitle});

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
      id: json['id'], title: json["title"], subtitle: json["subtitle"]);

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "subtitle": subtitle,
  };
}