import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentControls extends StatefulWidget {
  const ParentControls({super.key});

  @override
  State<ParentControls> createState() => _ParentControlsState();
}

class _ParentControlsState extends State<ParentControls> {
  bool isAuthenticated = false;
  final TextEditingController pinController = TextEditingController();
  final String correctPin = "1234"; // Simplified for demo
  
  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      appBar: AppBar(
        backgroundColor: Colors.amber.shade300,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Parent Controls',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isAuthenticated 
            ? _buildControlsScreen() 
            : _buildAuthenticationScreen(),
      ),
    );
  }
  
  Widget _buildAuthenticationScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock,
            size: 80,
            color: Colors.amber.shade700,
          ),
          SizedBox(height: 24),
          Text(
            'Parent Authentication Required',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Please enter your parental control PIN to access these settings',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                counterText: "",
                hintText: "PIN",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (pinController.text == correctPin) {
                setState(() {
                  isAuthenticated = true;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Incorrect PIN. Please try again.')),
                );
                pinController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 125, 89),
              minimumSize: Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Verify',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildControlsScreen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  size: 32,
                  color: Colors.amber.shade800,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Manage content access and settings for your child',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24),
          
          Text(
            'Content Access',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildControlItem(
            title: 'Age-appropriate Content',
            description: 'Only show content suitable for children',
            icon: Icons.child_care,
            iconColor: Colors.green,
            hasSwitch: true,
            initialValue: true,
          ),
          
          _buildControlItem(
            title: 'Content Filters',
            description: 'Adjust content filtering levels',
            icon: Icons.filter_list,
            iconColor: Colors.blue,
            hasSwitch: false,
          ),
          
          SizedBox(height: 24),
          
          Text(
            'Time Management',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildControlItem(
            title: 'Screen Time Limits',
            description: 'Set daily app usage limits',
            icon: Icons.timer,
            iconColor: Colors.purple,
            hasSwitch: false,
          ),
          
          _buildControlItem(
            title: 'Bedtime Mode',
            description: 'Restrict usage during bedtime hours',
            icon: Icons.nightlight_round,
            iconColor: Colors.indigo,
            hasSwitch: true,
            initialValue: true,
          ),
          
          SizedBox(height: 24),
          
          Text(
            'Security',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildControlItem(
            title: 'Change Parent PIN',
            description: 'Update your parental control PIN',
            icon: Icons.vpn_key,
            iconColor: Colors.amber,
            hasSwitch: false,
          ),
          
          SizedBox(height: 40),
          
          Center(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Settings updated successfully')),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 125, 89),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Save Changes',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildControlItem({
    required String title,
    required String description,
    required IconData icon,
    required Color iconColor,
    required bool hasSwitch,
    bool initialValue = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          description,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: hasSwitch 
            ? Switch(
                value: initialValue,
                onChanged: (value) {
                  // In a real app, this would save the switch state
                },
                activeColor: Color.fromARGB(255, 255, 125, 89),
              ) 
            : Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
              ),
        onTap: hasSwitch ? null : () {
          // Would navigate to specific settings in a real app
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening $title settings')),
          );
        },
      ),
    );
  }
} 