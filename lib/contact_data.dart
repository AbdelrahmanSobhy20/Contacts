import 'contact_provider.dart';

class Contact{
  int? id;
  late String name;
  late String phoneNumber;
  late String url;

  Contact({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.url,
});

  Contact.fromMap(Map<String, dynamic> map){
    if(map[columnId] != null) id = map[columnId];
    name = map[columnName];
    phoneNumber = map[columnPhone];
    url = map[columnURL];
  }

  Map <String , dynamic> toMap(){
    Map <String , dynamic> map = {};
    if(id != null) map[columnId] = id;
    map[columnName] = name;
    map[columnPhone] = phoneNumber;
    map[columnURL] = url;
    return map;
  }
}