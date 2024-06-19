import 'package:dentalprogapplication/admin/misc/CurrentDayTime.dart';
import 'package:dentalprogapplication/admin/misc/FutureDayTime.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SchedulePage());
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  List<String> bookedSlots = [];
  bool isAdmin = false;
  StreamSubscription<QuerySnapshot>? scheduleSubscription;

  @override
  void initState() {
    super.initState();
    fetchSchedules();
    checkAdminStatus();
  }

  @override
  void dispose() {
    scheduleSubscription?.cancel();
    super.dispose();
  }

  Future<void> checkAdminStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAdmin = prefs.getBool('isAdmin') ?? false;
    });
  }

  void fetchSchedules() {
    scheduleSubscription = FirebaseFirestore.instance
        .collection('schedule')
        .snapshots()
        .listen((querySnapshot) {
      if (mounted) {
        List<Map<String, dynamic>> schedules = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final date = data['date'] ?? 'Unknown date';
          final time = data['time'] ?? 'Unknown time';
          return {
            'date': date,
            'time': time,
            'dateTime': DateTime.parse("$date ${_convertTo24HourFormat(time)}")
          };
        }).toList();
        schedules.sort((a, b) => b['dateTime'].compareTo(a['dateTime']));

        setState(() {
          bookedSlots = schedules.map((schedule) {
            return "${schedule['date']} ${schedule['time']}";
          }).toList();
        });
      }
    }, onError: (e) {
      showAlert('Error fetching schedules. Please try again later.');
    });
  }

  String _convertTo24HourFormat(String time) {
    DateFormat dateFormat = DateFormat.jm();
    DateTime dateTime = dateFormat.parse(time);
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  void _selectDate() async {
    final DateTime now = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );
    if (selectedDate != null) {
      if (selectedDate.isBefore(DateTime(now.year, now.month, now.day))) {
        showAlert("Cannot select a past date.");
      } else {
        if (mounted) {
          setState(() {
            dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
            timeController.clear();
          });
        }
      }
    }
  }

  void _selectTime() async {
    if (dateController.text.isEmpty) {
      showAlert("Please select a date first.");
      return;
    }

    final DateTime selectedDate = DateTime.parse(dateController.text);
    final now = DateTime.now();
    final initialTime =
        TimeOfDay.fromDateTime(selectedDate.isBefore(now) ? now : selectedDate);
    final bookedTimes = await _getBookedTimesForDate(dateController.text);

    final TimeOfDay? selectedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        if (selectedDate.year == now.year &&
            selectedDate.month == now.month &&
            selectedDate.day == now.day) {
          return CurrentDayTimePicker(
            bookedTimes: bookedTimes,
            initialTime: initialTime,
            isAdmin: isAdmin,
          );
        } else {
          return FutureDayTimePicker(
            bookedTimes: bookedTimes,
            initialTime: initialTime,
            isAdmin: isAdmin,
          );
        }
      },
    );

    if (selectedTime != null) {
      final DateTime selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      String formattedTime = DateFormat('hh:mm a').format(selectedDateTime);
      String combinedDateTime = "${dateController.text} $formattedTime";

      if (await isScheduleExisting(combinedDateTime)) {
        showAlert("This schedule already exists.");
        return;
      }

      if (mounted) {
        setState(() {
          timeController.text = formattedTime;
        });
      }
    }
  }

  Future<List<TimeOfDay>> _getBookedTimesForDate(String date) async {
    final bookedTimes = await FirebaseFirestore.instance
        .collection('schedule')
        .where('date', isEqualTo: date)
        .get();

    return bookedTimes.docs.map((doc) {
      final data = doc.data();
      final time = data['time'] as String;
      final timeOfDay = DateFormat.jm().parse(time);
      return TimeOfDay.fromDateTime(timeOfDay);
    }).toList();
  }

  Future<bool> isScheduleExisting(String combinedDateTime) async {
    String date = combinedDateTime.split(" ")[0];
    String time = combinedDateTime.split(" ")[1];

    final existingSchedules = await FirebaseFirestore.instance
        .collection('schedule')
        .where('date', isEqualTo: date)
        .where('time', isEqualTo: time)
        .get();

    return existingSchedules.docs.isNotEmpty;
  }

  void showAlert(String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Warning"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    );
  }

  void _saveSchedule() async {
    if (dateController.text.isEmpty || timeController.text.isEmpty) {
      showAlert("Please select both date and time.");
      return;
    }

    String combinedDateTime = "${dateController.text} ${timeController.text}";

    if (await isScheduleExisting(combinedDateTime)) {
      showAlert("This schedule already exists.");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('schedule').add({
        'date': dateController.text,
        'time': timeController.text,
      });
      if (mounted) {
        setState(() {
          dateController.clear();
          timeController.clear();
        });
        fetchSchedules();
        showAlert("Schedule successfully added.");
      }
    } catch (e) {
      showAlert("Error saving schedule: $e");
    }
  }

  void _showAddScheduleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: dateController,
                  readOnly: true,
                  onTap: () => _selectDate(),
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    filled: true,
                    fillColor: Colors.red[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: timeController,
                  readOnly: true,
                  onTap: () => _selectTime(),
                  decoration: InputDecoration(
                    labelText: 'Select Time',
                    filled: true,
                    fillColor: Colors.red[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveSchedule,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Schedule Appointment'),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.asset('asset/appointment.png',
                            height: 50, width: 50),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Appointments',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _showAddScheduleDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('ADD SCHEDULE'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: bookedSlots.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(bookedSlots[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
