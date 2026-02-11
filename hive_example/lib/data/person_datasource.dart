import 'package:hive/hive.dart';
import 'package:hive_example/data/person.dart';

abstract class PersonLocalDataSource{
  Future<bool> addContact(Person person);
  Future<List<Person>> getContacts();
}

class PersonDatasource extends PersonLocalDataSource {
  late Box<Person> personBox;
  PersonDatasource(){
    personBox = Hive.box<Person>('personBox');
  }

  @override
  Future<bool> addContact(Person person) async{
    try{
      await personBox.add(person);
      return true;
    }catch(e){
      print('INFO: ERROR ${e.toString()}');
      return false;
    }
  }

  @override
  Future<List<Person>> getContacts() async{
    try{
      List<Person> contactList =  personBox.values.toList();
      personBox.toMap().forEach((key, value){
        contactList.add(value);
      });
      return contactList;
    }catch(e){
      throw Exception("Failed to load contacts");
    }
  }
  
}