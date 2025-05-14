import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/customs/device_dimensions.dart';
import 'package:abilify/services/auth_service.dart';

class ParentProfileEdit extends StatefulWidget {
  const ParentProfileEdit({super.key});

  @override
  State<ParentProfileEdit> createState() => _ParentProfileEditState();
}

class _ParentProfileEditState extends State<ParentProfileEdit> {
  // Form controllers
  late TextEditingController _nameController;
  final TextEditingController _emailController = TextEditingController(text: "palak@example.com");
  final TextEditingController _phoneController = TextEditingController(text: "+1 (555) 123-4567");
  final TextEditingController _childNameController = TextEditingController(text: "Jai");
  final TextEditingController _childAgeController = TextEditingController(text: "10");
  
  final String profileImg = "assets/profile_p2.png";
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // Initialize name controller with user's display name
    _nameController = TextEditingController(
      text: _authService.currentUser?.displayName ?? "Palak"
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _childNameController.dispose();
    _childAgeController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // Set loading state
    setState(() {
      _isLoading = true;
    });

    // Get updated values
    final String name = _nameController.text.trim();
    
    // Update auth user profile if name has changed
    if (name != (_authService.currentUser?.displayName ?? "")) {
      _authService.updateUserProfile(displayName: name);
    }

    // Simulate saving profile
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Color(0xFF9471E1),
        ),
      );
      
      // Navigate back
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = getDevice_wh(context)[0];
    final deviceHeight = getDevice_wh(context)[1];
    
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
          "Edit Profile",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Profile picture
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
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
                          profileImg,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF9471E1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          onPressed: () {
                            // Handle image change
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('This feature is not available yet'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 40),
              
              // Profile form
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Your Information"),
                    _buildTextField("Full Name", _nameController, Icons.person),
                    SizedBox(height: 15),
                    _buildTextField("Email", _emailController, Icons.email),
                    SizedBox(height: 15),
                    _buildTextField("Phone", _phoneController, Icons.phone),
                    
                    SizedBox(height: 30),
                    
                    _buildSectionTitle("Child Information"),
                    _buildTextField("Child's Name", _childNameController, Icons.child_care),
                    SizedBox(height: 15),
                    _buildTextField("Child's Age", _childAgeController, Icons.calendar_today),
                    
                    SizedBox(height: 40),
                    
                    // Save button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9471E1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Save Changes",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9471E1),
        ),
      ),
    );
  }
  
  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          prefixIcon: Icon(icon, color: Color(0xFF9471E1)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
} 