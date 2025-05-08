import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TherapistDirectory extends StatelessWidget {
  const TherapistDirectory({Key? key}) : super(key: key);

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
          'Therapist Directory',
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
                            hintText: 'Search therapists...',
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
                  'Specialties',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Specialties grid
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildSpecialtyChip('Speech Therapy'),
                    _buildSpecialtyChip('Occupational Therapy'),
                    _buildSpecialtyChip('Physical Therapy'),
                    _buildSpecialtyChip('Behavioral Therapy'),
                    _buildSpecialtyChip('ASD Specialists'),
                    _buildSpecialtyChip('Child Psychology'),
                  ],
                ),
                
                SizedBox(height: 24),
                
                Text(
                  'Top Rated Therapists',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Therapists list
                _buildTherapistCard(
                  name: 'Dr. Sarah Johnson',
                  specialty: 'Speech Therapy',
                  rating: 4.9,
                  imageUrl: 'assets/therapist1.png',
                ),
                
                SizedBox(height: 16),
                
                _buildTherapistCard(
                  name: 'Dr. Michael Chen',
                  specialty: 'Occupational Therapy',
                  rating: 4.8,
                  imageUrl: 'assets/therapist2.png',
                ),
                
                SizedBox(height: 16),
                
                _buildTherapistCard(
                  name: 'Dr. Emily Williams',
                  specialty: 'Behavioral Therapy',
                  rating: 4.7,
                  imageUrl: 'assets/therapist3.png',
                ),
                
                SizedBox(height: 16),
                
                _buildTherapistCard(
                  name: 'Dr. James Wilson',
                  specialty: 'Child Psychology',
                  rating: 4.9,
                  imageUrl: 'assets/therapist4.png',
                ),
                
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildSpecialtyChip(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF4DC3FF).withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4DC3FF),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTherapistCard({
    required String name,
    required String specialty,
    required double rating,
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
                child: Icon(Icons.person, color: Colors.grey.shade600),
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
                Text(
                  specialty,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
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
                      child: Text('Book'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4DC3FF),
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
} 