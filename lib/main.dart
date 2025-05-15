import 'package:abilify/pages/ChildSide/child_home_page.dart';
import 'package:abilify/pages/continue_as.dart';
import 'package:abilify/pages/ChildSide/daily_stars.dart';
import 'package:abilify/pages/login.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:abilify/pages/ParentSide/service_directory.dart';
import 'package:abilify/pages/ParentSide/therapist_directory.dart';
import 'package:abilify/pages/ParentSide/medical_directory.dart';
import 'package:abilify/pages/ParentSide/schools_directory.dart';
import 'package:abilify/pages/ParentSide/care_directory.dart';
import 'package:abilify/pages/ParentSide/community_forum.dart';
import 'package:abilify/pages/ParentSide/community_events.dart';
import 'package:abilify/pages/ParentSide/chats.dart';
import 'package:abilify/pages/splash.dart';
import 'package:abilify/services/user_data_provider.dart';
import 'package:abilify/services/rewards_provider.dart';
import 'package:abilify/services/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize user data provider
  await UserDataProvider().init();
  
  // Initialize rewards provider
  await RewardsProvider().init();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
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
        "/therapist_directory": (context) => TherapistDirectory(),
        "/medical_directory": (context) => MedicalDirectory(),
        "/schools_directory": (context) => SchoolsDirectory(),
        "/care_directory": (context) => CareDirectory(),
        "/community_forum": (context) => CommunityForum(),
        "/community_events": (context) => CommunityEvents(),
        "/chats": (context) => Chats(),
      },
    );
  }
}

