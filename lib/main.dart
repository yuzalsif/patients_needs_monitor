import 'package:flutter/material.dart';

import 'package:home/home.dart';

void main() {
  runApp(const PatientsNeedsMonitor());
}

class PatientsNeedsMonitor extends StatelessWidget {
  const PatientsNeedsMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patients Needs Monitor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
