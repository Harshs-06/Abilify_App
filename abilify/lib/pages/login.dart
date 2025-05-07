import 'package:abilify/pages/sign_up.dart';
import 'package:abilify/pages/continue_as.dart';
import 'package:abilify/pages/ChildSide/child_home_page.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  final String userType;
  
  const Login({super.key, this.userType = 'parent'});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isButtonEnabled = false;
  bool obscureText = true;

  void _togglePasswordVisibility() {
    if (passwordController.text.isNotEmpty) {
      setState(() {
        obscureText = !obscureText;
      });
    }
  }

  void _checkInput() {
    setState(() {
      isButtonEnabled =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkInput);
    passwordController.addListener(_checkInput);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add spacing at the top to push content down
              SizedBox(height: 60),
              
              // Logo and family icon
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/login_logo.png',
                        width: 120,
                      ),
                    ),
                    Positioned(
                      top: 30,
                      right: 15,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 35,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 25,
                      child: Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              
              // Welcome text
              Text(
                'Welcome to abilify!',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60),
              
              // Email Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
              SizedBox(height: 16),
              
              // Password Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
              SizedBox(height: 30),
              
              // Login Button - Updated color to match sign up button
              ElevatedButton(
                onPressed: isButtonEnabled
                    ? () {
                        // Navigate based on user type
                        if (widget.userType == 'parent') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ParentHomePage(),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChildHomePage(),
                            ),
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE8668), // Coral color to match signup
                  disabledBackgroundColor: Color(0xFFFE8668).withOpacity(0.6),
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'LOGIN',
                  style: GoogleFonts.poppins(
                    color: Colors.white, // Changed to white to match signup
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              
              // Forgot Password
              GestureDetector(
                onTap: () {
                  // Forgot password functionality can be added here
                },
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
              
              Spacer(),
              
              // Sign Up Text
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
