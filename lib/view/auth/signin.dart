import 'package:flutter/material.dart';
import 'package:pakket/const/color.dart';
import 'package:pakket/view/bottomnav.dart';
import 'package:pakket/services/auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.04),
        child: Column(
          children: [
            SizedBox(height: height * 0.15),
            // Logo
            SizedBox(
              height: height * 0.2,
              child: Image.asset('assets/pakket_logo.png'),
            ),
            SizedBox(height: height * 0.015),

            // Heading
            const Text(
              'Existing User',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const Text(
              'Please add your details',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            SizedBox(height: height * 0.04),
            // Form fields
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildTextField(
                      hint: "Phone number", controller: phoneController),
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
                      print(phoneController.text);
                      print(passwordController.text);
                      login(
                        phoneController.text,
                        passwordController.text,
                        context,
                      );
                    },
                    child: const Text(
                      'SUBMIT NOW',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Responsive Text Field
  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onVisibilityToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? !isPasswordVisible : false,
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
