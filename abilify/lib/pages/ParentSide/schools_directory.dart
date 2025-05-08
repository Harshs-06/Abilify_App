import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SchoolsDirectory extends StatelessWidget {
  const SchoolsDirectory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8E9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Schools Directory',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            hintText: 'Search schools by name or location...',
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
                
                Text(
                  'School Types',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: 16),
                
                // School types grid
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildSchoolTypeChip('Special Education'),
                    _buildSchoolTypeChip('Inclusive Schools'),
                    _buildSchoolTypeChip('Specialized Programs'),
                    _buildSchoolTypeChip('Montessori'),
                    _buildSchoolTypeChip('Public Schools'),
                    _buildSchoolTypeChip('Private Schools'),
                  ],
                ),
                
                SizedBox(height: 24),
                
                Text(
                  'Top Special Needs Schools',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Schools list
                _buildSchoolCard(
                  name: 'Bright Stars Academy',
                  type: 'Special Education',
                  rating: 4.8,
                  distance: '1.5',
                  imageUrl: 'assets/school1.png',
                ),
                
                SizedBox(height: 16),
                
                _buildSchoolCard(
                  name: 'Inclusive Learning Center',
                  type: 'Inclusive School',
                  rating: 4.9,
                  distance: '2.3',
                  imageUrl: 'assets/school2.png',
                ),
                
                SizedBox(height: 16),
                
                _buildSchoolCard(
                  name: 'Rainbow Kids School',
                  type: 'Specialized Programs',
                  rating: 4.7,
                  distance: '3.1',
                  imageUrl: 'assets/school3.png',
                ),
                
                SizedBox(height: 24),
                
                Text(
                  'Special Education Resources',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Resources list
                _buildResourceCard(
                  title: 'Understanding IEPs',
                  description: 'Guide to Individualized Education Programs',
                  type: 'PDF Guide',
                ),
                
                SizedBox(height: 12),
                
                _buildResourceCard(
                  title: 'School Transition Planning',
                  description: 'Tips for smooth transitions between schools',
                  type: 'Webinar',
                ),
                
                SizedBox(height: 12),
                
                _buildResourceCard(
                  title: 'Choosing the Right School',
                  description: 'Factors to consider for special needs children',
                  type: 'Article',
                ),
                
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSchoolTypeChip(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFD166).withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFD166),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSchoolCard({
    required String name,
    required String type,
    required double rating,
    required String distance,
    required String imageUrl,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: Colors.grey.shade300,
                child: Icon(Icons.school, color: Colors.grey.shade600),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      type,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      ' • $distance miles',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Info'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFD166),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildResourceCard({
    required String title,
    required String description,
    required String type,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFFFD166).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIconForType(type),
              color: Color(0xFFFFD166),
              size: 30,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  type,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Color(0xFFFFD166),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_ios, size: 18),
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
  
  IconData _getIconForType(String type) {
    switch (type) {
      case 'PDF Guide':
        return Icons.description;
      case 'Webinar':
        return Icons.video_library;
      case 'Article':
        return Icons.article;
      default:
        return Icons.info_outline;
    }
  }
} 