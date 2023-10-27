import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'contact_data.dart';

const String tableContact = 'tablecontact';
const String columnId = '_id';
const String columnName = 'name';
const String columnPhone = 'phone';
const String columnURL = 'url';

class ContactProvider {
  late Database db;
  static final ContactProvider instance = ContactProvider._internal();
  factory ContactProvider() {
    return instance;
  }
  ContactProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'contact.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableContact ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnPhone text not null,
  $columnURL text not null)
''');
    });
  }

  Future<List<Contact>> getAllContacts() async {
    List<Map<String , dynamic >> contactsmaps = await db.query(tableContact);
    if (contactsmaps.isEmpty) {
      return [];
    }else {
      List<Contact> contacts = [];
      for ( var element in contactsmaps){
        contacts.add(Contact.fromMap(element));
      }
      return contacts;
    }
  }

  Future<Contact> insert(Contact contact) async {
    contact.id = await db.insert(tableContact, contact.toMap());
    return contact;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableContact, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Contact contact) async {
    return await db.update(tableContact, contact.toMap(),
        where: '$columnId = ?', whereArgs: [contact.id]);
  }

  Future close() async => db.close();

}
