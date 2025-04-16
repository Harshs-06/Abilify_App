import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:abilify/utils/constants.dart';
import 'package:abilify/providers/profile_provider.dart';
import 'package:abilify/widgets/custom_text_field.dart';
import 'package:abilify/widgets/custom_button.dart';
import 'package:abilify/models/parent_profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // In a real app, you would call an authentication service
      // For now, we'll just save a parent profile
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      
      final parentProfile = ParentProfile(
        name: _nameController.text,
        email: _emailController.text,
        child: {
          'name': '',
          'age': 0,
          'needs': [],
        },
      );

      await profileProvider.saveParentProfile(parentProfile);
      await profileProvider.setCurrentProfileType(ProfileType.parent);

      // Navigate to the parent dashboard
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.parentDashboard);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating account: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E4), // Light cream background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                
                // Logo and App Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'abilify',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ],
                ),
                
                const SizedBox(height: 5),
                
                // Tagline
                Text(
                  kAppTagline,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Create Account Header
                Text(
                  'Create Your Account',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading2,
                ),
                
                const SizedBox(height: 8),
                
                // Subtitle
                Text(
                  'to access Abilify from anywhere',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Sign Up Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Name Field
                      CustomTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Email Field
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Simple email validation
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Password Field
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: true,
                        prefixIcon: Icons.lock_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Sign Up Button
                      CustomButton(
                        text: 'Sign Up',
                        onPressed: _submit,
                        isLoading: _isLoading,
                        backgroundColor: const Color(0xFFFF7A4D), // Orange button
                        height: 50,
                        borderRadius: 8,
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        // For demo purposes, just pretend to log in
                        final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
                        profileProvider.setCurrentProfileType(ProfileType.parent);
                        Navigator.pushReplacementNamed(context, AppRoutes.parentDashboard);
                      },
                      child: Text(
                        'Log in',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 