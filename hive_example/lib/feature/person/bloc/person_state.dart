part of 'person_bloc.dart';

class PersonState extends Equatable {
  final String message;
  final List<PersonEntity> contactList;
  final bool isLoading;

  const PersonState({required this.message, required this.contactList, required this.isLoading});

  factory PersonState.initial() {
    return PersonState(message: 'Welcome', contactList: [], isLoading: false);
  }

  PersonState copyWith({String? message, List<PersonEntity>? contactList, bool? isLoading}) {
    return PersonState(
      message: message ?? this.message,
      contactList: contactList ?? this.contactList, isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [message, contactList, isLoading];
}
