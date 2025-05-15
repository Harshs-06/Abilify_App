import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AbilifyBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AbilifyBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF9471E1), // Purple color from image
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              activeIcon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF9471E1).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.home),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Services',
              activeIcon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF9471E1).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.explore),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Community',
              activeIcon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF9471E1).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.group),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Chats',
              activeIcon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF9471E1).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.chat_bubble_outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 