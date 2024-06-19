import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarPopupExample extends StatefulWidget {
  const CalendarPopupExample({Key? key}) : super(key: key);

  @override
  _CalendarPopupExampleState createState() => _CalendarPopupExampleState();
}

class _CalendarPopupExampleState extends State<CalendarPopupExample> {
  TextEditingController dateController = TextEditingController();

  void _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year, now.month, now.day);
    DateTime lastDate = DateTime(now.year + 10);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Date'),
          content: Container(
            height: 300,
            child: CalendarDatePicker(
              initialDate: now,
              firstDate: firstDate,
              lastDate: lastDate,
              onDateChanged: (DateTime date) {
                if (date.isBefore(firstDate)) {
                  _showAlert(context, "Cannot select a past date.");
                } else {
                  setState(() {
                    dateController.text = DateFormat('yyyy-MM-dd').format(date);
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        );
      },
    );
  }

  void _showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Warning"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pop-up Calendar Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: 'Select Date',
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
