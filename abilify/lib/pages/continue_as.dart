import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:local_auth/local_auth.dart';

// class ContinueAs extends StatelessWidget {
//   @override
//   _ContinueCredentials createState() => _ContinueCredentials();
// }

class ContinueAs extends StatelessWidget {
  final auth = LocalAuthentication();

  ContinueAs({super.key});
  Future<void> authentication() async {
    bool isAvailable = await auth.canCheckBiometrics;
    if (isAvailable) {
      bool authenticated = await auth.authenticate(
        localizedReason: "Scan your fingerprint to continue",
        options: AuthenticationOptions(biometricOnly: true),
      );
      // if(authenticated){

      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final parentName = "Palak";
    final childName = "Jade";
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 239, 215),
      resizeToAvoidBottomInset: false,
      body: Column(
       
    ));
  }
}
