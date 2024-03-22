// All Flutter Built-in Imports Here.
import 'package:flutter/material.dart';

// All Custom Imports Here.
import 'package:flutter_bloc/flutter_bloc.dart';

// All Native Imports Here.
import 'package:student_registration/constants/colors.dart';
import 'package:student_registration/constants/theme.dart';
import 'package:student_registration/helpers/helpers.dart';
import 'package:student_registration/views/form/data.dart';
import 'package:student_registration/views/form/blocs/cubits.dart';
import 'package:student_registration/views/form/blocs/states.dart';

// All Attributes or Constants Here.

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController parentContactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    RegFormCubit regFormCubit = BlocProvider.of<RegFormCubit>(context);
    return BlocConsumer<RegFormCubit, RegFormState>(
      listener: (context, state) {
        if (state is AddSportErrorState) {
          return showMessage(context, state.err, Colors.redAccent);
        } else if (state is SportAddedState) {
          return showMessage(context, 'Sport added', Colors.green);
        } else if (state is SportRemovedState) {
          return showMessage(context, 'Sport removed', Colors.black);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: ListView(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.person,
                        color: AppColors.formTitle,
                      ),
                    ),
                    Text(
                      'Student Details',
                      style:
                          TextStyle(fontSize: 18, color: AppColors.formTitle),
                    ),
                  ],
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: contactNumberController,
                  decoration:
                      const InputDecoration(labelText: 'Contact Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    } else if (value.length < 10 || value.length > 10) {
                      return 'Enter a valid 10-digit contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!value.contains('@')) {
                      return 'Invalid email should contain @';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: aadharController,
                  decoration:
                      const InputDecoration(labelText: 'Aadhar Card Number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Aadhar card number';
                    } else if (value.length != 12) {
                      return 'Invalid aadhar enter 12 digit valid number ';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                            value: 'Male',
                            groupValue: regFormCubit.selectedGender,
                            onChanged: (val) {
                              regFormCubit.onGenderSelection(val!);
                            }),
                        const Text(
                          'Male',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                            value: 'Female',
                            groupValue: regFormCubit.selectedGender,
                            onChanged: (val) {
                              regFormCubit.onGenderSelection(val!);
                            }),
                        const Text(
                          'Female',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Date of Birth'),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _selectDate(context, regFormCubit.selectedDate);
                    },
                    child: Chip(
                      backgroundColor: Colors.indigoAccent.withOpacity(0.2),
                      label: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.calendar_month,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  subtitle: Text(
                      regFormCubit.selDateAlias(regFormCubit.selectedDate)),
                ),
                if (regFormCubit.calculateAge(regFormCubit.selectedDate) ==
                    true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: Colors.indigoAccent,
                        thickness: 3,
                        height: 100,
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.perm_contact_cal_rounded,
                              color: AppColors.formTitle,
                            ),
                          ),
                          Text(
                            'Parent Details',
                            style: TextStyle(
                                fontSize: 18, color: AppColors.formTitle),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: parentNameController,
                        decoration:
                            const InputDecoration(labelText: 'Parent\'s Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter parent\'s name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: parentContactNumberController,
                        decoration: const InputDecoration(
                            labelText: 'Parent\'s Contact Number'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter parent\'s contact number';
                          } else if (value.length < 10 || value.length > 10) {
                            return 'Enter 10 digit valid contact number';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                const Divider(
                  color: Colors.indigoAccent,
                  thickness: 3,
                  height: 100,
                ),
                const Text(
                  'Select Sport',
                  style: TextStyle(fontSize: 18, color: AppColors.formTitle),
                ),
                DropdownButtonFormField<String>(
                  value: null,
                  items: SportsData.sports.map((sport) {
                    return DropdownMenuItem<String>(
                        value: sport,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(sport),
                            ]));
                  }).toList(),
                  onChanged: (value) {
                    regFormCubit.currentSelectedSport = value;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Select Sports (Multiple)'),
                  validator: (value) {
                    if (regFormCubit.selectedSportEvent.keys.isEmpty) {
                      return 'Please select at least one sport';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                if (regFormCubit.currentSelectedSport != null)
                  Column(
                    children: [
                      ...SportsData.events[regFormCubit.currentSelectedSport]!
                          .map(
                            (e) => Row(
                              children: [
                                Radio<String>(
                                    value: e.name,
                                    groupValue:
                                        regFormCubit.currentSelectedEvent,
                                    onChanged: (value) {
                                      regFormCubit.currentSelectedEvent = value;
                                    }),
                                Text(
                                    '${e.name} (${e.minAge} - ${e.maxAge}/yrs, ${e.gender})',
                                    style: const TextStyle(fontSize: 15)),
                                const SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          )
                          .toList(),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                regFormCubit.onPressedAddSport();
                              },
                              child: const Text('Add sport')))
                    ],
                  ),
                const SizedBox(height: 40),
                if (regFormCubit.selectedSportEvent.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Selected Sports',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      if (regFormCubit.selectedSportEvent.isNotEmpty)
                        Column(
                            children: regFormCubit.selectedSportEvent.entries
                                .map((entry) {
                          String sport = entry.key;
                          Event event = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Chip(
                                      backgroundColor:
                                          Colors.indigoAccent.withOpacity(0.8),
                                      label: Text(
                                        "$sport - ${event.name * 4} (${event.gender} ${event.minAge}-${event.maxAge}/yrs)",
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      print(88888888);
                                      regFormCubit.onPressedRemoveSportEvent(
                                          sport, event.name);
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                    ))
                              ],
                            ),
                          );
                        }).toList()),
                    ],
                  ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process registration
                        _submitForm(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Colors.indigoAccent,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context, DateTime? selectedDate) async {
    RegFormCubit regFormCubit = BlocProvider.of<RegFormCubit>(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      regFormCubit.selectedDate = picked;
    }
  }

  _submitForm(BuildContext context) {
    RegFormCubit regFormCubit = BlocProvider.of<RegFormCubit>(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.indigoAccent,
          title: const Text('Registration Summary',
              style: TextStyle(color: Colors.white, fontSize: 18)),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Student Details', style: summaryTitleStyle),
                TitleValueRow(
                    keyText: 'Student Name', valueText: nameController.text),
                TitleValueRow(
                    keyText: 'Contact Number',
                    valueText: contactNumberController.text),
                TitleValueRow(
                    keyText: 'Email', valueText: emailController.text),
                TitleValueRow(
                    keyText: 'Aadhar Number', valueText: aadharController.text),
                TitleValueRow(
                    keyText: 'Gender', valueText: regFormCubit.selectedGender!),
                TitleValueRow(
                    keyText: 'DOB', valueText: regFormCubit.selectedDateAlias),
                const SizedBox(height: 20),
                const Divider(color: Colors.white, thickness: 1),
                if (regFormCubit.studentAge! < 18)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Parent Details', style: summaryTitleStyle),
                      TitleValueRow(
                          keyText: "Parent's Name",
                          valueText: parentNameController.text),
                      TitleValueRow(
                          keyText: "Parent's Number",
                          valueText: parentContactNumberController.text),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white, thickness: 1),
                    ],
                  ),
                Text('Selected Sport Details', style: summaryTitleStyle),
                Column(
                  children:
                      regFormCubit.selectedSportEvent.entries.map((entry) {
                    return TitleValueRow(
                        keyText: entry.key,
                        valueText:
                            '${entry.value.name} (${entry.value.gender} ${entry.value.minAge} ${entry.value.maxAge}/yrs)');
                  }).toList(),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _formKey.currentState!.save();
                        nameController.clear();
                        contactNumberController.clear();
                        emailController.clear();
                        aadharController.clear();
                        parentNameController.clear();
                        parentContactNumberController.clear();
                        regFormCubit.clear();
                      },
                      child: const Text('Register New Student')),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class TitleValueRow extends StatelessWidget {
  final String keyText;
  final String valueText;

  const TitleValueRow({
    Key? key,
    required this.keyText,
    required this.valueText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Text(
            keyText,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
          const SizedBox(width: 10),
          const Text(
            ':',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Text(valueText,
                  style: const TextStyle(fontSize: 15, color: Colors.white))),
        ],
      ),
    );
  }
}
