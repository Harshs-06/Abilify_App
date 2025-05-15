import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/widgets/map_view.dart';
import 'package:abilify/utils/map_utils.dart';
import 'package:abilify/utils/email_utils.dart';

class CareDirectory extends StatefulWidget {
  const CareDirectory({Key? key}) : super(key: key);

  @override
  _CareDirectoryState createState() => _CareDirectoryState();
}

class _CareDirectoryState extends State<CareDirectory> {
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
          'Caregivers Directory',
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
              'Available Caregivers',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            'Tap on markers to view caregiver details',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          MapView(
            markers: MapUtils.getCaregiverMarkers(),
            markerColor: Color(0xFFAA7EFF),
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
              backgroundColor: Color(0xFFAA7EFF),
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
                        hintText: 'Search caregiving services...',
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
              'Care Services',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            SizedBox(height: 16),
            
            // Replace Care services grid with Map
            Container(
              height: 200,
              child: MapView(
                markers: MapUtils.getCaregiverMarkers(),
                markerColor: Color(0xFFAA7EFF),
                height: 200,
                showCurrentLocation: true,
              ),
            ),
            
            SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended Caregivers',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
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
                    backgroundColor: Color(0xFFAA7EFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Caregivers list
            _buildCaregiverCard(
              name: 'Maria Garcia',
              specialty: 'Special Needs Nanny',
              rating: 4.9,
              experience: '5+ years',
              imageUrl: 'assets/caregiver1.png',
            ),
            
            SizedBox(height: 16),
            
            _buildCaregiverCard(
              name: 'David Lee',
              specialty: 'Respite Care Provider',
              rating: 4.8,
              experience: '7+ years',
              imageUrl: 'assets/caregiver2.png',
            ),
            
            SizedBox(height: 16),
            
            _buildCaregiverCard(
              name: 'Sophie Miller',
              specialty: 'ABA Therapist & Caregiver',
              rating: 4.9,
              experience: '4+ years',
              imageUrl: 'assets/caregiver3.png',
            ),
            
            SizedBox(height: 24),
            
            Text(
              'Care Agencies',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            SizedBox(height: 16),
            
            // Care agencies list
            _buildAgencyCard(
              name: 'Sunshine Care Services',
              services: 'Respite, In-home Support',
              verified: true,
            ),
            
            SizedBox(height: 12),
            
            _buildAgencyCard(
              name: 'Helping Hands Agency',
              services: 'Full-time Care, Therapy Support',
              verified: true,
            ),
            
            SizedBox(height: 12),
            
            _buildAgencyCard(
              name: 'Special Care Providers',
              services: 'Day Programs, After School Care',
              verified: false,
            ),
            
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
  
  Widget _buildServiceChip(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFAA7EFF).withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFFAA7EFF),
          ),
        ),
      ),
    );
  }
  
  Widget _buildCaregiverCard({
    required String name,
    required String specialty,
    required double rating,
    required String experience,
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
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        specialty,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      ' • $experience',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
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
                      onPressed: () {
                        EmailUtils.launchContactEmail(
                          serviceName: specialty,
                          providerName: name,
                        );
                      },
                      child: Text('Contact'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFAA7EFF),
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
  
  Widget _buildAgencyCard({
    required String name,
    required String services,
    required bool verified,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFFAA7EFF).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.business,
              color: Color(0xFFAA7EFF),
              size: 30,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (verified) ...[
                      SizedBox(width: 4),
                      Icon(
                        Icons.verified,
                        color: Color(0xFFAA7EFF),
                        size: 16,
                      ),
                    ],
                  ],
                ),
                Text(
                  services,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        EmailUtils.launchContactEmail(
                          serviceName: 'Agency Information',
                          providerName: name,
                          recipient: 'info@$name.com'.toLowerCase().replaceAll(' ', ''),
                        );
                      },
                      child: Text('View'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Color(0xFFAA7EFF),
                        side: BorderSide(color: Color(0xFFAA7EFF)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        EmailUtils.launchContactEmail(
                          serviceName: services,
                          providerName: name,
                        );
                      },
                      child: Text('Contact'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFAA7EFF),
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