// All Flutter Built-in Imports Here.

// All Custom Imports Here.

// All Native Imports Here.

// All Attributes or Constants Here.

class SportsData {
  static List<String> sports = [
    'Football',
    'Basketball',
    'Tennis',
    'Swimming',
    'Athletics'
  ];
  static Map<String, List<Event>> events = {
    'Football': [
      Event(name: 'Match 1', minAge: 10, maxAge: 18, gender: genderMale),
      Event(name: 'Match 2', minAge: 12, maxAge: 18, gender: genderFemale),
    ],
    'Basketball': [
      Event(name: 'Game 1', minAge: 11, maxAge: 18, gender: genderFemale),
      Event(name: 'Game 2', minAge: 13, maxAge: 18, gender: genderMale),
    ],
    'Tennis': [
      Event(name: 'Tournament 1', minAge: 12, maxAge: 18, gender: genderMale),
      Event(
          name: 'Tournament 2', minAge: 14, maxAge: 18, gender: genderFemale),
    ],
    'Swimming': [
      Event(name: 'Swim Meet 1', minAge: 10, maxAge: 18, gender: genderMale),
      Event(name: 'Swim Meet 2', minAge: 11, maxAge: 18, gender: genderFemale),
    ],
    'Athletics': [
      Event(name: 'Race 1', minAge: 10, maxAge: 18, gender: genderMale),
      Event(name: 'Race 2', minAge: 12, maxAge: 18, gender: genderMale),
    ],
  };
}

const String genderMale = 'Male';
const String genderFemale = 'Female';

class Event {
  final String name;
  final int minAge;
  final int maxAge;
  final String gender;

  Event({
    required this.name,
    required this.minAge,
    required this.maxAge,
    required this.gender,
  });
}
