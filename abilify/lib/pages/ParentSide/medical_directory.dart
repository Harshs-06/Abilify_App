import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/widgets/map_view.dart';
import 'package:abilify/utils/map_utils.dart';
import 'package:abilify/utils/email_utils.dart';

class MedicalDirectory extends StatefulWidget {
  const MedicalDirectory({super.key});

  @override
  _MedicalDirectoryState createState() => _MedicalDirectoryState();
}

class _MedicalDirectoryState extends State<MedicalDirectory> {
  bool _showMap = false;

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
        actions: [
          IconButton(
            icon: Icon(
              _showMap ? Icons.list : Icons.map,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _showMap = !_showMap;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _showMap 
            ? _buildMapView() 
            : _buildListView(),
      ),
    );
  }

  Widget _buildMapView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Text(
              'Nearby Medical Facilities',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            'Tap on markers to view facility details',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          MapView(
            markers: MapUtils.getMedicalMarkers(),
            markerColor: Color(0xFF8AE066),
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showMap = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF8AE066),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list),
                SizedBox(width: 8),
                Text(
                  'Switch to List View',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return SingleChildScrollView(
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
            
            // Replace Categories grid with Map
            SizedBox(
              height: 200,
              child: MapView(
                markers: MapUtils.getMedicalMarkers(),
                markerColor: Color(0xFF8AE066),
                height: 200,
                showCurrentLocation: true,
              ),
            ),
            
            SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nearby Hospitals & Clinics',
                  style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showMap = true;
                    });
                  },
                  icon: Icon(Icons.map, size: 18),
                  label: Text('Map'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8AE066),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
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
                      onPressed: () {
                        EmailUtils.launchContactEmail(
                          serviceName: specialty,
                          providerName: name,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFF8AE066),
                        side: BorderSide(color: Color(0xFF8AE066)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Map'),
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
                      onPressed: () {
                        EmailUtils.launchBookingEmail(
                          serviceName: specialty,
                          providerName: name,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8AE066),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text('Book'),
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