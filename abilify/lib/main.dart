// import 'package:abilify/pages/ChildSide/child_home_page.dart';
// import 'package:abilify/pages/continue_as.dart';
// import 'package:abilify/pages/ChildSide/daily_stars.dart';
// import 'package:abilify/pages/login.dart';
// import 'package:abilify/pages/ParentSide/parent_home_page.dart';
// import 'package:abilify/pages/ParentSide/service_directory.dart';
// import 'package:abilify/pages/ParentSide/therapist_directory.dart';
// import 'package:abilify/pages/ParentSide/medical_directory.dart';
// import 'package:abilify/pages/ParentSide/schools_directory.dart';
// import 'package:abilify/pages/ParentSide/care_directory.dart';
import 'package:abilify/pages/ParentSide/community_forum.dart';
import 'package:abilify/pages/ParentSide/chats.dart';
import 'package:abilify/pages/splash.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:abilify/pages/ParentSide/service_directory.dart';
import 'package:abilify/services/local_data_service.dart';
import 'package:abilify/services/user_data_provider.dart';
import 'package:abilify/services/rewards_provider.dart';
import 'package:abilify/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  final localDataService = LocalDataService();
  await localDataService.init();
  await localDataService.initializeWithMockData(); // Initialize with mock data if needed
  
  // Initialize auth service
  final authService = AuthService();
  await authService.init();
  
  // Initialize user data and rewards providers
  final userDataProvider = UserDataProvider();
  await userDataProvider.init();
  
  final rewardsProvider = RewardsProvider();
  await rewardsProvider.init();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalDataService>(
          create: (_) => localDataService,
        ),
        ChangeNotifierProvider<UserDataProvider>(
          create: (_) => userDataProvider,
        ),
        ChangeNotifierProvider<RewardsProvider>(
          create: (_) => rewardsProvider,
        ),
        Provider<AuthService>(
          create: (_) => authService,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abilify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9471E1),
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/parent_home': (context) => const ParentHomePage(),
        '/service_directory': (context) => const ServiceDirectory(),
        '/community_forum': (context) => const CommunityForum(),
        '/chats': (context) => const Chats(),
      },
    );
  }
}

