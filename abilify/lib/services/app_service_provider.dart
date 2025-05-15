import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'local_auth_service.dart';
import 'local_data_service.dart';
import 'local_database_service.dart';

/// A provider of application services
class AppServiceProvider extends StatelessWidget {
  final Widget child;
  final bool useMockData;
  
  const AppServiceProvider({
    super.key,
    required this.child,
    this.useMockData = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide the LocalDatabaseService
        Provider<LocalDatabaseService>(
          create: (_) => LocalDatabaseService(),
        ),
        
        // Provide the LocalAuthService
        ChangeNotifierProvider<LocalAuthService>(
          create: (_) => LocalAuthService(),
        ),
        
        // Provide the LocalDataService
        ChangeNotifierProvider<LocalDataService>(
          create: (_) => LocalDataService(),
        ),
      ],
      child: InitServices(
        useMockData: useMockData,
        child: child,
      ),
    );
  }
}

/// A widget that initializes all application services
class InitServices extends StatefulWidget {
  final Widget child;
  final bool useMockData;
  
  const InitServices({
    super.key,
    required this.child,
    this.useMockData = false,
  });
  
  @override
  _InitServicesState createState() => _InitServicesState();
}

class _InitServicesState extends State<InitServices> {
  bool _initialized = false;
  
  @override
  void initState() {
    super.initState();
    _initializeServices();
  }
  
  Future<void> _initializeServices() async {
    try {
      // Get the services
      final authService = Provider.of<LocalAuthService>(context, listen: false);
      final dataService = Provider.of<LocalDataService>(context, listen: false);
      
      // Initialize auth service
      await authService.init();
      
      // Initialize data service
      await dataService.init();
      
      // Load mock data if specified
      if (widget.useMockData) {
        await dataService.initializeWithMockData();
      }
      
      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
    } catch (e) {
      print('Error initializing services: $e');
      // Still mark as initialized to show error UI
      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      // Show a loading indicator while services are initializing
      return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    
    // Services are initialized, show the child
    return widget.child;
  }
} 