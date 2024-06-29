import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
