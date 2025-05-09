import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParentSettings extends StatefulWidget {
  const ParentSettings({super.key});

  @override
  State<ParentSettings> createState() => _ParentSettingsState();
}

class _ParentSettingsState extends State<ParentSettings> {
  // Settings state
  bool _notificationsEnabled = true;
  bool _emailUpdates = true;
  bool _darkMode = false;
  String _language = 'English';
  double _textSize = 1.0;

  // Language options
  final List<String> _languages = ['English', 'Spanish', 'French', 'Hindi', 'Mandarin'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 240, 230, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Notifications"),
              _buildSettingSwitch(
                "Push Notifications",
                "Receive alerts for messages and events",
                _notificationsEnabled,
                (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
              _buildDivider(),
              _buildSettingSwitch(
                "Email Updates",
                "Receive weekly summaries and updates",
                _emailUpdates,
                (value) {
                  setState(() {
                    _emailUpdates = value;
                  });
                },
              ),
              
              SizedBox(height: 30),
              
              _buildSectionTitle("Appearance"),
              _buildSettingSwitch(
                "Dark Mode",
                "Use dark theme throughout the app",
                _darkMode,
                (value) {
                  setState(() {
                    _darkMode = value;
                    // In a real app, this would trigger theme change
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Dark mode will be available in a future update'),
                        backgroundColor: Color(0xFF9471E1),
                      ),
                    );
                  });
                },
              ),
              _buildDivider(),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Text Size",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Adjust the size of text throughout the app",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),
                    Slider(
                      value: _textSize,
                      min: 0.8,
                      max: 1.3,
                      divisions: 5,
                      activeColor: Color(0xFF9471E1),
                      inactiveColor: Color(0xFFD8C6FF),
                      label: _getTextSizeLabel(),
                      onChanged: (value) {
                        setState(() {
                          _textSize = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "A",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "A",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 30),
              
              _buildSectionTitle("Language"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _language,
                    icon: Icon(Icons.arrow_drop_down, color: Color(0xFF9471E1)),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _language = newValue;
                        });
                      }
                    },
                    items: _languages.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              
              SizedBox(height: 30),
              
              _buildSectionTitle("Privacy & Security"),
              _buildSettingItem(
                "Privacy Policy",
                "Review our privacy terms",
                Icons.privacy_tip_outlined,
                () {
                  // Show privacy policy
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Privacy policy will be available in a future update'),
                    ),
                  );
                },
              ),
              _buildDivider(),
              _buildSettingItem(
                "Terms of Service",
                "Review our terms of service",
                Icons.description_outlined,
                () {
                  // Show terms of service
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Terms of service will be available in a future update'),
                    ),
                  );
                },
              ),
              _buildDivider(),
              _buildSettingItem(
                "Change Password",
                "Update your account password",
                Icons.lock_outline,
                () {
                  // Navigate to change password screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Password change will be available in a future update'),
                    ),
                  );
                },
              ),
              
              SizedBox(height: 30),
              
              _buildSectionTitle("About"),
              _buildSettingItem(
                "About Abilify",
                "Learn more about our mission",
                Icons.info_outline,
                () {
                  // Show about info
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('About page will be available in a future update'),
                    ),
                  );
                },
              ),
              _buildDivider(),
              _buildSettingItem(
                "Version",
                "1.0.0",
                Icons.new_releases_outlined,
                null,
              ),
              
              SizedBox(height: 40),
              
              // Save button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Save settings
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Settings saved successfully!'),
                        backgroundColor: Color(0xFF9471E1),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9471E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Save Settings",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _getTextSizeLabel() {
    if (_textSize < 0.9) return "Small";
    if (_textSize < 1.0) return "Medium Small";
    if (_textSize < 1.1) return "Medium";
    if (_textSize < 1.2) return "Medium Large";
    return "Large";
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF9471E1),
        ),
      ),
    );
  }
  
  Widget _buildSettingSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF9471E1),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingItem(
    String title,
    String subtitle,
    IconData icon,
    Function()? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFFEFE5FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Color(0xFF9471E1),
                size: 24,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
    );
  }
} 