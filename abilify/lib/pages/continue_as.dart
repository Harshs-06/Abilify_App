

import 'package:flutter/material.dart';

class ContinueAs extends StatefulWidget{
  @override
  _ContinueState createState() => _ContinueState();
}

class _ContinueState extends State<ContinueAs>{


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      Image.asset("assets/abilify_logo.png"),
                      Text(
                        "parent",
                        style: TextStyle(
                          color:Colors.black,
                        ),
                        )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}