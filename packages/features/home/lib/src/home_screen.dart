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
        body: SafeArea(
          child: Padding(
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
                SizedBox(
                  height: 32,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PatientNeedContainer(
                      needColor: Colors.red,
                      needIssue: 'Oxygen',
                      wardName: 'ICU',
                      roomNumber: '101',
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    PatientNeedContainer(
                      needColor: Colors.blue,
                      needIssue: 'Bed',
                      wardName: 'General',
                      roomNumber: '201',
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    PatientNeedContainer(
                      needColor: Colors.blue,
                      needIssue: 'Medicine',
                      wardName: 'Emergency',
                      roomNumber: '301',
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class PatientNeedContainer extends StatelessWidget {
  final Color needColor;
  final String needIssue;
  final String wardName;
  final String roomNumber;

  const PatientNeedContainer(
      {super.key,
      required this.needColor,
      required this.needIssue,
      required this.wardName,
      required this.roomNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 175,
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        color: needColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
                width: 60,
                height: 60,
                child: Icon(Icons.bed)
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Ward: $wardName',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Room NO: $roomNumber',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Issue: $needIssue',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
