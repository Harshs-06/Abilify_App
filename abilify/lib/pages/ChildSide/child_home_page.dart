import 'package:abilify/pages/ChildSide/daily_stars.dart';
import 'package:abilify/pages/ChildSide/story_time.dart';
import 'package:abilify/pages/ChildSide/music_play.dart';
import 'package:abilify/pages/ChildSide/child_profile.dart';
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
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.amber.shade300,
                      Color.fromARGB(255, 255, 213, 79),
                      Color.fromARGB(255, 251, 239, 215),
                    ],
                    stops: [0.0, 0.6, 1.0],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(top: 20, bottom: 30, left: 16, right: 16),
                child: Column(
                  children: [
                    // Profile and Search bar
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChildProfile()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                )
                              ],
                              border: Border.all(
                                color: Colors.amber,
                                width: 2.0,
                              )
                            ),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundImage: AssetImage('assets/child_pf.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: SearchBar(
                              constraints: BoxConstraints(
                                maxWidth: screenWidth * 0.85,
                                minHeight: 50
                              ),
                              leading: Icon(
                                Icons.search,
                                color: Colors.grey.shade600,
                              ),
                              hintText: 'Search activities...',
                              hintStyle: MaterialStatePropertyAll(
                                GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all(Colors.white),
                              elevation: WidgetStateProperty.all(0),
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
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Welcome message and animation
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back,\nSuper Learner!',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  height: 1.2,
                                )
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Explore and have fun!',
                                  style: GoogleFonts.poppins(     
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,                     
                                    color: Colors.black87,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: Lottie.asset("assets/tiger_animation.json"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Activities section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(
                          'Learning Activities',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    // First row of activity cards
                    Row(
                      children: [
                        // Fun Games card
                        Expanded(
                          child: ActivityCard(
                            title: 'Fun Games',
                            color: Color.fromARGB(255, 255, 138, 71),
                            imagePath: "assets/fun_games.png",
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 16),
                        // Story Time card
                        Expanded(
                          child: ActivityCard(
                            title: 'Story Time',
                            color: Color.fromARGB(255, 77, 195, 255),
                            imagePath: "assets/story_time.png",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => StoryTime()));
                            },
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Second row of activity cards
                    Row(
                      children: [
                        // Music Play card
                        Expanded(
                          child: ActivityCard(
                            title: 'Music Play',
                            color: Color.fromARGB(255, 255, 209, 103),
                            useLottie: true,
                            lottiePath: "assets/panda_dancing.json",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MusicPlay()));
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        // Chat Along card
                        Expanded(
                          child: ActivityCard(
                            title: 'Daily Stars',
                            color: Color.fromARGB(255, 167, 85, 247),
                            imagePath: "assets/chat.png",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DailyStars()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Progress section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.insights, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Text(
                          'Your Progress',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Progress card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.deepPurple.shade50,
                            Colors.deepPurple.shade100,
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Weekly Stars',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepPurple.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '50%',
                                  style: GoogleFonts.poppins(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          LinearPercentIndicator(
                            lineHeight: 16,
                            percent: 0.5,
                            barRadius: Radius.circular(20),
                            progressColor: Colors.white,
                            backgroundColor: Colors.deepPurple.withOpacity(0.3),
                            animation: true,
                            animationDuration: 4000,
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Activities Completed',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.deepPurple.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  '80%',
                                  style: GoogleFonts.poppins(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          LinearPercentIndicator(
                            lineHeight: 16,
                            percent: 0.8,
                            barRadius: Radius.circular(20),
                            progressColor: Colors.white,
                            backgroundColor: Colors.deepPurple.withOpacity(0.3),
                            animation: true,
                            animationDuration: 4000,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Activity Card Widget
class ActivityCard extends StatelessWidget {
  final String title;
  final Color color;
  final String? imagePath;
  final String? lottiePath;
  final bool useLottie;
  final Function() onTap;

  const ActivityCard({
    required this.title,
    required this.color,
    this.imagePath,
    this.lottiePath,
    this.useLottie = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: useLottie 
                        ? Lottie.asset(lottiePath!)
                        : Image.asset(imagePath!),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}                    