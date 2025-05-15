import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  final Future<void> loadTask;
  final Widget nextPage;

  const LoadingScreen({required this.loadTask, required this.nextPage, super.key});

  @override
  Widget build(BuildContext context) {
    loadTask.then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => nextPage),
      );
    });

    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 240, 230, 1),
      body: Center(
        child: SizedBox(
          width: 350,
          height: 350,
          child: Lottie.asset("assets/loading.json")), // your lottie file
      ),
    );
  }
}



void navigateWithLoading(BuildContext context, Widget targetPage, Future<void> Function() task) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => LoadingScreen(loadTask: task(), nextPage: targetPage),
    ),
  );
}

