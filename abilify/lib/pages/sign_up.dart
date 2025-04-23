import 'package:abilify/pages/continue_as.dart';
import 'package:abilify/pages/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
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
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty&& usernameController.text.isNotEmpty;
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/abilify_logo.png"),
              Container(
                // width: 300,
    
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.name,
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'UserName',
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                // width: 300,
    
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField( 
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      onPressed: _togglePasswordVisibility,
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: obscureText,
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: isButtonEnabled ? () {
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => ContinueAs()
                  ),
                  );
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Unable to fetch this email'),
                  //   behavior: SnackBarBehavior.floating,
                  //   showCloseIcon: false,
                  //   duration: Duration(seconds: 5),
                  //   )
                  // );
                } : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(400, 50),
                  maximumSize: Size(400, 50),
                  backgroundColor:
                      isButtonEnabled
                          ? Color.fromARGB(255, 255, 125, 89)
                          : Color.fromARGB(255, 255, 185, 166),
                  disabledBackgroundColor: Color.fromARGB(255, 255, 185, 166),
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child:Center(child: Text(
                  "SignUp",
                  style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w700),
                  ),
                
                ),
              ),
              SizedBox(height: 12),
              RichText(text: TextSpan(
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: 'Alread Registered? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(color:Colors.blueAccent),
                    recognizer: TapGestureRecognizer()
                    ..onTap = (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login())
                      );
                    },
                  ),
                ],
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
