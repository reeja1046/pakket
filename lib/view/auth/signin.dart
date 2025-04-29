import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/services/auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.04,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * 0.1),

              // Logo
              SizedBox(
                height: height * 0.2,
                child: Image.asset('assets/pakket_logo.png'),
              ),

              SizedBox(height: height * 0.02),

              // Heading
              Text(
                'Existing User',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Please add your details',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: height * 0.04),

              // Mobile Number
              _buildTextField(
                hint: "Mobile number",
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your mobile number';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
                    return 'Enter a valid 10-digit number';
                  }
                  return null;
                },
              ),

              // Password
              _buildTextField(
                hint: "Password",
                controller: passwordController,
                isPassword: true,
                isPasswordVisible: _isPasswordVisible,
                onVisibilityToggle: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              SizedBox(height: height * 0.03),

              // Submit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.baseColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: height * 0.015),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    login(
                      phoneController.text.trim(),
                      passwordController.text.trim(),
                      context,
                    );
                  }
                },
                child: Text(
                  'SUBMIT NOW',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onVisibilityToggle,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? !isPasswordVisible : false,
        style: GoogleFonts.poppins(),
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(),
          filled: true,
          fillColor: Colors.grey[200],
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: onVisibilityToggle,
                )
              : null,
          border: _outlineBorder(),
          enabledBorder: _outlineBorder(),
          focusedBorder: _outlineBorder(width: 2.5),
        ),
      ),
    );
  }

  OutlineInputBorder _outlineBorder({double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: CustomColors.baseColor, width: width),
    );
  }
}
