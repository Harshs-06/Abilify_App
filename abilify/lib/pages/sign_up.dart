import 'package:abilify/pages/continue_as.dart';
import 'package:abilify/pages/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:abilify/pages/ChildSide/child_home_page.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/services/auth_service.dart';

class SignIn extends StatefulWidget {
  final String userType;
  
  const SignIn({super.key, this.userType = 'parent'});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isButtonEnabled = false;
  bool obscureText = true;
  String? _errorMessage;
  bool _isLoading = false;

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
          emailController.text.isNotEmpty && 
          passwordController.text.isNotEmpty && 
          usernameController.text.isNotEmpty;
    });
  }
  
  bool _isValidEmail(String email) {
    return email.toLowerCase().endsWith('@gmail.com');
  }
  
  Future<void> _signUp() async {
    // First check if email format is valid
    if (!_isValidEmail(emailController.text.trim())) {
      setState(() {
        _errorMessage = 'Email must end with @gmail.com';
      });
      return;
    }
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final displayName = usernameController.text.trim();
      
      final user = await _authService.createUserWithEmailAndPassword(
        email,
        password,
        displayName: displayName,
      );
      
      // Navigate to the appropriate home page based on user type
      if (widget.userType == 'parent') {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const ParentHomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const ChildHomePage()),
        );
      }
        } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    emailController.addListener(_checkInput);
    passwordController.addListener(_checkInput);
    usernameController.addListener(_checkInput);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
              
              // Title and Subtitle
              Text(
                'Create your Account',
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'access abilify from anywhere',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              
              // Full Name Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.person_outline,
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
                    hintText: 'Email (@gmail.com)',
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
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 30),
              
              // Sign Up Button
              ElevatedButton(
                onPressed: isButtonEnabled ? (_isLoading ? null : _signUp) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE8668), // Coral color
                  disabledBackgroundColor: Color(0xFFFE8668).withOpacity(0.6),
                  minimumSize: Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
              
              Spacer(),
              
              // Login Text
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
                        text: 'Already have an account? ',
                      ),
                      TextSpan(
                        text: 'Login',
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login(userType: widget.userType))
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
