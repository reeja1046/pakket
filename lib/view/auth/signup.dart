import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/view/auth/signin.dart';
import 'package:pakket/services/auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isConfirmPasswordVisible = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.04),
        child: Column(
          children: [
            SizedBox(height: height * 0.02),
            SizedBox(height: height * 0.1, child: Image.asset('assets/pakket_logo.png')),
            SizedBox(height: height * 0.015),
            const Text('Create New Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text(
              'Set up your username and password.You\ncan always change it later.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            SizedBox(height: height * 0.015),

            // Wrap ListView in a Form
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildTextField(
                      hint: "Your Name",
                      controller: nameController,
                      validator: (value) =>
                          value!.isEmpty ? "Name cannot be empty" : null,
                    ),
                    _buildTextField(
                      hint: "Your email id",
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) return "Email cannot be empty";
                        if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      hint: "Mobile number",
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) return "Phone cannot be empty";
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return "Enter a valid 10-digit phone number";
                        }
                        return null;
                      },
                    ),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          String formattedDob = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                          setState(() {
                            dobController.text = formattedDob;
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: _buildTextField(
                          hint: "Date of Birth",
                          controller: dobController,
                          validator: (value) =>
                              value!.isEmpty ? "Please select your date of birth" : null,
                        ),
                      ),
                    ),
                    _buildTextField(
                      hint: "Password",
                      controller: passwordController,
                      isPassword: true,
                      isPasswordVisible: _isConfirmPasswordVisible,
                      onVisibilityToggle: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) return "Password cannot be empty";
                        if (value.length < 6) return "Password must be at least 6 characters";
                        return null;
                      },
                    ),

                    SizedBox(height: height * 0.025),

                    // Submit Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.baseColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: height * 0.018),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUp(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            phoneController.text.trim(),
                            dobController.text.trim(),
                            context,
                          );
                        }
                      },
                      child: const Text(
                        'SUBMIT NOW',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),

                    SizedBox(height: height * 0.06),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: const TextStyle(fontSize: 14, color: Color(0xFF141111)),
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.baseColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignInScreen()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated buildTextField with validator
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
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
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
