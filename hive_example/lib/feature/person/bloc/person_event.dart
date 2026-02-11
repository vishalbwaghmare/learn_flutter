part of 'person_bloc.dart';

sealed class PersonEvent extends Equatable {
  const PersonEvent();
}

final class InitEvent extends PersonEvent{
  @override
  List<Object?> get props => [];
}

final class LoadingEvent extends PersonEvent{
  @override
  List<Object?> get props => [];
}

final class AddContact extends PersonEvent{
  final Person person;
  const AddContact(this.person);
  @override
  List<Object?> get props => [person];
}

final class ReadContentEvent extends PersonEvent{
  @override
  List<Object?> get props => [];
}

