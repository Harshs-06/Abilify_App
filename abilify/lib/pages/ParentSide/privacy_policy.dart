import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 240, 230, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFEFE5FF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.privacy_tip,
                  color: Color(0xFF9471E1),
                  size: 40,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Privacy Policy",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Last updated: June 15, 2023",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            _buildSectionTitle("Introduction"),
            _buildParagraph(
              "Welcome to Abilify. We respect your privacy and are committed to protecting your personal data. This privacy policy will inform you about how we look after your personal data when you visit our application and tell you about your privacy rights and how the law protects you."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Data We Collect"),
            _buildParagraph(
              "We may collect, use, store and transfer different kinds of personal data about you which we have grouped together as follows:"
            ),
            _buildBulletPoint("Identity Data: Includes first name, last name, username"),
            _buildBulletPoint("Contact Data: Includes email address and telephone numbers"),
            _buildBulletPoint("Technical Data: Includes device information, IP address"),
            _buildBulletPoint("Profile Data: Includes your username, password, preferences"),
            _buildBulletPoint("Usage Data: Includes information about how you use our application"),
            SizedBox(height: 20),
            _buildSectionTitle("How We Use Your Data"),
            _buildParagraph(
              "We will only use your personal data when the law allows us to. Most commonly, we will use your personal data in the following circumstances:"
            ),
            _buildBulletPoint("To register you as a new user"),
            _buildBulletPoint("To provide and improve our services to you"),
            _buildBulletPoint("To personalize your experience"),
            _buildBulletPoint("To communicate with you about updates and changes"),
            SizedBox(height: 20),
            _buildSectionTitle("Data Security"),
            _buildParagraph(
              "We have put in place appropriate security measures to prevent your personal data from being accidentally lost, used or accessed in an unauthorized way, altered or disclosed. In addition, we limit access to your personal data to those employees, agents, contractors and other third parties who have a business need to know."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("Your Legal Rights"),
            _buildParagraph(
              "Under certain circumstances, you have rights under data protection laws in relation to your personal data, including the right to:"
            ),
            _buildBulletPoint("Request access to your personal data"),
            _buildBulletPoint("Request correction of your personal data"),
            _buildBulletPoint("Request erasure of your personal data"),
            _buildBulletPoint("Object to processing of your personal data"),
            _buildBulletPoint("Request restriction of processing your personal data"),
            _buildBulletPoint("Request transfer of your personal data"),
            _buildBulletPoint("Right to withdraw consent"),
            SizedBox(height: 20),
            _buildSectionTitle("Contact Us"),
            _buildParagraph(
              "If you have any questions about this privacy policy or our privacy practices, please contact us at:"
            ),
            _buildContactInfo("Email: privacy@abilify.com"),
            _buildContactInfo("Phone: +1 (555) 123-4567"),
            _buildContactInfo("Address: 123 Abilify Way, San Francisco, CA 94103"),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9471E1),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          height: 1.5,
          color: Colors.black87,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFF9471E1),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 5),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.black87,
        ),
      ),
    );
  }
} 