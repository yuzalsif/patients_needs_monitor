import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('notifications');
//final AudioPlayer _audioPlayer = AudioPlayer();
  List<Map<dynamic, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    // Set up listener for new notifications
    _databaseReference.onChildAdded.listen((event) {
      setState(() {
        // Accessing snapshot safely using null-aware operator
        Map<dynamic, dynamic>? snapshotValue = event.snapshot.value as Map?;
        if (snapshotValue != null) {
          notifications.add({
            'key': event.snapshot.key, // Store the Firebase key for deletion
            'floor': snapshotValue['floor'] ??
                'N/A', // Provide default value if null
            'ward': snapshotValue['ward'] ?? 'N/A',
            'bed': snapshotValue['bed'] ?? 'N/A',
            'message': snapshotValue['message'] ?? 'No message',
          });
        //   _playSoundFromUrl('https://drive.google.com/uc?export=download&id=1sW5U2dvQC7gbxFa0feVabpN0Ic3Omu8k');
        }
      });
    });
    
      
    // Set up listener for removed notifications
    _databaseReference.onChildRemoved.listen((event) {
      setState(() {
        // Find and remove the deleted notification from the list
        notifications.removeWhere(
            (notification) => notification['key'] == event.snapshot.key);
      });
    });
  }

  //  void _playSoundFromUrl(String url) async {
  //   await _audioPlayer.play(UrlSource(url));

  // }
  

void deleteNotification(String keyToDelete) {
  // Remove from Firebase and local list when container is deleted
  _databaseReference.child(keyToDelete).remove();
  setState(() {
    notifications.removeWhere((notification) => notification['key'] == keyToDelete);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE5E5E5),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Patients Needs Monitor',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: Wrap(
                    spacing: 8.0, // Space between items
                    runSpacing: 8.0, // Space between lines
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(notifications.length, (index) {
                      final notification = notifications[index];
                      return PatientNeedContainer(
                        key: ValueKey(notification['key']),
                        needColor: notification['message'] == 'Intravenous therapy' ||
                                notification['message'] == 'Health status change'
                            ? const Color(0xFFFF8686) // FF8686 color for specific messages
                            : const Color(0xFF3579F8), // 3579F8 color for other messages
                        needIssue: notification['message'],
                        wardName: notification['ward'],
                        roomNumber: notification['floor'],
                        onDelete: () => deleteNotification(notification['key']),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class PatientNeedContainer extends StatefulWidget {
  final Color needColor;
  final String needIssue;
  final String wardName;
  final String roomNumber;
  final VoidCallback onDelete;

  const PatientNeedContainer({
    super.key,
    required this.needColor,
    required this.needIssue,
    required this.wardName,
    required this.roomNumber,
    required this.onDelete
  });

  @override
  PatientNeedContainerState createState() => PatientNeedContainerState();
}

class PatientNeedContainerState extends State<PatientNeedContainer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  late Timer _timer;
  int _countdownSeconds = 30;

  @override
  void initState() {
    super.initState();
    // Play sound when the widget is built
    _playSound();
    // Start timer for deletion countdown
    _startCountdownTimer();
  }

  @override
  void dispose() {
    // Stop sound when the widget is disposed
    _audioPlayer.stop();
    _timer.cancel();
    super.dispose();
  }

  void _playSound() async {
    // Check if already playing to avoid overlapping sounds
    if (!_isPlaying) {
      setState(() {
        _isPlaying = true;
      });
      await _audioPlayer.play(
          UrlSource('https://drive.google.com/uc?export=download&id=1sW5U2dvQC7gbxFa0feVabpN0Ic3Omu8k'));
      setState(() {
        _isPlaying = false;
      });
    }
  }
//https://drive.google.com/file/d/1Pj6aSAYmQClMnRGmQwdZkQ4LHy_Vuuy0/view?usp=sharing 
void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else {
          // Timer expired, delete container and data
          widget.onDelete();
          _timer.cancel(); // Cancel timer after deletion
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 175,
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        color: widget.needColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(width: 60, height: 60, child: Icon(Icons.bed)),
            const SizedBox(height: 16),
            Text(
              'Ward: ${widget.wardName}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'bed NO: ${widget.roomNumber}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Issue: ${widget.needIssue}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8,),
             Text(
              'Disappearing in $_countdownSeconds seconds',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}