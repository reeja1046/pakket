import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pakket/const/color.dart';
import 'package:pakket/view/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signUp(String name, String email, String password, String phone,
    String dob, context) async {
  const url = 'https://pakket-dev.vercel.app/api/app/register';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'dob': dob,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print("Signup successful: ${response.body}");
    _showBlurDialog(context);
  } else {
    print("Signup failed: ${response.body}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Signup failed')),
    );
  }
}

void _showBlurDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavScreen()),
        );
      });

      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CustomColors.baseColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: CustomColors.baseColor,
                      child: const Icon(Icons.check,
                          color: Colors.white, size: 35),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Account created\nsuccessfully!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'You have successfully created\nan account with us! Get ready for a great\nshopping experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> login(String phone, String password, BuildContext context) async {
  const url = 'https://pakket-dev.vercel.app/api/app/login';

  final body = {
    "phone": phone.trim(),
    "password": password.trim(),
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);
    print("Login response: $data");
    print("Status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      final token = data['token'];
      if (token != null) {
        // ✅ Save token
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        print("Token saved: $token");

        // ✅ Navigate to Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Token not found in response")),
        );
      }
    } else {
      // ❌ Show detailed error
      String errorMessage = data['message'] ?? 'Login failed';

      if (data['error'] != null && data['error'] is List) {
        errorMessage += "\n• " + (data['error'] as List).join("\n• ");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  } catch (e) {
    print("Login error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("An error occurred. Please try again.")),
    );
  }
}
