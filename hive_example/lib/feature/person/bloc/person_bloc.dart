import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_example/domain/person_entity.dart';
import 'package:hive_example/domain/person_usercase.dart';

import '../../../data/person.dart';

part 'person_event.dart';

part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonUseCase personUseCase;

  PersonBloc(this.personUseCase) : super(PersonState.initial()) {
    on<InitEvent>(_init);
    on<AddContact>(_addContact);
    on<ReadContentEvent>(_readContacts);
    add(InitEvent());
  }

  void _init(InitEvent event, Emitter<PersonState> emit){
    add(ReadContentEvent());
  }
  Future<void> _addContact(AddContact event, Emitter<PersonState> emit) async {
    emit(state.copyWith(isLoading: true, message: ''));
    try {
      final contactAdded = await personUseCase.addContact(event.person);
      if (!contactAdded) {
        emit(state.copyWith(isLoading: false, message: "Error adding contact"));
        return;
      }

      // Refresh the list after adding contact
      final updatedList = await personUseCase.getContacts();
      emit(state.copyWith(
        isLoading: false,
        contactList: updatedList,
        message: '',   // CLEAR MESSAGE
      ));

    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        message: 'Something went wrong!'
      ));
    }
  }

  Future<void> _readContacts(
      ReadContentEvent event,
      Emitter<PersonState> emit,
      ) async {

    emit(state.copyWith(isLoading: true, message: ''));

    try {
      final contactsList = await personUseCase.getContacts();

      emit(state.copyWith(
        contactList: contactsList,
        isLoading: false,
        message: contactsList.isEmpty
            ? "No contacts found"
            : '',
      ));

    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        message: "Failed to load contacts",
      ));
    }
  }

}
