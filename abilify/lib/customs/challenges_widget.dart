import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Padding challengeslayout(
  String title,
  String subtitle,
  double deviceWidth,
  double deviceHeight,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: Container(
      width: deviceWidth * 0.899,
      height: deviceHeight * 0.135,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 124, 124, 124),
                  fontSize: 13,
                ),
              ),
            ],
          ),

          
        ],
      ),
    ),
  );
}
