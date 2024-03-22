// All Flutter Built-in Imports Here.
import 'package:flutter/material.dart';

// All Custom Imports Here.
import 'package:flutter_bloc/flutter_bloc.dart';

// All Native Imports Here.
import 'package:student_registration/views/form/blocs/cubits.dart';
import 'package:student_registration/views/form/widgets/widgets.dart';

// All Attributes or Constants Here.

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Student Registration'),
        backgroundColor: Colors.indigoAccent,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
      ),
      body: BlocProvider(
          create: (context) => RegFormCubit(), child: const RegistrationForm()),
    );
  }
}
