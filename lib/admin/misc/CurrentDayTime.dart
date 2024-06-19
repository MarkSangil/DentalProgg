import 'package:flutter/material.dart';

class CurrentDayTimePicker extends StatefulWidget {
  final List<TimeOfDay> bookedTimes;
  final TimeOfDay initialTime;
  final bool isAdmin;

  CurrentDayTimePicker({
    required this.bookedTimes,
    required this.initialTime,
    required this.isAdmin,
  });

  @override
  _CurrentDayTimePickerState createState() => _CurrentDayTimePickerState();
}

class _CurrentDayTimePickerState extends State<CurrentDayTimePicker> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime;
  }

  bool isBooked(TimeOfDay time) {
    return widget.bookedTimes
        .any((t) => t.hour == time.hour && t.minute == time.minute);
  }

  bool isPastTime(TimeOfDay time) {
    final now = TimeOfDay.now();
    if (DateTime.now().hour > time.hour ||
        (DateTime.now().hour == time.hour &&
            DateTime.now().minute > time.minute)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<TimeOfDay> availableTimes = [];
    for (int index = 0; index < 24 * 2; index++) {
      final hour = index ~/ 2;
      final minute = (index % 2) * 30;
      final time = TimeOfDay(hour: hour, minute: minute);
      if (!isPastTime(time)) {
        availableTimes.add(time);
      }
    }

    return AlertDialog(
      title: Text('Select Time'),
      content: Container(
        width: double.minPositive,
        height: 300,
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemCount: availableTimes.length,
          itemBuilder: (context, index) {
            final time = availableTimes[index];
            final isBookedTime = isBooked(time);

            return GestureDetector(
              onTap: () {
                if ((!isBookedTime) || widget.isAdmin) {
                  setState(() {
                    selectedTime = time;
                  });
                  Navigator.of(context).pop(selectedTime);
                }
              },
              child: Container(
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: isBookedTime ? Colors.red : Colors.white,
                  border: Border.all(
                    color: selectedTime == time ? Colors.blue : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    time.format(context),
                    style: TextStyle(
                      color: isBookedTime ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
