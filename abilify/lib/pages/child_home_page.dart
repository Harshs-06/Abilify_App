
import 'package:abilify/pages/daily_stars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
    double ScreenWidth = MediaQuery.sizeOf(context).width;
    double ScreenHeight = MediaQuery.sizeOf(context).height;
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                      child: SearchBar(
                        constraints: BoxConstraints(maxWidth:ScreenWidth*0.77 ,minHeight: ScreenHeight*.06),
                        leading: const Icon(Icons.search),
                        hintText: 'Search',
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        shadowColor: WidgetStateProperty.all(Colors.black),
                        elevation: WidgetStateProperty.all(4.0),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                        ),
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 16.0)
                        ),            
                      ),
                  ),
                  Column(
                    children: [
                      IconButton(onPressed:(){}, 
                      icon: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 6,
                            )
                          ],
                          border: Border.all(
                            color: Colors.yellowAccent,
                            width: 2.0,
                          )
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/child_pf.png'),
                        ),
                      ))
                    ],
                  ),
                ],
              ),
          
              
              // SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: SizedBox(
                      width: 235,
                      child: Column(
                        children: [
                          Text('Welcome Back, Super Learner!',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.titilliumWeb(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          )
                          ),
                          Text('Explore and have fun with our learning activities!',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(     
                            fontSize: 12,                     
                            color: const Color.fromARGB(255, 75, 85, 99),
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 125,
                    height: 160,
                      child: Lottie.asset("assets/tiger_animation.json",
                    ),
                  ),
                ],
              ),
          
              // SizedBox(height: 2,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [ 
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        
                        children: [
                          Container(
                            width: ScreenWidth*.44,
                            padding:  const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255,255, 138, 71),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: ClipRect(
                                      // child: Lottie.asset("assets/tiger_animation.json")
                                      child: Image.asset("assets/fun_games.png"),
                                      )
                                    ),
                                  Text('Fun Games',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: ScreenWidth*.44,
                        padding:  const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255,77, 195, 255),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRect(
                                  // child: Lottie.asset("assets/tiger_animation.json")
                                  child: Image.asset("assets/story_time.png"),
                                  )
                                ),
                              Text('Story Time',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ),
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            width: ScreenWidth*.44,
                            padding:  const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255,255, 209, 103),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: ClipRect(
                                      child: Lottie.asset("assets/panda_dancing.json"))
                                    ),
                                  Text('Music Play',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> DailyStars()));
                            },
                            child: Container(
                              width: ScreenWidth*.44,
                                                    padding:  const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255,167, 85, 247),
                                                    ),
                                                    child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ClipRect(
                                    // child: Lottie.asset("assets/tiger_animation.json")
                                    child: Image.asset("assets/chat.png"),
                                    )
                                  ),
                                Text('Chat Along',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                ),
                              ],
                            ),
                                                    ),
                                                  ),
                          ),
                        ],
                      ),
                    ),
                    
                  ]
                ),
                ),
          
              Column(
                children: [
                  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: Text('Your Progress',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              )
                              ),
                      ),
                    ),
                          // SizedBox(height: 10,),
                    Container(
                      width: 350,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                              child: Text('Weekly Star',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  )
                                  ),
                            ),
                          ),
          
                          LinearPercentIndicator(
                            lineHeight: 20,
                            percent: 0.5,
                            barRadius: Radius.circular(20),
                            progressColor: Colors.deepPurple,
                            backgroundColor: Colors.deepPurple.shade100,
                            animation: true,
                            animationDuration: 5000,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                              child: Text('Activities Completed',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  )
                                  ),
                            ),
                          ),
          
                          LinearPercentIndicator(
                            lineHeight: 20,
                            percent: 0.8,
                            barRadius: Radius.circular(20),
                            progressColor: Colors.deepPurple,
                            backgroundColor: Colors.deepPurple.shade100,
                            animation: true,
                            animationDuration: 5000,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
              ],
              )                
            ],
          ),
        ),
      ),
    );
  }
}                    