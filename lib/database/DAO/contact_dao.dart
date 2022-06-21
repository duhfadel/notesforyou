import 'package:sqflite/sqflite.dart';
import 'package:text_me/database/app_database.dart';
import 'package:text_me/model/contact.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName ('
      'id INTEGER PRIMARY KEY,'
      'name TEXT,'
      'email TEXT)';

  static const String _tableName = 'contactList';
  static const String _id = 'id';
  static const String name = 'name';
  static const String email = 'email';

  Future<int> save(Contact newContact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactlistMap = _toMap(newContact);
    return db.insert(_tableName, contactlistMap);
  }

  Map<String, dynamic> _toMap(Contact newContact) {
    final Map<String, dynamic> contactlistMap = Map();
    contactlistMap[name] = newContact.name;
    contactlistMap[email] = newContact.email;
    return contactlistMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contactList = _toList(result);
    return contactList;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contactList = [];
    for (Map<String, dynamic> row in result) {
      final Contact contact =
          Contact(id: row[_id], name: row[name], email: row[email]);
      contactList.add(contact);
    }
    return contactList;
  }

  Future<int> deleteItem(int id) async {
    final Database db = await getDatabase();
    return await db.rawDelete('DELETE FROM $_tableName WHERE $_id = ?', [id]);
  }
}
