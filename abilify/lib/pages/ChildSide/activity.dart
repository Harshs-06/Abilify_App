import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:abilify/pages/ChildSide/story_time.dart';
import 'package:abilify/pages/ChildSide/music_play.dart';
import 'package:abilify/pages/ChildSide/fun_games.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header section with gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.orange.shade300,
                      Color.fromARGB(255, 251, 239, 215),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: EdgeInsets.only(top: 16, bottom: 25),
                child: Column(
                  children: [
                    // App bar with back button and title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 24.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.games,
                                color: Colors.amber[600],
                                size: 28,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Activity',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Fun Activities for Everyone!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          Spacer(),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.games,
                              color: Colors.amber,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Icon(Icons.games, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(
                          'Choose an Activity',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),

                    // Fun Games
                    ActivityOptionCard(
                      title: 'Fun Games',
                      description: 'Play interactive games designed especially for you!',
                      color: Color.fromARGB(255, 255, 138, 71),
                      icon: Icons.gamepad,
                      imagePath: "assets/fun_games.png",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FunGames()),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 24),

                    // Story Time
                    ActivityOptionCard(
                      title: 'Story Time',
                      description: 'Explore amazing stories and adventures!',
                      color: Color.fromARGB(255, 77, 195, 255),
                      icon: Icons.menu_book,
                      imagePath: "assets/story_time.png",
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => StoryTime())
                        );
                      },
                    ),
                    
                    const SizedBox(height: 24),

                    // Music Play
                    ActivityOptionCard(
                      title: 'Music Play',
                      description: 'Enjoy fun musical activities and sounds!',
                      color: Color.fromARGB(255, 255, 209, 103),
                      icon: Icons.music_note,
                      useLottie: true,
                      lottiePath: "assets/panda_dancing.json",
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => MusicPlay())
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActivityOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final String? imagePath;
  final String? lottiePath;
  final bool useLottie;
  final VoidCallback onTap;

  const ActivityOptionCard({super.key, 
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
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
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              color.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: useLottie 
                  ? Lottie.asset(lottiePath!)
                  : imagePath != null 
                    ? Image.asset(imagePath!)
                    : Icon(
                        icon,
                        size: 40,
                        color: Colors.white,
                      ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
} 