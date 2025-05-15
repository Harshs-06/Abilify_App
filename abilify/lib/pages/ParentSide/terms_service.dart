import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsService extends StatelessWidget {
  const TermsService({super.key});

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
          "Terms of Service",
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
                  Icons.description,
                  color: Color(0xFF9471E1),
                  size: 40,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Terms of Service",
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
            _buildSectionTitle("1. Acceptance of Terms"),
            _buildParagraph(
              "By accessing or using Abilify, you agree to be bound by these Terms of Service and all applicable laws and regulations. If you do not agree with any of these terms, you are prohibited from using or accessing this application."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("2. Use License"),
            _buildParagraph(
              "Permission is granted to temporarily use this application for personal, non-commercial purposes only. This is the grant of a license, not a transfer of title, and under this license you may not:"
            ),
            _buildBulletPoint("Modify or copy the materials"),
            _buildBulletPoint("Use the materials for any commercial purpose"),
            _buildBulletPoint("Attempt to decompile or reverse engineer any software contained in Abilify"),
            _buildBulletPoint("Remove any copyright or other proprietary notations from the materials"),
            _buildBulletPoint("Transfer the materials to another person or 'mirror' the materials on any other server"),
            _buildParagraph(
              "This license shall automatically terminate if you violate any of these restrictions and may be terminated by Abilify at any time."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("3. User Accounts"),
            _buildParagraph(
              "In order to use certain features of the application, you may be required to register for an account. You must provide accurate and complete information and keep your account information updated. You are responsible for the security of your account and password. Abilify cannot and will not be liable for any loss or damage from your failure to comply with this security obligation."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("4. User Content"),
            _buildParagraph(
              "Users may post content as available in the application. By providing your content to Abilify, you grant us a worldwide, non-exclusive, royalty-free license to use, reproduce, adapt, publish, translate and distribute your content in any existing or future media. You represent and warrant that the content is yours and that you have the right to grant the rights and licenses specified above."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("5. Prohibitions"),
            _buildParagraph(
              "The following activities are strictly prohibited:"
            ),
            _buildBulletPoint("Posting or transmitting any unlawful, threatening, abusive, libelous, defamatory, obscene, or pornographic content"),
            _buildBulletPoint("Impersonating any person or entity"),
            _buildBulletPoint("Uploading invalid data, viruses, worms, or other malicious software"),
            _buildBulletPoint("Interfering with the proper working of the application"),
            _buildBulletPoint("Attempting to bypass any measures designed to prevent or restrict access to the application"),
            SizedBox(height: 20),
            _buildSectionTitle("6. Disclaimer"),
            _buildParagraph(
              "The materials on Abilify are provided on an 'as is' basis. Abilify makes no warranties, expressed or implied, and hereby disclaims and negates all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("7. Limitations"),
            _buildParagraph(
              "In no event shall Abilify or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on Abilify, even if Abilify or a Abilify authorized representative has been notified orally or in writing of the possibility of such damage."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("8. Governing Law"),
            _buildParagraph(
              "These terms and conditions are governed by and construed in accordance with the laws of the United States and you irrevocably submit to the exclusive jurisdiction of the courts in that location."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("9. Changes to Terms"),
            _buildParagraph(
              "Abilify reserves the right, at its sole discretion, to modify or replace these Terms at any time. What constitutes a material change will be determined at our sole discretion. By continuing to access or use our application after those revisions become effective, you agree to be bound by the revised terms."
            ),
            SizedBox(height: 20),
            _buildSectionTitle("10. Contact Us"),
            _buildParagraph(
              "If you have any questions about these Terms, please contact us at:"
            ),
            _buildContactInfo("Email: terms@abilify.com"),
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