import 'package:hive_example/data/person_mapper.dart';
import 'package:hive_example/domain/person_entity.dart';

import '../data/person.dart';

abstract class PersonUseCase{
  Future<bool> addContact(Person person);
  Future<List<PersonEntity>> getContacts();
}

class PersonUseCaseImpl extends PersonUseCase{
  final PersonMapper _personMapper = PersonMapper();
  @override
  Future<bool> addContact(Person person) async{
    bool isSuccessful = await _personMapper.addContact(person);
    return isSuccessful;
  }

  @override
  Future<List<PersonEntity>> getContacts() async {
    List<PersonEntity> contactList = await _personMapper.getContacts();
    return contactList;
  }
  
}