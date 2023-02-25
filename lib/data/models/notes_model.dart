class NotesModel {
  final dynamic id;
  final String text;
  final dynamic userId;
  final String placeDateTime;
  NotesModel({
    required this.id,
    required this.text,
    required this.userId,
    required this.placeDateTime,
  });
  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['id'],
      text: json['text'],
      userId: json['userId'],
      placeDateTime: json['placeDateTime'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "text": text,
      "userId": userId,
      "placeDateTime": placeDateTime,
    };
  }
}
