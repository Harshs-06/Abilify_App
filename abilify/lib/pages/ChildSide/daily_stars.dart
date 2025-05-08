import 'package:abilify/pages/ChildSide/child_home_page.dart';
import 'package:abilify/pages/ChildSide/rewards_shop.dart';
import 'package:abilify/pages/continue_as.dart';
import 'package:abilify/services/rewards_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DailyStars extends StatefulWidget{
  const DailyStars({super.key});

  @override
  _DailyStarsState createState() => _DailyStarsState();
}

class _DailyStarsState extends State<DailyStars>{
  bool col=false;
  bool col2=false;
  bool col3=false;
  bool col4=false;
  bool col5=false;
  
  // Track which tasks have earned points today
  final List<String> _tasksEarnedPoints = [];
  final RewardsProvider _rewardsProvider = RewardsProvider();
  int _points = 0;
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _loadRewardsData();
  }
  
  Future<void> _loadRewardsData() async {
    await _rewardsProvider.init();
    setState(() {
      _points = _rewardsProvider.points;
      _isLoading = false;
    });
  }
  
  // Award points when a task is completed
  Future<void> _awardPointsForTask(String taskId, bool isCompleted) async {
    // If task is being completed and hasn't earned points yet
    if (isCompleted && !_tasksEarnedPoints.contains(taskId)) {
      // Different points based on task difficulty
      int pointsToAward;
      switch (taskId) {
        case 'daily_login':
          pointsToAward = 5;
          break;
        case 'play_games':
          pointsToAward = 10;
          break;
        case 'listen_music':
          pointsToAward = 10;
          break;
        case 'read_story':
          pointsToAward = 15;
          break;
        case 'practice_skills':
          pointsToAward = 20;
          break;
        default:
          pointsToAward = 5;
      }
      
      await _rewardsProvider.addPoints(pointsToAward);
      _tasksEarnedPoints.add(taskId);
      
      setState(() {
        _points = _rewardsProvider.points;
      });
      
      // Show point earned notification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You earned $pointsToAward points!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        )
      );
    }
  }
  
  // Get completion percentage
  double get completionPercentage {
    int completedTasks = [col, col2, col3, col4, col5].where((isComplete) => isComplete).length;
    return completedTasks / 5;
  }
  
  // Get completion text (e.g., 3/5)
  String get completionText {
    int completedTasks = [col, col2, col3, col4, col5].where((isComplete) => isComplete).length;
    return '$completedTasks/5';
  }

 @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Color.fromARGB(255, 251, 239, 215),
    body: _isLoading ? 
      Center(child: CircularProgressIndicator(color: Colors.amber)) : 
      SafeArea(
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
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ChildHomePage()));
                            }, 
                            icon: Icon(Icons.arrow_back,
                              color: Colors.black,
                              size: 24.0,
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daily Stars',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              )
                            ),
                            Text(
                              'Complete challenges to earn stars',
                              style: GoogleFonts.poppins(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              )
                            ),
                          ],
                        ),
                        
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(8),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.stars,
                                color: Colors.amber,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '$_points',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Today's Progress Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.amber.shade300,
                      Colors.orange.shade300,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today\'s Progress',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            completionText,
                            style: GoogleFonts.poppins(
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    LinearPercentIndicator(
                      lineHeight: 16,
                      percent: completionPercentage,
                      barRadius: Radius.circular(20),
                      progressColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      animation: true,
                      animationDuration: 4000,
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Daily Challenges Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.assignment, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        'Daily Challenges',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Daily Login Challenge
                  ChallengeCard(
                    title: "Daily Login",
                    description: "Open abilify app today",
                    isCompleted: col,
                    points: 5,
                    onChanged: (bool? value) {
                      setState(() {
                        col = value ?? false;
                        if (col) {
                          _awardPointsForTask('daily_login', col);
                        }
                      });
                    },
                    icon: Icons.login,
                    color: Colors.blue,
                  ),

                  SizedBox(height: 12),
                  
                  // Play Games Challenge
                  ChallengeCard(
                    title: "Play Games",
                    description: "Play at least one game today",
                    isCompleted: col2,
                    points: 10,
                    onChanged: (bool? value) {
                      setState(() {
                        col2 = value ?? false;
                        if (col2) {
                          _awardPointsForTask('play_games', col2);
                        }
                      });
                    },
                    icon: Icons.games,
                    color: Colors.purple,
                  ),

                  SizedBox(height: 12),
                  
                  // Listen to Music Challenge
                  ChallengeCard(
                    title: "Listen to Music",
                    description: "Explore a music activity for 5 minutes",
                    isCompleted: col3,
                    points: 10,
                    onChanged: (bool? value) {
                      setState(() {
                        col3 = value ?? false;
                        if (col3) {
                          _awardPointsForTask('listen_music', col3);
                        }
                      });
                    },
                    icon: Icons.music_note,
                    color: Colors.teal,
                  ),

                  SizedBox(height: 12),
                  
                  // Read a Story Challenge
                  ChallengeCard(
                    title: "Read a Story",
                    description: "Complete one Story from Story time",
                    isCompleted: col4,
                    points: 15,
                    onChanged: (bool? value) {
                      setState(() {
                        col4 = value ?? false;
                        if (col4) {
                          _awardPointsForTask('read_story', col4);
                        }
                      });
                    },
                    icon: Icons.menu_book,
                    color: Colors.amber,
                  ),

                  SizedBox(height: 12),
                  
                  // Practice Skills Challenge
                  ChallengeCard(
                    title: "Practice Skills",
                    description: "Complete a learning activity",
                    isCompleted: col5,
                    points: 20,
                    onChanged: (bool? value) {
                      setState(() {
                        col5 = value ?? false;
                        if (col5) {
                          _awardPointsForTask('practice_skills', col5);
                        }
                      });
                    },
                    icon: Icons.school,
                    color: Colors.green,
                  ),

                  SizedBox(height: 24),

                  // Rewards Shop
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RewardsShop()),
                      ).then((_) {
                        // Refresh points when returning from shop
                        _loadRewardsData();
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.purple.shade300,
                            Colors.deepPurple.shade400,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rewards Shop',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Spend your $_points points on special rewards!',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24),
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

// Custom Challenge Card Widget
class ChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted;
  final Function(bool?) onChanged;
  final IconData icon;
  final Color color;
  final int points;

  const ChallengeCard({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.onChanged,
    required this.icon,
    required this.color,
    this.points = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: isCompleted ? const Color.fromARGB(243, 0, 148, 17) : Colors.white,
            width: 10,
          ),
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 22,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.stars, size: 12, color: Colors.amber),
                            SizedBox(width: 2),
                            Text(
                              '+$points',
                              style: GoogleFonts.poppins(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: isCompleted,
                activeColor: Colors.green,
                shape: CircleBorder(),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}