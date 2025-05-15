import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutAbilify extends StatelessWidget {
  const AboutAbilify({super.key});

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
          "About Abilify",
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
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/login_logo.png',
                    width: 80,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Our Mission",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            _buildParagraph(
              "Abilify is dedicated to empowering children with autism and their families through innovative technology. We believe in creating a more inclusive world where every child has the opportunity to grow, learn, and connect in ways that work best for them."
            ),
            SizedBox(height: 30),
            _buildSectionTitle("Who We Are"),
            _buildParagraph(
              "Founded in 2022, Abilify brings together experts in child development, autism research, education, and technology to create a supportive digital environment for children with autism and their families. Our diverse team is passionate about making a positive impact on the lives of children with autism spectrum disorders."
            ),
            SizedBox(height: 30),
            _buildSectionTitle("What We Do"),
            _buildParagraph(
              "Abilify provides a comprehensive platform with tools and resources specifically designed to support the developmental journey of children with autism. Our app features:"
            ),
            _buildFeatureItem(
              "Personalized learning experiences",
              "Interactive activities tailored to each child's unique needs and interests"
            ),
            _buildFeatureItem(
              "Communication tools",
              "Features to enhance social skills and expressiveness"
            ),
            _buildFeatureItem(
              "Parent resources",
              "Guidance, community support, and progress tracking for parents and caregivers"
            ),
            _buildFeatureItem(
              "Sensory-friendly design",
              "Carefully crafted interface with adjustable sensory inputs"
            ),
            _buildFeatureItem(
              "Expert-backed content",
              "Activities and resources developed with autism specialists"
            ),
            SizedBox(height: 30),
            _buildSectionTitle("Our Values"),
            _buildValueItem(
              "Inclusivity",
              "We design for all abilities and celebrate neurodiversity"
            ),
            _buildValueItem(
              "Empowerment",
              "We provide tools that build confidence and independence"
            ),
            _buildValueItem(
              "Collaboration",
              "We work closely with families, educators, and experts"
            ),
            _buildValueItem(
              "Innovation",
              "We continuously improve through research and feedback"
            ),
            _buildValueItem(
              "Privacy",
              "We maintain the highest standards for data protection"
            ),
            SizedBox(height: 30),
            _buildSectionTitle("Our Impact"),
            _buildParagraph(
              "Since our launch, Abilify has helped over 5,000 families across 20 countries. Our user studies show that children using Abilify regularly demonstrate improved communication skills, increased engagement with learning activities, and reduced anxiety in social situations."
            ),
            SizedBox(height: 30),
            _buildSectionTitle("Contact Us"),
            _buildParagraph(
              "We value your feedback and questions. Get in touch with us:"
            ),
            _buildContactInfo("Email: hello@abilify.com"),
            _buildContactInfo("Phone: +1 (555) 123-4567"),
            _buildContactInfo("Address: 123 Abilify Way"),
            SizedBox(height: 20),
            _buildParagraph(
              "Follow us on social media @AbilifyApp to stay updated with our latest features and resources."
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9471E1),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
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

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFFEFE5FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: Color(0xFF9471E1),
                size: 14,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFFFEE5D3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.star,
                color: Color(0xFFFE8668),
                size: 14,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: 8,
            color: Color(0xFF9471E1),
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
} 