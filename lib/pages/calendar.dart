import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final income = 4000000;
  final outcome = 2000000;

  final events = {
    DateTime.utc(2021, 12, 1): ['Event 1'],
    DateTime.utc(2021, 12, 3): ['Event 1'],
    DateTime.utc(2021, 12, 13): ['Event 1'],
    DateTime.utc(2021, 12, 21): ['Event 1'],
    DateTime.utc(2021, 12, 28): ['Event 1'],
    DateTime.utc(2021, 12, 31): ['Event 1'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff8D7878),
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset("assets/img/sample_logo.jpeg",width: 100,height: 50),
              Container(
                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  decoration: new BoxDecoration(
                      color: const Color(0xffE4C0C0),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  width: 249,
                  height: 50,
                  child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("수입: ", style: TextStyle(height:1.8, fontSize: 15, color: const Color(0xff8D7878), fontWeight: FontWeight.bold)),
                            Text(income.toString()+"원", style: TextStyle(height:1.9, fontSize: 13, color: const Color(0xff8D7878))),
                          ],),
                        Row(
                          children: [
                            Text("지출: ", style: TextStyle(fontSize: 15, color: const Color(0xff8D7878), fontWeight: FontWeight.bold)),
                            Text(outcome.toString()+"원", style: TextStyle(height: 1.1, fontSize: 13, color: const Color(0xff8D7878))),
                          ],)
                      ]
                  )
              )
              ]),
      ),
      body: TableCalendar(
        locale: 'ko_KR',
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}