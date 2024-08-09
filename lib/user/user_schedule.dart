import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalprogapplication/user/user_back.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const UserSchedulePage());
}

class UserSchedulePage extends StatefulWidget {
  const UserSchedulePage({super.key});

  @override
  _UserSchedulePageState createState() => _UserSchedulePageState();
}

class _UserSchedulePageState extends State<UserSchedulePage> {
  final user = FirebaseAuth.instance.currentUser;
  String name = "";
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  List<TimeOfDay> availableTimes = [];
  List<TimeOfDay> scheduledTimes = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchScheduledTimes(_selectedDate);
  }

  Future<void> fetchData() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          var userData = querySnapshot.docs.first.data() as Map<String, dynamic>?;
          if (userData != null) {
            setState(() {
              name = userData['name'] ?? '';
            });
          }
        }
      }
    } catch (e) {
    }
  }

  Future<void> fetchScheduledTimes(DateTime selectedDate) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('schedule')
          .where('date', isEqualTo: DateFormat('yyyy-MM-dd').format(selectedDate))
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          scheduledTimes = querySnapshot.docs.map((doc) {
            var timeString = doc['time'] as String;
            return _convertToTimeOfDay(timeString);
          }).toList();
        });
      } else {
        setState(() {
          scheduledTimes = [];
        });
      }
      _generateAvailableTimes();
    } catch (e) {
    }
  }

  TimeOfDay _convertToTimeOfDay(String time) {
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(time));
  }

  Future<void> _saveAppointment(DateTime selectedDate, TimeOfDay selectedTime) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        String formattedTime = DateFormat('h:mm a').format(
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute)
        );

        var scheduleDocRef = FirebaseFirestore.instance.collection('schedule').doc();
        String scheduleUid = scheduleDocRef.id;

        await scheduleDocRef.set({
          'userId': user.uid,
          'date': formattedDate,
          'time': formattedTime,
        });

        await FirebaseFirestore.instance.collection('appointment').add({
          'userId': user.uid,
          'name': name,
          'date': formattedDate,
          'time': formattedTime,
          'schedule_uid': scheduleUid,
          'status': 'Pending',
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment and schedule saved successfully!')),
        );
        await fetchScheduledTimes(_selectedDate); // Fetch again to update the state
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save appointment and schedule: $e')),
      );
    }
  }

  void _showTimePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 300,
          child: ListView.builder(
            itemCount: availableTimes.length,
            itemBuilder: (context, index) {
              final time = availableTimes[index];
              return ListTile(
                title: Text(time.format(context)),
                onTap: () {
                  Navigator.pop(context, time);
                },
              );
            },
          ),
        );
      },
    ).then((selectedTime) {
      if (selectedTime != null) {
        _saveAppointment(_selectedDate, selectedTime);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final DateTime lastDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      home: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'asset/bg.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const user_backPage(),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 5),
                      child: const Row(
                        children: [
                          Text(
                            ' USER',
                            style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xddD21f3C),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.3,
                                  child: Image(image: AssetImage('asset/appointment.png')),
                                ),
                                Text('Schedule', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(color: const Color.fromARGB(105, 255, 52, 52), borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xddD21f3C),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const FaIcon(FontAwesomeIcons.listCheck, size: 50, color: Colors.white),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: const Text(
                                    'LIST OF SCHEDULE',
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: TableCalendar(
                              firstDay: DateTime.utc(2010, 1, 1), // Start date far in the past
                              lastDay: DateTime.utc(2030, 12, 31), // End date far in the future
                              focusedDay: _selectedDate,
                              calendarFormat: _calendarFormat,
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                if (!_isPastDate(selectedDay)) {
                                  setState(() {
                                    _selectedDate = selectedDay;
                                  });
                                  fetchScheduledTimes(selectedDay).then((_) {
                                    _showTimePicker();
                                  });
                                }
                              },
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDate, day);
                              },
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  if (_isPastDate(day)) {
                                    return Center(
                                      child: Text(
                                        '${day.day}',
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Text(
                                        '${day.day}',
                                        style: const TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }
                                },
                              ),
                              enabledDayPredicate: (day) {
                                return !_isPastDate(day);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _generateAvailableTimes() {
    availableTimes.clear();
    for (int hour = 7; hour <= 17; hour++) {
      final time = TimeOfDay(hour: hour, minute: 0);
      if (_selectedDate.isSameDate(DateTime.now()) && _isTimeBeforeNow(time)) {
        continue;
      }
      if (!scheduledTimes.contains(time)) {
        availableTimes.add(time);
      }
    }
  }

  bool _isTimeBeforeNow(TimeOfDay time) {
    final now = TimeOfDay.now();
    if (_selectedDate.isSameDate(DateTime.now())) {
      if (time.hour < now.hour || (time.hour == now.hour && time.minute < now.minute)) {
        return true;
      }
    }
    return false;
  }

  bool _isPastDate(DateTime day) {
    final today = DateTime.now();
    return day.isBefore(DateTime(today.year, today.month, today.day));
  }
}

extension DateHelpers on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
