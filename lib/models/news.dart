import 'package:intl/intl.dart';

class News {
  int id;
  String subject;
  String body;
  String createdAt;
  Map<String, dynamic> user;

  News({
    required this.id,
    required this.subject,
    required this.body,
    required this.createdAt,
    required this.user,
  });

  factory News.fromJSON(Map<String, dynamic> json) {
    return News(
      id: json["id"],
      subject: json["subject"],
      body: json["body"],
      createdAt: json["created_at"],
      user: json["user"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "subject": subject,
      "body": body,
      "createdAt": createdAt,
      "user": user,
    };
  }

  String parseTime(String time) {
    DateTime parsedDate = DateTime.parse(time);
    final dateFormat = DateFormat('hh:mm a').format(parsedDate);
    return dateFormat;
  }
}
