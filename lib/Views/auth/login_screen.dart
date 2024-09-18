import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampleapp/Views/auth/forgot_password_screen.dart';
import 'package:sampleapp/Views/auth/signup_screen.dart';
import 'package:sampleapp/Views/auth/widgets/common_widgets.dart';
import 'package:sampleapp/Views/auth/widgets/text_input_field.dart';
import 'package:sampleapp/Views/dashBoard_page/widgets/bottom_navigation.dart';
import 'package:sampleapp/values/strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    } else if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.login,
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.h),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextinputField(
                    labelText: Strings.userName,
                    controller: _usernameController,
                    validator: _validateUsername,
                  ),
                  SizedBox(height: 20.h),
                  TextinputField(
                    labelText: Strings.password,
                    obscureText: true,
                    controller: _passwordController,
                    validator: _validatePassword,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            customButton(() {
                if (_formKey.currentState!.validate()) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BottomNavBar(
                              userName: _usernameController.text,
                            )),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please Enter empty Field')),
                  );
                }
              },
             Strings.login),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const ForgotPasswordScreen()));
              },
              child: const Text(Strings.forgetPassword),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()));
              },
              child: const Text(Strings.dontHaveAnAccountSignUp),
            ),
          ],
        ),
      ),
    );
  }
}
