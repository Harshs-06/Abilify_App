import 'package:abilify/pages/child_home_page.dart';
import 'package:abilify/pages/continue_as.dart';
import 'package:abilify/pages/daily_stars.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp(
      // debugShowCheckedModeBanner: false,
      // home: SignIn(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",  
      routes: {
        "/": (context) => ChildHomePage(),
        
      },
    );
  }
}

