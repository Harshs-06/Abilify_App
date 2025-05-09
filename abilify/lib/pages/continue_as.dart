import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/pages/login.dart';

// class ContinueAs extends StatelessWidget {
//   @override
//   _ContinueCredentials createState() => _ContinueCredentials();
// }

class ContinueAs extends StatelessWidget {
  const ContinueAs({super.key});

  @override
  Widget build(BuildContext context) {
    final parentName = "Palak";
    final childName = "Jade";
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  // Logo and tagline - made bigger
                  Image.asset(
                    'assets/abilify_logo.png',
                    height: 200, // Increased from 150
                  ),
                  SizedBox(height: 40), // Reduced from 60
                  
                  // Continue As text
                  Text(
                    'CONTINUE AS',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 40), // Reduced from 60
                  
                  // Profile options - moved up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Parent Profile (Palak)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to login with parent intent
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(
                                    userType: 'parent',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.teal.shade300,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/profile_p2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            parentName,
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 60),
                      // Child Profile (Jade)
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to login with child intent
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(
                                    userType: 'child',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue.shade300,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/child_pf.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            childName,
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
