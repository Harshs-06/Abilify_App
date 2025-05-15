import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/customs/upcoming_events_widget.dart';
import 'package:abilify/customs/device_dimensions.dart';
import 'package:abilify/customs/action_button_widget.dart';
import 'package:abilify/widgets/bottom_navigation.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

final String profile_img = "assets/profile_p2.png";

class CommunityEvents extends StatefulWidget {
  const CommunityEvents({super.key});

  @override
  _CommunityEventsState createState() => _CommunityEventsState();
}

class _CommunityEventsState extends State<CommunityEvents> {
  final int _currentIndex = 2; // Set to Community tab
  bool _showCalendarView = false;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final Random _random = Random();

  // List of possible random events to generate
  final List<Map<String, String>> _possibleEvents = [
    {
      "title": "Parent Support Group",
      "time": "10:00 AM",
      "location": "Community Centre, 123 Church Street"
    },
    {
      "title": "IEP Workshop",
      "time": "2:30 PM",
      "location": "Virtual Meeting (Zoom)"
    },
    {
      "title": "Sensory Play Session",
      "time": "11:00 AM",
      "location": "Children's Museum, 45 Main Street"
    },
    {
      "title": "Therapy Session",
      "time": "3:00 PM",
      "location": "Wellness Center, 78 Oak Avenue"
    },
    {
      "title": "Parent-Child Activity",
      "time": "4:15 PM",
      "location": "Recreation Centre, 90 Pine Road"
    },
    {
      "title": "Community Meetup",
      "time": "7:00 PM",
      "location": "Town Hall, 22 Civic Square"
    },
    {
      "title": "Art Therapy",
      "time": "9:30 AM",
      "location": "Creative Studio, 55 Canvas Ave"
    },
    {
      "title": "Swimming Lessons",
      "time": "1:00 PM",
      "location": "Aquatic Center, 100 Splash Road"
    },
    {
      "title": "Music Therapy",
      "time": "10:45 AM",
      "location": "Harmony Hall, 33 Melody Lane"
    },
    {
      "title": "Parent Training",
      "time": "6:00 PM",
      "location": "Family Center, 77 Support Street"
    },
    {
      "title": "Dance Class",
      "time": "4:30 PM",
      "location": "Movement Studio, 88 Rhythm Road"
    },
    {
      "title": "Sensory-Friendly Movie",
      "time": "11:30 AM",
      "location": "Community Theatre, 123 Film Street"
    },
  ];

