import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:abilify/services/user_data_provider.dart';
import 'package:abilify/services/auth_service.dart';

class EditProfile extends StatefulWidget {
  final String initialName;
  final String initialAge;
  final String profileImage;

  const EditProfile({
    super.key, 
    this.initialName = 'Super Learner', 
    this.initialAge = '8',
    this.profileImage = 'assets/child_pf.png'
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  DateTime? selectedDate;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  String profileImagePath = '';
  bool isAssetImage = true;
  bool hasChanges = false;
  final UserDataProvider _userDataProvider = UserDataProvider();
  final AuthService _authService = AuthService();
  
  @override
  void initState() {
    super.initState();
    // Try to get the name from auth service first
    String displayName = _authService.currentUser?.displayName ?? widget.initialName;
    nameController = TextEditingController(text: displayName);
    ageController = TextEditingController(text: widget.initialAge);
    profileImagePath = widget.profileImage;
    
    // Check if the initial image is an asset or a file
    if (widget.profileImage.startsWith('/')) {
      isAssetImage = false;
      _imageFile = File(widget.profileImage);
    }
    
    // Listen for changes to detect modifications
    nameController.addListener(_onFieldChanged);
    ageController.addListener(_onFieldChanged);
  }
  
  void _onFieldChanged() {
    setState(() {
      hasChanges = true;
    });
  }
  
  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    int initialAge = 8;
    try {
      initialAge = int.parse(ageController.text);
    } catch (e) {
      // Use default if parsing fails
    }
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now.subtract(Duration(days: 365 * initialAge)),
      firstDate: DateTime(now.year - 18),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 255, 125, 89),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        // Calculate age based on selected date
        final age = (now.difference(picked).inDays / 365).floor();
        ageController.text = age.toString();
        hasChanges = true;
      });
    }
  }
  
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          isAssetImage = false;
          hasChanges = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog if there are unsaved changes
        if (hasChanges) {
          final shouldDiscard = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Discard Changes?'),
              content: Text('You have unsaved changes. Are you sure you want to go back?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Discard'),
                ),
              ],
            ),
          );
          return shouldDiscard ?? false;
        }
        return true;
      },
      child: Scaffold(
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
            onPressed: () {
              // Check for unsaved changes
              if (hasChanges) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Discard Changes?'),
                    content: Text('You have unsaved changes. Are you sure you want to go back?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Discard'),
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            'Edit Profile',
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
            children: [
              const SizedBox(height: 20),
              
              // Profile Picture
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.amber,
                          width: 4.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: isAssetImage 
                            ? Image.asset(
                                profileImagePath,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                _imageFile!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber,
                            border: Border.all(
                              width: 2,
                              color: Colors.white,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Form Fields
              buildFormField(
                label: 'Name',
                hintText: 'Enter your name',
                controller: nameController,
                icon: Icons.person,
              ),
              
              const SizedBox(height: 20),
              
              buildAgeField(
                label: 'Age',
                hintText: 'Enter your age',
                controller: ageController,
                onIconTap: () => _selectDate(context),
              ),
              
              const SizedBox(height: 40),
              
              // Save Button
              ElevatedButton(
                onPressed: () async {
                  // Validate input
                  final name = nameController.text.trim();
                  final age = ageController.text.trim();
                  
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a name')),
                    );
                    return;
                  }
                  
                  // Update auth service with new display name
                  if (_authService.currentUser != null && 
                      name != (_authService.currentUser?.displayName ?? "")) {
                    try {
                      await _authService.updateUserProfile(displayName: name);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error updating profile: $e')),
                      );
                    }
                  }
                  
                  // Update user data provider
                  await _userDataProvider.updateProfile(
                    name: name,
                    age: age,
                    image: isAssetImage ? profileImagePath : _imageFile!.path,
                    isAsset: isAssetImage,
                  );

                  // Return the updated profile data to previous screen
                  Navigator.pop(context, {
                    'name': name,
                    'age': age,
                    'profileImage': isAssetImage ? profileImagePath : _imageFile!.path,
                    'isAssetImage': isAssetImage,
                  });
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
      ),
    );
  }
  
  Widget buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(icon, color: Colors.grey.shade700),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget buildAgeField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required VoidCallback onIconTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: GestureDetector(
                onTap: onIconTap,
                child: Icon(Icons.calendar_today, color: Colors.grey.shade700),
              ),
              suffixText: 'years',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ),
        if (selectedDate != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Text(
              'Birth date: ${DateFormat('MMM d, yyyy').format(selectedDate!)}',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey.shade700,
              ),
            ),
          ),
      ],
    );
  }
} 