import 'package:abilify/pages/ChildSide/child_home_page.dart';
import 'package:abilify/pages/continue_as.dart';
import 'package:abilify/pages/ChildSide/daily_stars.dart';
import 'package:abilify/pages/login.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:abilify/pages/ParentSide/service_directory.dart';
import 'package:abilify/pages/ParentSide/community_forum.dart';
import 'package:abilify/pages/ParentSide/chats.dart';
import 'package:abilify/pages/splash.dart';
import 'package:abilify/services/user_data_provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize user data provider
  await UserDataProvider().init();
  
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
        "/parent_home": (context) => ParentHomePage(),
        "/service_directory": (context) => ServiceDirectory(),
        "/community_forum": (context) => CommunityForum(),
        "/chats": (context) => Chats(),
      },
    );
  }
}

