import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RelaxingSounds extends StatefulWidget {
  const RelaxingSounds({super.key});

  @override
  State<RelaxingSounds> createState() => _RelaxingSoundsState();
}

class _RelaxingSoundsState extends State<RelaxingSounds> {
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
                      Colors.lightBlue.shade300,
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
                                Icons.waves,
                                color: Colors.lightBlue[600],
                                size: 28,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Relaxing Sounds',
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Peaceful sounds to help you relax',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
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
                              Icons.volume_up,
                              color: Colors.lightBlue,
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
                        Icon(Icons.music_note, color: Colors.lightBlue),
                        SizedBox(width: 8),
                        Text(
                          'Calming Sounds',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                
                    // Sound card 1 - The Sound of the Sea
                    SoundCard(
                      title: 'The Sound of the Sea',
                      description: 'Gentle song that mimics ocean waves and seagulls.',
                      color: const Color(0xFF4DC3FF),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Sound card 2 - Raindrop Lullaby
                    SoundCard(
                      title: 'Raindrop Lullaby',
                      description: 'Soft raindrops with a calm melody to help children unwind.',
                      color: const Color(0xFFFFD166),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Sound card 3 - Twinkle Twinkle Little Star
                    SoundCard(
                      title: 'Twinkle Twinkle Little Star',
                      description: 'A gentle, slow version of the classic lullaby.',
                      color: const Color(0xFF06D6A0),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Music Journey section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.lightBlue.shade100,
                            Colors.lightBlue.shade200,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.lightBlue.withOpacity(0.3),
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
                              Expanded(
                                child: Text(
                                  'Your Music Journey',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.waves,
                                  size: 30,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Songs Heard',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '5/10',
                                  style: GoogleFonts.poppins(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearPercentIndicator(
                            lineHeight: 12,
                            percent: 0.5,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            progressColor: Colors.white,
                            barRadius: const Radius.circular(10),
                            padding: EdgeInsets.zero,
                            animation: true,
                            animationDuration: 4000,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Listening Time',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '15 mins',
                                  style: GoogleFonts.poppins(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          LinearPercentIndicator(
                            lineHeight: 12,
                            percent: 0.3,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            progressColor: Colors.white,
                            barRadius: const Radius.circular(10),
                            padding: EdgeInsets.zero,
                            animation: true,
                            animationDuration: 4000,
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
      ),
    );
  }
}

class SoundCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  const SoundCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white,
            Colors.white.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        border: Border(left: BorderSide(color: color, width: 6)),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 2),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Text(
                    description,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.play_circle_filled,
              color: color,
              size: 20,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
} 