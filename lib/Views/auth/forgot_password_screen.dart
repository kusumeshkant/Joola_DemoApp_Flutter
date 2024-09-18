import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sampleapp/Views/auth/widgets/common_widgets.dart';
import 'package:sampleapp/Views/auth/widgets/text_input_field.dart';
import 'package:sampleapp/values/strings.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.forgetPassword)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.resetPassword,
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.h),
           const  TextinputField(labelText: Strings.enterNewPassword,),
            SizedBox(height: 40.h),
            customButton((){}, Strings.resetPassword)
           
          ],
        ),
      ),
    );
  }
}
