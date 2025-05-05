import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Event {
  final String title;
  final DateTime date;
  final String description;

  Event({required this.title, required this.date, required this.description});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      date: DateTime.parse(json['date']),
      description: json['description'] ?? '',
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentDisplayDate = DateTime.now();
  List<Event> _events = [];

  // Replace with your actual token
  final String token = "your-auth-token";

  @override
  void initState() {
    super.initState();
    _fetchAllEvents();
  }

  Future<void> _fetchAllEvents() async {
    try {
      final past = await fetchEvents("http://localhost:8000/gymkhana/past_events/");
      final upcoming = await fetchEvents("http://localhost:8000/gymkhana/upcoming_events/");
      setState(() {
        _events = [...past, ...upcoming];
      });
    } catch (e) {
      print("Error fetching events: $e");
    }
  }

  Future<List<Event>> fetchEvents(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Event.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load events");
    }
  }

  List<Event> get eventsForSelectedDate {
    return _events.where((event) {
      return event.date.year == _selectedDate.year &&
             event.date.month == _selectedDate.month &&
             event.date.day == _selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _selectDate,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildMonthHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildCalendarGrid(),
                  _buildEventList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _changeMonth(-1),
          ),
          Text(
            DateFormat('MMMM y').format(_currentDisplayDate),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _changeMonth(1),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _currentDisplayDate = picked;
      });
    }
  }

  void _changeMonth(int delta) {
    setState(() {
      _currentDisplayDate = DateTime(
        _currentDisplayDate.year,
        _currentDisplayDate.month + delta,
        1
      );
    });
  }

  Widget _buildCalendarGrid() {
    final firstDay = DateTime(_currentDisplayDate.year, _currentDisplayDate.month, 1);
    final lastDay = DateTime(_currentDisplayDate.year, _currentDisplayDate.month + 1, 0);
    final daysInMonth = lastDay.day;
    final weekday = firstDay.weekday % 7;

    return Table(
      border: TableBorder.all(color: Colors.grey),
      children: [
        const TableRow(
          decoration: BoxDecoration(color: Colors.blueAccent),
          children: [
            _CalendarCell('Sun', isHeader: true),
            _CalendarCell('Mon', isHeader: true),
            _CalendarCell('Tue', isHeader: true),
            _CalendarCell('Wed', isHeader: true),
            _CalendarCell('Thu', isHeader: true),
            _CalendarCell('Fri', isHeader: true),
            _CalendarCell('Sat', isHeader: true),
          ],
        ),
        ..._buildCalendarRows(weekday, daysInMonth),
      ],
    );
  }

  List<TableRow> _buildCalendarRows(int firstWeekday, int daysInMonth) {
    final rows = <TableRow>[];
    var dayCounter = 1;

    for (var i = 0; i < 6; i++) {
      final cells = <Widget>[];
      for (var j = 0; j < 7; j++) {
        if ((i == 0 && j < firstWeekday) || dayCounter > daysInMonth) {
          cells.add(const _CalendarCell(''));
        } else {
          final currentDay = dayCounter;
          final date = DateTime(_currentDisplayDate.year, _currentDisplayDate.month, currentDay);
          final hasEvent = _events.any((e) => _isSameDate(e.date, date));
          cells.add(
            GestureDetector(
              onTap: () => _handleDateSelection(date),
              child: _CalendarCell(
                currentDay.toString(),
                isSelected: _isSameDate(date, _selectedDate),
                isCurrentMonth: _isSameMonth(date, _currentDisplayDate),
                hasEvent: hasEvent,
              ),
            ),
          );
          dayCounter++;
        }
      }
      if (cells.any((cell) => cell is _CalendarCell && cell.day.isNotEmpty)) {
        rows.add(TableRow(children: cells));
      }
    }
    return rows;
  }

  void _handleDateSelection(DateTime date) {
    setState(() {
      _selectedDate = date;
      if (!_isSameMonth(date, _currentDisplayDate)) {
        _currentDisplayDate = date;
      }
    });
  }

  bool _isSameDate(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;
  bool _isSameMonth(DateTime a, DateTime b) => a.year == b.year && a.month == b.month;

  Widget _buildEventList() {
    final events = eventsForSelectedDate;

    if (events.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No events for selected date'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: events.map((e) => Card(
          child: ListTile(
            title: Text(e.title),
            subtitle: Text(e.description),
          ),
        )).toList(),
      ),
    );
  }
}

class _CalendarCell extends StatelessWidget {
  final String day;
  final bool isHeader;
  final bool isSelected;
  final bool isCurrentMonth;
  final bool hasEvent;

  const _CalendarCell(
    this.day, {
    this.isHeader = false,
    this.isSelected = false,
    this.isCurrentMonth = true,
    this.hasEvent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isHeader 
            ? Colors.blue[100] 
            : isSelected 
                ? Colors.blue[50] 
                : Colors.white,
        border: isSelected
            ? Border.all(color: Colors.blue, width: 2)
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: day.isEmpty 
                  ? Colors.transparent 
                  : isCurrentMonth 
                      ? (isSelected ? Colors.blue[900] : Colors.black)
                      : Colors.grey,
            ),
          ),
          if (hasEvent && !isHeader && day.isNotEmpty)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
