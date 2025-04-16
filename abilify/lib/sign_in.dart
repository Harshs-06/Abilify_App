import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isButtonEnabled = false;
  bool obscureText = true;

  void _togglePasswordVisibility() {
    if(passwordController.text.isNotEmpty){
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(
                    color: Colors.black12,
                    blurRadius:4,
                    offset: Offset(0, 2), 
                  )]
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email',labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.person)
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(
                    color: Colors.black12,
                    blurRadius:4,
                    offset: Offset(0, 2), 
                  )]
                ),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password',labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide.none),
                  suffixIcon: IconButton(onPressed: _togglePasswordVisibility, icon: Icon(
                    obscureText?Icons.visibility:Icons.visibility_off)),
                    filled: true,
                  fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock)
                  ),
                  obscureText: obscureText,
                ),
              ),
              ElevatedButton(onPressed: (){}, child: Center(
                child: Text("Sign In"),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
