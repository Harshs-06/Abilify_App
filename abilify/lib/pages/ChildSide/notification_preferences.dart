import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPreferences extends StatefulWidget {
  const NotificationPreferences({super.key});

  @override
  State<NotificationPreferences> createState() => _NotificationPreferencesState();
}

class _NotificationPreferencesState extends State<NotificationPreferences> {
  bool allowNotifications = true;
  bool dailyReminders = true;
  bool achievementAlerts = true;
  bool soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 239, 215),
      appBar: AppBar(
        backgroundColor: Colors.amber.shade300,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notification Settings',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notifications_active,
                    size: 32,
                    color: Colors.amber.shade800,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Manage how you receive notifications and alerts',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
            Text(
              'Notification Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            SizedBox(height: 16),
            
            // Notification switches
            buildSwitchTile(
              title: 'Allow Notifications',
              subtitle: 'Enable or disable all notifications',
              value: allowNotifications,
              onChanged: (value) {
                setState(() {
                  allowNotifications = value;
                  // If main switch is off, turn all others off too
                  if (!value) {
                    dailyReminders = false;
                    achievementAlerts = false;
                    soundEnabled = false;
                  }
                });
              },
              icon: Icons.notifications,
              iconColor: Colors.purple,
            ),
            
            buildSwitchTile(
              title: 'Daily Reminders',
              subtitle: 'Receive daily reminders for activities',
              value: allowNotifications && dailyReminders,
              onChanged: allowNotifications
                  ? (value) {
                      setState(() {
                        dailyReminders = value;
                      });
                    }
                  : null,
              icon: Icons.calendar_today,
              iconColor: Colors.blue,
            ),
            
            buildSwitchTile(
              title: 'Achievement Alerts',
              subtitle: 'Get notified when you earn achievements',
              value: allowNotifications && achievementAlerts,
              onChanged: allowNotifications
                  ? (value) {
                      setState(() {
                        achievementAlerts = value;
                      });
                    }
                  : null,
              icon: Icons.emoji_events,
              iconColor: Colors.amber,
            ),
            
            SizedBox(height: 24),
            
            Text(
              'Sound Settings',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            SizedBox(height: 16),
            
            buildSwitchTile(
              title: 'Notification Sounds',
              subtitle: 'Play sounds with notifications',
              value: allowNotifications && soundEnabled,
              onChanged: allowNotifications
                  ? (value) {
                      setState(() {
                        soundEnabled = value;
                      });
                    }
                  : null,
              icon: Icons.volume_up,
              iconColor: Colors.green,
            ),
            
            SizedBox(height: 40),
            
            // Save Button
            ElevatedButton(
              onPressed: () {
                // Save notification settings
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Notification settings updated')),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 125, 89),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Save Changes',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool)? onChanged,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Color.fromARGB(255, 255, 125, 89),
        ),
      ),
    );
  }
} 