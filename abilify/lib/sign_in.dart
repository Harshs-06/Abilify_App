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
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email',
                prefixIcon: Icon(Icons.person)
                ),
              ),
              SizedBox(height: 12),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password',
                suffixIcon: IconButton(onPressed: _togglePasswordVisibility, icon: Icon(
                  obscureText?Icons.visibility:Icons.visibility_off)),
                  prefixIcon: Icon(Icons.lock)
                ),
                obscureText: obscureText,
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
