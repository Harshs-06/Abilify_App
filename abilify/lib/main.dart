import 'package:abilify/pages/ChildSide/child_home_page.dart';
import 'package:abilify/pages/continue_as.dart';
import 'package:abilify/pages/ChildSide/daily_stars.dart';
import 'package:abilify/pages/login.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:abilify/pages/splash.dart';
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
        "/": (context) => Login(),
        
      },
    );
  }
}

