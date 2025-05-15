 import 'package:flutter/material.dart';
 import 'package:google_fonts/google_fonts.dart';


  GestureDetector actionsButton(String title, String ticon,VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(225, 233, 243, 1), width: 1),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: ClipOval(child: Image.asset(ticon)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }