// All Flutter Built-in Imports Here.

// All Custom Imports Here.

// All Native Imports Here.

// All Attributes or Constants Here.

abstract class RegFormState {}

class RegFormInitialState extends RegFormState {}

class GenderSelectedState extends RegFormState {}

class DateOfBirthSelectedState extends RegFormState {}

class SelectedDateAliasState extends RegFormState {}

class SportSelectedState extends RegFormState {}

class EventSelectedState extends RegFormState {}

class AgeCalculatedState extends RegFormState {}

class AddSportState extends RegFormState {}

class SportAddedState extends RegFormState {}

class AddSportErrorState extends RegFormState {
  String err;

  AddSportErrorState(this.err);
}

class SportRemovedState extends RegFormState {}
