import 'package:sqflite/sqflite.dart';
import 'package:text_me/database/app_database.dart';
import 'package:text_me/model/message.dart';

class MessageDao {
  static const String tableSql = 'CREATE TABLE $_tableName ('
      'id INTEGER PRIMARY KEY,'
      'title TEXT,'
      'text TEXT,'
      'contactName TEXT,'
      'contactEmail TEXT)';

  static const String _tableName = 'messageList';
  static const String _id = 'id';
  static const String title = 'title';
  static const String text = 'text';
  static const String contactName = 'contactName';
  static const String contactEmail = 'contactEmail';

  Future<int> save(Message newMessage) async {
    final Database db = await getDatabase();
    Map<String, dynamic> messagetMap = _toMap(newMessage);
    return db.insert(_tableName, messagetMap);
  }

  Map<String, dynamic> _toMap(Message newMessage) {
    final Map<String, dynamic> messagelistMap = Map();
    messagelistMap[title] = newMessage.title;
    messagelistMap[text] = newMessage.text;
    messagelistMap[contactName] = newMessage.contactName;
    messagelistMap[contactEmail] = newMessage.contactEmail;
    return messagelistMap;
  }

  Future<List<Message>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Message> messageList = _toList(result);
    return messageList;
  }

  List<Message> _toList(List<Map<String, dynamic>> result) {
    final List<Message> messageList = [];
    for (Map<String, dynamic> row in result) {
      final Message message = Message(
          id: row[_id],
          title: row[title],
          text: row[text],
          contactName: row[contactName],
          contactEmail: row[contactEmail]);
      messageList.add(message);
    }
    return messageList;
  }

  Future<int> deleteItem(int id) async {
    final Database db = await getDatabase();
    return await db.rawDelete('DELETE FROM $_tableName WHERE $_id = ?', [id]);
  }
}
