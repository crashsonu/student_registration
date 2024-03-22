// All Flutter Built-in Imports Here.

// All Custom Imports Here.
import 'package:flutter_bloc/flutter_bloc.dart';

// All Native Imports Here.
import 'package:student_registration/views/form/blocs/states.dart';
import 'package:student_registration/views/form/data.dart';

// All Attributes or Constants Here.

class RegFormCubit extends Cubit<RegFormState> {
  DateTime? selectedDate;
  String? selectedGender;
  String? currentSelectedSport;
  String? currentSelectedEvent;
  Map<String, Event> selectedSportEvent = {};
  int? studentAge;

  String selectedDateAlias = 'Select Date of Birth';

  RegFormCubit() : super(RegFormInitialState());

  onGenderSelection(String gender) {
    selectedGender = gender;
    emit(GenderSelectedState());
  }

  onDateSelection(DateTime date) {
    selectedDate = date;
    emit(DateOfBirthSelectedState());
  }

  onSportSelection(String sport) {
    currentSelectedSport = sport;
    emit(SportSelectedState());
  }

  onEventSelection(String event) {
    currentSelectedEvent = event;
    emit(EventSelectedState());
  }

  onPressedRemoveSportEvent(String sport, String event) {
    if (selectedSportEvent.isEmpty) return;
    selectedSportEvent.entries
        .map((entry) => {
              if (sport == entry.key && event == entry.value.name)
                {selectedSportEvent.remove(sport), emit(SportRemovedState())}
            })
        .toList();

  }

  onPressedAddSport() {
    if (currentSelectedEvent == null) {
      emit(AddSportErrorState('Please select the event'));
      return;
    }
    List selectedEventNames =
        selectedSportEvent.values.map((e) => e.name).toList();
    print(selectedEventNames);

    if (currentSelectedSport != null && currentSelectedEvent != null) {
      if (selectedSportEvent.keys.contains(currentSelectedSport) &&
          selectedEventNames.contains(currentSelectedEvent)) {
        emit(AddSportErrorState(
            'Selected Sport and event has been already added.'));
        return;
      } else if (selectedGender == null) {
        emit(AddSportErrorState('Please select your gender'));
        return;
      } else if (studentAge == null) {
        emit(AddSportErrorState('Add your date of birth first to add sport'));
        return;
      } else {
        SportsData.events[currentSelectedSport]!
            .map((event) => {
                  if (event.name == currentSelectedEvent)
                    {
                      if (selectedGender != event.gender)
                        {
                          emit(AddSportErrorState(
                              'Only ${event.gender} student can participate in this event'))
                        }
                      else if (studentAge! >= event.minAge &&
                          studentAge! <= event.maxAge)
                        {
                          selectedSportEvent[currentSelectedSport!] = event,
                          print(selectedSportEvent),
                          emit(SportAddedState()),
                        }
                      else
                        {
                          emit(AddSportErrorState(
                              'You cant apply for this event age should between ${event.minAge}-${event.maxAge} your age is $studentAge'))
                        }
                    }
                })
            .toList();
      }
    }
  }

  bool calculateAge(DateTime? date) {
    if (date == null) {
      emit(AgeCalculatedState());
      return false;
    }
    final DateTime now = DateTime.now();
    final int age = now.year - date.year;
    final bool ageValidator = age < 18;
    studentAge = age;
    emit(AgeCalculatedState());
    return ageValidator;
  }

  String selDateAlias(DateTime? dateT) {
    if (dateT == null) {
      emit(SelectedDateAliasState());

      return 'Select Date of Birth';
    }
    emit(SelectedDateAliasState());
    selectedDateAlias = '${dateT.day} / ${dateT.month} / ${dateT.year}';
    return '${dateT.day} / ${dateT.month} / ${dateT.year}';
  }

  clear() {
    selectedDate = null;
    selectedGender = null;
    currentSelectedSport = null;
    currentSelectedEvent = null;
    selectedSportEvent = {};
    studentAge = null;
    selectedDateAlias = 'Select Date of Birth';
    emit(SummaryDoneState());
  }
}
