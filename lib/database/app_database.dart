import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:text_me/database/DAO/contact_dao.dart';
import 'package:text_me/database/DAO/message_dao.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'chatwithme.db');
  return await openDatabase(path, onCreate: (db, version) async {
    await db.execute(ContactDao.tableSql);
    await db.execute(MessageDao.tableSql);
  }, version: 3
  );
}
