import 'package:hive_example/data/person.dart';
import 'package:hive_example/data/person_datasource.dart';
import 'package:hive_example/domain/person_entity.dart';

abstract class PersonMapperBluePrint{
  Future<bool> addContact(Person person);
  Future<List<PersonEntity>> getContacts();
}

class PersonMapper extends PersonMapperBluePrint {
  final PersonDatasource _personDatasource = PersonDatasource();
  PersonMapper();
  @override
  Future<bool> addContact(Person person) async{
    bool isSuccessful = await _personDatasource.addContact(person);
    return isSuccessful;
  }

  @override
  Future<List<PersonEntity>> getContacts() async{
    List<Person> contactList = await _personDatasource.getContacts();
    List<PersonEntity> contactEntityList = [];
    if(contactList.isNotEmpty){
      for (var contact in contactList) {
        contactEntityList.add(PersonEntity.fromJson(contact.toJson()));
      }
    }
    return contactEntityList;
  }

}