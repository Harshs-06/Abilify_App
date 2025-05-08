import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalDirectory extends StatelessWidget {
  const MedicalDirectory({Key? key}) : super(key: key);

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
          'Medical Directory',
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
                            hintText: 'Search medical services...',
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
                  'Specializations',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Categories grid
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildCategoryChip('Pediatrics'),
                    _buildCategoryChip('Child Neurology'),
                    _buildCategoryChip('Developmental Medicine'),
                    _buildCategoryChip('Child Psychiatry'),
                    _buildCategoryChip('Genetic Specialists'),
                    _buildCategoryChip('Telemedicine'),
                  ],
                ),
                
                SizedBox(height: 24),
                
                Text(
                  'Nearby Hospitals & Clinics',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Medical facilities list
                _buildMedicalFacilityCard(
                  name: 'Children\'s Wellness Center',
                  specialty: 'Special Needs & Development',
                  distance: '0.8',
                  imageUrl: 'assets/hospital1.png',
                ),
                
                SizedBox(height: 16),
                
                _buildMedicalFacilityCard(
                  name: 'Sunshine Pediatric Clinic',
                  specialty: 'Child Neurology, Pediatrics',
                  distance: '1.2',
                  imageUrl: 'assets/hospital2.png',
                ),
                
                SizedBox(height: 16),
                
                _buildMedicalFacilityCard(
                  name: 'Hope Development Center',
                  specialty: 'Developmental Medicine',
                  distance: '2.4',
                  imageUrl: 'assets/hospital3.png',
                ),
                
                SizedBox(height: 24),
                
                Text(
                  'Top Pediatric Specialists',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Specialists list
                _buildSpecialistCard(
                  name: 'Dr. Jennifer Adams',
                  specialty: 'Pediatric Neurologist',
                  rating: 4.9,
                  imageUrl: 'assets/doctor1.png',
                ),
                
                SizedBox(height: 16),
                
                _buildSpecialistCard(
                  name: 'Dr. Robert Torres',
                  specialty: 'Developmental Pediatrician',
                  rating: 4.8,
                  imageUrl: 'assets/doctor2.png',
                ),
                
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildCategoryChip(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF8AE066).withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: label.length > 15 ? 12 : 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF8AE066),
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }
  
  Widget _buildMedicalFacilityCard({
    required String name,
    required String specialty,
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
                child: Icon(Icons.local_hospital, color: Colors.grey.shade600),
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
                    Icon(Icons.location_on, color: Colors.redAccent, size: 18),
                    SizedBox(width: 4),
                    Text(
                      '$distance miles away',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('Map'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF8AE066),
                        side: BorderSide(color: Color(0xFF8AE066)),
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
  
  Widget _buildSpecialistCard({
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
                        backgroundColor: Color(0xFF8AE066),
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