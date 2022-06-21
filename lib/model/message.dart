import 'package:text_me/model/contact.dart';

class Message {
  Message(
      {required this.id,
      required this.title,
      required this.text,
      required this.contactName,
      required this.contactEmail});

  final int id;
  final String title;
  final String text;
  final String contactName;
  final String contactEmail;
}
