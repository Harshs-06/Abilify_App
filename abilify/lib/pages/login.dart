import 'package:abilify/pages/sign_up.dart';
import 'package:abilify/pages/ChildSide/child_home_page.dart';
import 'package:abilify/pages/ParentSide/parent_home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:abilify/services/auth_service.dart'; 

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
  final AuthService _authService = AuthService();
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
          passwordController.text.isNotEmpty;
    });
  }
  
  bool _isValidEmail(String email) {
    return email.toLowerCase().endsWith('@gmail.com');
  }

  Future<void> _login() async {
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
      
      final user = await _authService.signInWithEmailAndPassword(email, password);
      
      if (user != null) {
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
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Welcome to abilify!',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
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
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: isButtonEnabled ? (_isLoading ? null : _login) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFE8668),
                  disabledBackgroundColor: const Color(0xFFFE8668).withOpacity(0.6),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: _isLoading 
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'LOGIN',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Implement forgot password logic here
                },
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    children: [
                      const TextSpan(text: "Don't have an account? "),
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
                                builder: (context) => SignIn(userType: widget.userType),
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
