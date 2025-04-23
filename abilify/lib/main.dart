import 'package:flutter/material.dart';
import 'package:abilify/pages/splash.dart';

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
        "/": (context) => SplashScreen(),
        
      },
    );
  }
}