  // Updated events map with 10 events per month for current and next few months
  final Map<DateTime, List<Map<String, String>>> _eventsData = {
    // February 2023 events
    DateTime.utc(2023, 2, 3): [
      {
        "title": "Parent Support Group",
        "time": "10:00 AM",
        "location": "Community Centre, 123 Church Street"
      }
    ],
    DateTime.utc(2023, 2, 5): [
      {
        "title": "Sensory Play Workshop",
        "time": "11:00 AM",
        "location": "Children's Museum, 45 Main Street"
      }
    ],
    DateTime.utc(2023, 2, 8): [
      {
        "title": "IEP Workshop",
        "time": "2:30 PM",
        "location": "Virtual Meeting (Zoom)"
      }
    ],
    DateTime.utc(2023, 2, 12): [
      {
        "title": "Music Therapy",
        "time": "10:45 AM",
        "location": "Harmony Hall, 33 Melody Lane"
      }
    ],
    DateTime.utc(2023, 2, 15): [
      {
        "title": "Art Therapy",
        "time": "9:30 AM",
        "location": "Creative Studio, 55 Canvas Ave"
      }
    ],
    DateTime.utc(2023, 2, 17): [
      {
        "title": "Swimming Lessons",
        "time": "1:00 PM",
        "location": "Aquatic Center, 100 Splash Road"
      }
    ],
    DateTime.utc(2023, 2, 20): [
      {
        "title": "Therapy Session",
        "time": "3:00 PM",
        "location": "Wellness Center, 78 Oak Avenue"
      }
    ],
    DateTime.utc(2023, 2, 22): [
      {
        "title": "Parent-Child Activity",
        "time": "4:15 PM",
        "location": "Recreation Centre, 90 Pine Road"
      }
    ],
    DateTime.utc(2023, 2, 25): [
      {
        "title": "Community Meetup",
        "time": "7:00 PM",
        "location": "Town Hall, 22 Civic Square"
      }
    ],
    DateTime.utc(2023, 2, 28): [
      {
        "title": "Parent Training",
        "time": "6:00 PM",
        "location": "Family Center, 77 Support Street"
      }
    ],

    // March 2023 events
    DateTime.utc(2023, 3, 2): [
      {
        "title": "Dance Class",
        "time": "4:30 PM",
        "location": "Movement Studio, 88 Rhythm Road"
      }
    ],
    DateTime.utc(2023, 3, 5): [
      {
        "title": "Sensory-Friendly Movie",
        "time": "11:30 AM",
        "location": "Community Theatre, 123 Film Street"
      }
    ],
    DateTime.utc(2023, 3, 8): [
      {
        "title": "Parent Support Group",
        "time": "10:00 AM",
        "location": "Community Centre, 123 Church Street"
      }
    ],
    DateTime.utc(2023, 3, 11): [
      {
        "title": "IEP Workshop",
        "time": "2:30 PM",
        "location": "Virtual Meeting (Zoom)"
      }
    ],
    DateTime.utc(2023, 3, 14): [
      {
        "title": "Sensory Play Session",
        "time": "11:00 AM",
        "location": "Children's Museum, 45 Main Street"
      }
    ],
    DateTime.utc(2023, 3, 17): [
      {
        "title": "Therapy Session",
        "time": "3:00 PM",
        "location": "Wellness Center, 78 Oak Avenue"
      }
    ],
    DateTime.utc(2023, 3, 20): [
      {
        "title": "Parent-Child Activity",
        "time": "4:15 PM",
        "location": "Recreation Centre, 90 Pine Road"
      }
    ],
    DateTime.utc(2023, 3, 23): [
      {
        "title": "Community Meetup",
        "time": "7:00 PM",
        "location": "Town Hall, 22 Civic Square"
      }
    ],
    DateTime.utc(2023, 3, 26): [
      {
        "title": "Art Therapy",
        "time": "9:30 AM",
        "location": "Creative Studio, 55 Canvas Ave"
      }
    ],
    DateTime.utc(2023, 3, 29): [
      {
        "title": "Swimming Lessons",
        "time": "1:00 PM",
        "location": "Aquatic Center, 100 Splash Road"
      }
    ],

    // April 2023 events
    DateTime.utc(2023, 4, 1): [
      {
        "title": "Music Therapy",
        "time": "10:45 AM",
        "location": "Harmony Hall, 33 Melody Lane"
      }
    ],
    DateTime.utc(2023, 4, 4): [
      {
        "title": "Parent Training",
        "time": "6:00 PM",
        "location": "Family Center, 77 Support Street"
      }
    ],
    DateTime.utc(2023, 4, 7): [
      {
        "title": "Dance Class",
        "time": "4:30 PM",
        "location": "Movement Studio, 88 Rhythm Road"
      }
    ],
    DateTime.utc(2023, 4, 10): [
      {
        "title": "Sensory-Friendly Movie",
        "time": "11:30 AM",
        "location": "Community Theatre, 123 Film Street"
      }
    ],
    DateTime.utc(2023, 4, 13): [
      {
        "title": "Parent Support Group",
        "time": "10:00 AM",
        "location": "Community Centre, 123 Church Street"
      }
    ],
    DateTime.utc(2023, 4, 16): [
      {
        "title": "IEP Workshop",
        "time": "2:30 PM",
        "location": "Virtual Meeting (Zoom)"
      }
    ],
    DateTime.utc(2023, 4, 19): [
      {
        "title": "Sensory Play Session",
        "time": "11:00 AM",
        "location": "Children's Museum, 45 Main Street"
      }
    ],
    DateTime.utc(2023, 4, 22): [
      {
        "title": "Therapy Session",
        "time": "3:00 PM",
        "location": "Wellness Center, 78 Oak Avenue"
      }
    ],
    DateTime.utc(2023, 4, 25): [
      {
        "title": "Parent-Child Activity",
        "time": "4:15 PM",
        "location": "Recreation Centre, 90 Pine Road"
      }
    ],
    DateTime.utc(2023, 4, 28): [
      {
        "title": "Community Meetup",
        "time": "7:00 PM",
        "location": "Town Hall, 22 Civic Square"
      }
    ],

    // May 2023 events
    DateTime.utc(2023, 5, 2): [
      {
        "title": "Art Therapy",
        "time": "9:30 AM",
        "location": "Creative Studio, 55 Canvas Ave"
      }
    ],
    DateTime.utc(2023, 5, 5): [
      {
        "title": "Swimming Lessons",
        "time": "1:00 PM",
        "location": "Aquatic Center, 100 Splash Road"
      }
    ],
    DateTime.utc(2023, 5, 8): [
      {
        "title": "Music Therapy",
        "time": "10:45 AM",
        "location": "Harmony Hall, 33 Melody Lane"
      }
    ],
    DateTime.utc(2023, 5, 11): [
      {
        "title": "Parent Training",
        "time": "6:00 PM",
        "location": "Family Center, 77 Support Street"
      }
    ],
    DateTime.utc(2023, 5, 14): [
      {
        "title": "Dance Class",
        "time": "4:30 PM",
        "location": "Movement Studio, 88 Rhythm Road"
      }
    ],
    DateTime.utc(2023, 5, 17): [
      {
        "title": "Sensory-Friendly Movie",
        "time": "11:30 AM",
        "location": "Community Theatre, 123 Film Street"
      }
    ],
    DateTime.utc(2023, 5, 20): [
      {
        "title": "Parent Support Group",
        "time": "10:00 AM",
        "location": "Community Centre, 123 Church Street"
      }
    ],
    DateTime.utc(2023, 5, 23): [
      {
        "title": "IEP Workshop",
        "time": "2:30 PM",
        "location": "Virtual Meeting (Zoom)"
      }
    ],
    DateTime.utc(2023, 5, 26): [
      {
        "title": "Sensory Play Session",
        "time": "11:00 AM",
        "location": "Children's Museum, 45 Main Street"
      }
    ],
    DateTime.utc(2023, 5, 29): [
      {
        "title": "Therapy Session",
        "time": "3:00 PM",
        "location": "Wellness Center, 78 Oak Avenue"
      }
    ],

    // Current month and next month - add events with current year
    DateTime.utc(DateTime.now().year, DateTime.now().month, 3): [
      {
        "title": "Parent Support Group",
        "time": "10:00 AM",
        "location": "Community Centre, 123 Church Street"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month, 7): [
      {
        "title": "IEP Workshop",
        "time": "2:30 PM",
        "location": "Virtual Meeting (Zoom)"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month, 10): [
      {
        "title": "Sensory Play Session",
        "time": "11:00 AM",
        "location": "Children's Museum, 45 Main Street"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month, 13): [
      {
        "title": "Therapy Session",
        "time": "3:00 PM",
        "location": "Wellness Center, 78 Oak Avenue"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month, 16): [
      {
        "title": "Parent-Child Activity",
        "time": "4:15 PM",
        "location": "Recreation Centre, 90 Pine Road"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month, 19): [
      {
        "title": "Community Meetup",
        "time": "7:00 PM",
        "location": "Town Hall, 22 Civic Square"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month, 22): [
      {
        "title": "Art Therapy",
        "time": "9:30 AM",
        "location": "Creative Studio, 55 Canvas Ave"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month, 25): [
      {
        "title": "Swimming Lessons",
        "time": "1:00 PM",
        "location": "Aquatic Center, 100 Splash Road"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month, 27): [
      {
        "title": "Music Therapy",
        "time": "10:45 AM",
        "location": "Harmony Hall, 33 Melody Lane"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month, 30): [
      {
        "title": "Parent Training",
        "time": "6:00 PM",
        "location": "Family Center, 77 Support Street"
      }
    ],

    // Next month
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 2): [
      {
        "title": "Dance Class",
        "time": "4:30 PM",
        "location": "Movement Studio, 88 Rhythm Road"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 5): [
      {
        "title": "Sensory-Friendly Movie",
        "time": "11:30 AM",
        "location": "Community Theatre, 123 Film Street"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 8): [
      {
        "title": "Parent Support Group",
        "time": "10:00 AM",
        "location": "Community Centre, 123 Church Street"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 11): [
      {
        "title": "IEP Workshop",
        "time": "2:30 PM",
        "location": "Virtual Meeting (Zoom)"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 14): [
      {
        "title": "Sensory Play Session",
        "time": "11:00 AM",
        "location": "Children's Museum, 45 Main Street"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 17): [
      {
        "title": "Therapy Session",
        "time": "3:00 PM",
        "location": "Wellness Center, 78 Oak Avenue"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 20): [
      {
        "title": "Parent-Child Activity",
        "time": "4:15 PM",
        "location": "Recreation Centre, 90 Pine Road"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 23): [
      {
        "title": "Community Meetup",
        "time": "7:00 PM",
        "location": "Town Hall, 22 Civic Square"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 26): [
      {
        "title": "Art Therapy",
        "time": "9:30 AM",
        "location": "Creative Studio, 55 Canvas Ave"
      }
    ],
    DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 29): [
      {
        "title": "Swimming Lessons",
        "time": "1:00 PM",
        "location": "Aquatic Center, 100 Splash Road"
      }
    ],
  };

  // Gets event titles for a specific day (for the calendar markers)
  List<String> _getEventsForDay(DateTime day) {
    DateTime dateWithoutTime = DateTime.utc(day.year, day.month, day.day);
    final events = _eventsData[dateWithoutTime] ?? [];
    return events.map((event) => event["title"] as String).toList();
  }

  // Gets detailed event data for a specific day
  List<Map<String, String>> _getEventDataForDay(DateTime day) {
    DateTime dateWithoutTime = DateTime.utc(day.year, day.month, day.day);
    return _eventsData[dateWithoutTime] ?? [];
  }

  // Adds a random event to the selected day
  void _addRandomEventToDay(DateTime day) {
    if (_random.nextInt(3) != 0) { // 2/3 chance of adding an event
      final dateWithoutTime = DateTime.utc(day.year, day.month, day.day);
      
      // Get a random event from the possibilities
      final randomEvent = _possibleEvents[_random.nextInt(_possibleEvents.length)];
      
      setState(() {
        // If the date doesn't already have events, initialize with empty list
        if (!_eventsData.containsKey(dateWithoutTime)) {
          _eventsData[dateWithoutTime] = [];
        }
        
        // Add the random event if it doesn't already exist for this date
        final events = _eventsData[dateWithoutTime]!;
        bool eventExists = events.any((event) => 
          event["title"] == randomEvent["title"] && 
          event["time"] == randomEvent["time"]);
        
        if (!eventExists) {
          _eventsData[dateWithoutTime]!.add(randomEvent);
          
          // Show confirmation toast
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("New event added: ${randomEvent["title"]}"),
              duration: Duration(seconds: 2),
              backgroundColor: Color(0xFF537A3E),
            ),
          );
        }
      });
    }
  }

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      // Navigate to the appropriate page
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/parent_home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/service_directory');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/chats');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = getDevice_wh(context)[0];
    final deviceHeight = getDevice_wh(context)[1];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFAF0E6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: deviceWidth * 0.65,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Community Events",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Discover events arranged for you and your kid!",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        width: 45,
                        height: 45,
                        child: ClipOval(
                          child: Image.asset(profile_img, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: deviceHeight * 0.01),
              
              // Event Categories
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.6,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    actionsButton(
                      "Parent Support",
                      "assets/eventsicon.png",
                      () {},
                    ),
                    actionsButton(
                      "Playgrounds",
                      "assets/playgroundicon.png",
                      () {},
                    ),
                    actionsButton(
                      "Workshops",
                      "assets/workshopicon.png",
                      () {},
                    ),
                    actionsButton("Therapy", "assets/therapyicon.png", () {}),
                  ],
                ),
              ),

              SizedBox(height: deviceHeight * 0.02),
              
              // Toggle switch between upcoming events and calendar view
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showCalendarView = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          decoration: BoxDecoration(
                            color: !_showCalendarView 
                                ? Color(0xFF9471E1) 
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_note,
                                size: 20,
                                color: !_showCalendarView 
                                    ? Colors.white 
                                    : Colors.black87,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Upcoming Events",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: !_showCalendarView 
                                      ? Colors.white 
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showCalendarView = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          decoration: BoxDecoration(
                            color: _showCalendarView 
                                ? Color(0xFF9471E1) 
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 18,
                                color: _showCalendarView 
                                    ? Colors.white 
                                    : Colors.black87,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Calendar View",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _showCalendarView 
                                      ? Colors.white 
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: deviceHeight * 0.02),
              
              // Content based on the toggle selection
              _showCalendarView 
                  ? _buildCalendarView(deviceWidth, deviceHeight)
                  : _buildUpcomingEventsList(deviceWidth, deviceHeight),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AbilifyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
  
  Widget _buildCalendarView(double deviceWidth, double deviceHeight) {
    // Get the first day of the month for the selected date
    final DateTime firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    // Get the last day of the month
    final DateTime lastDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    // Calculate the day of the week for the first day (0-6, where 0 is Sunday)
    final int firstWeekdayOfMonth = firstDayOfMonth.weekday % 7;
    // Calculate total days to display including previous and next month days
    final int totalDaysToDisplay = firstWeekdayOfMonth + lastDayOfMonth.day;
    // Calculate rows needed
    final int numberOfRows = (totalDaysToDisplay / 7).ceil();
    
    // Get previous month's days that appear in the first week
    final List<DateTime> previousMonthDays = [];
    if (firstWeekdayOfMonth > 0) {
      final DateTime lastDayOfPreviousMonth = DateTime(_focusedDay.year, _focusedDay.month, 0);
      for (int i = firstWeekdayOfMonth - 1; i >= 0; i--) {
        previousMonthDays.add(DateTime(lastDayOfPreviousMonth.year, lastDayOfPreviousMonth.month, lastDayOfPreviousMonth.day - i));
      }
    }
    
    // Get the days of the current month
    final List<DateTime> currentMonthDays = List.generate(
      lastDayOfMonth.day,
      (index) => DateTime(_focusedDay.year, _focusedDay.month, index + 1),
    );
    
    // Get next month's days that appear in the last week
    final List<DateTime> nextMonthDays = [];
    final int remainingCells = (numberOfRows * 7) - (previousMonthDays.length + currentMonthDays.length);
    for (int i = 1; i <= remainingCells; i++) {
      nextMonthDays.add(DateTime(_focusedDay.year, _focusedDay.month + 1, i));
    }
    
    // Combine all days
    final List<DateTime> allDays = [...previousMonthDays, ...currentMonthDays, ...nextMonthDays];
    
    // Format the month name
    final String monthName = _getMonthName(_focusedDay.month);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$monthName ${_focusedDay.year}",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left, color: Colors.black54),
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right, color: Colors.black54),
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          
          SizedBox(height: 16),
          
          // Calendar container with white background
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Weekday headers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildWeekdayHeader("S"),
                    _buildWeekdayHeader("M"),
                    _buildWeekdayHeader("T"),
                    _buildWeekdayHeader("W"),
                    _buildWeekdayHeader("T"),
                    _buildWeekdayHeader("F"),
                    _buildWeekdayHeader("S"),
                  ],
                ),
                
                Divider(color: Colors.grey.shade300, thickness: 1),
                
                // Calendar grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: allDays.length,
                  itemBuilder: (context, index) {
                    final day = allDays[index];
                    final isCurrentMonth = day.month == _focusedDay.month;
                    final isSelected = day.year == _selectedDay.year && 
                                      day.month == _selectedDay.month && 
                                      day.day == _selectedDay.day;
                    final hasEvents = _getEventsForDay(day).isNotEmpty;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDay = day;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? Color(0xFF537A3E) // Dark green for selected day
                              : hasEvents && isCurrentMonth
                                  ? Color(0xFFE8F0DE) // Light green for days with events
                                  : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            day.day.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isCurrentMonth 
                                  ? isSelected 
                                      ? Colors.white
                                      : day.day == DateTime.now().day && 
                                        day.month == DateTime.now().month && 
                                        day.year == DateTime.now().year
                                          ? Color(0xFF537A3E) // Highlight today's date
                                          : Colors.black87
                                  : Colors.grey.shade400, // Faded color for previous/next month days
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Events for selected day
          ..._getEventDataForDay(_selectedDay).map((event) => Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event["title"]!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      event["time"]!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        event["location"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
          
          if (_getEventDataForDay(_selectedDay).isEmpty)
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Text(
                "No events scheduled for this day",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildWeekdayHeader(String day) {
    return Expanded(
      child: Text(
        day,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
  
  String _getMonthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }
  
  Widget _buildUpcomingEventsList(double deviceWidth, double deviceHeight) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 16),
            child: Text(
              "Upcoming Events",
              style: GoogleFonts.titilliumWeb(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(29, 28, 28, 1),
              ),
            ),
          ),
        ),
        upcomingeventslist(
          "assets/parentsupport.png",
          "Parent Support Group",
          "13/02/25 , 10:00 AM",
          "Community Centre, 123 Church Street",
          deviceWidth,
          deviceHeight,
        ),
        upcomingeventslist(
          "assets/workshop.png",
          "IEP Workshop",
          "13/02/25 , 7:00 AM",
          "Virtual Meeting (Zoom)",
          deviceWidth,
          deviceHeight,
        ),
        upcomingeventslist(
          "assets/parentsupport.png",
          "Parent Support Group",
          "15/02/25 , 2:30 PM",
          "Community Centre, 123 Church Street",
          deviceWidth,
          deviceHeight,
        ),
        upcomingeventslist(
          "assets/workshop.png",
          "Sensory Play Workshop",
          "20/02/25 , 9:00 AM",
          "Children's Museum",
          deviceWidth,
          deviceHeight,
        ),
      ],
    );
  }
} 