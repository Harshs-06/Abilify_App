
import 'package:flutter/material.dart';

class ChildHomePage extends StatefulWidget{
  const ChildHomePage({super.key});

  @override
  _ChildHomeState createState() => _ChildHomeState();
} 




class _ChildHomeState extends State<ChildHomePage>{


  final List<String> allItems = [
    'Music Therapy',
    'Art Class',
    'Fun Games',
    'Daily Tasks',
    'Mind Relaxation'
  ];





  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ]
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.black),
                    SizedBox(width: 8),
                    Expanded(child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}