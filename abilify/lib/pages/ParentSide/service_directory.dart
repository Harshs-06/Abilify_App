import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/widgets/bottom_navigation.dart';
import 'package:abilify/pages/ParentSide/therapist_directory.dart';
import 'package:abilify/pages/ParentSide/medical_directory.dart';
import 'package:abilify/pages/ParentSide/schools_directory.dart';
import 'package:abilify/pages/ParentSide/care_directory.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:abilify/pages/ParentSide/community_forum.dart';
import 'package:abilify/pages/ParentSide/chats.dart';

class ServiceDirectory extends StatefulWidget {
  const ServiceDirectory({Key? key}) : super(key: key);

  @override
  _ServiceDirectoryState createState() => _ServiceDirectoryState();
}

class _ServiceDirectoryState extends State<ServiceDirectory> {
  int _currentIndex = 1; // Set to 1 for Services tab

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      // Navigate to the appropriate page
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/parent_home');
          break;
        case 1:
          // Already on services page
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/community_forum');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/chats');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E9), // Light cream background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with profile image
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service Directory',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Find trusted care for you and your child.',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xFFFED797), // Light orange
                        child: ClipOval(
                          child: Image.asset(
                            'assets/profile_p2.png',
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Search bar
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search services, specialists ...',
                            hintStyle: GoogleFonts.poppins(
                              color: Colors.grey.shade500,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                        size: 28,
                      ),
                    ],
                  ),
                ),
                
                // Categories section
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    'Categories',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCategoryItem(
                        icon: Icons.person,
                        color: Color(0xFF4DC3FF), // Light blue
                        label: 'Therapists',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TherapistDirectory()),
                        ),
                      ),
                      _buildCategoryItem(
                        icon: Icons.school,
                        color: Color(0xFFFFD166), // Yellow
                        label: 'Schools',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SchoolsDirectory()),
                        ),
                      ),
                      _buildCategoryItem(
                        icon: Icons.medical_services,
                        color: Color(0xFF8AE066), // Light green
                        label: 'Medical',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MedicalDirectory()),
                        ),
                      ),
                      _buildCategoryItem(
                        icon: Icons.favorite,
                        color: Color(0xFFAA7EFF), // Purple
                        label: 'Caregivers',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CareDirectory()),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Trending Services section
                Padding(
                  padding: const EdgeInsets.only(top: 28.0, bottom: 12.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.blue,
                        size: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Trending Services',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                
                _buildTrendingServiceItem(
                  title: 'Speech Therapy',
                  subtitle: 'Therapy',
                  percentage: '+25%',
                ),
                
                SizedBox(height: 12),
                
                _buildTrendingServiceItem(
                  title: 'Special Education',
                  subtitle: 'Education',
                  percentage: '+18%',
                ),
                
                SizedBox(height: 12),
                
                _buildTrendingServiceItem(
                  title: 'Occupational Therapy',
                  subtitle: 'Therapy',
                  percentage: '+18%',
                ),
                
                // Special Offers section
                Padding(
                  padding: const EdgeInsets.only(top: 28.0, bottom: 12.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        color: Color(0xFFAA7EFF), // Purple
                        size: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Special Offers',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                
                _buildSpecialOfferItem(
                  title: 'Free Initial Assessment',
                  subtitle: 'Child Psychology',
                  label: 'Limited time',
                ),
                
                SizedBox(height: 12),
                
                _buildSpecialOfferItem(
                  title: '20% Off First Session',
                  subtitle: 'Speech Therapy',
                  label: 'This week',
                ),
                
                SizedBox(height: 100), // Extra space at the bottom
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AbilifyBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
  
  Widget _buildCategoryItem({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTrendingServiceItem({
    required String title,
    required String subtitle,
    required String percentage,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Text(
            percentage,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSpecialOfferItem({
    required String title,
    required String subtitle,
    required String label,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFFF8EFFF), // Light purple
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9464DD), // Purple
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFFB07FFE), // Brighter purple
            ),
          ),
        ],
      ),
    );
  }
} 