import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patients Needs Monitor',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      )
    );
  }
}

class PatientNeedContainer extends StatelessWidget {
  final Color needColor;
  final String needIssue;
  final String wardName;
  final String roomNumber;

  const PatientNeedContainer({super.key,
    required this.needColor,
    required this.needIssue,
    required this.wardName,
    required this.roomNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: needColor,
      child: Column(
        children: [
          Text(needIssue),
          Text(wardName),
          Text(roomNumber),
        ],
      ),
    );
  }
}

