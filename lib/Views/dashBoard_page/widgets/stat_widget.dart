import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatWidget extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? color;

 const StatWidget(
      {super.key, required this.icon,
      required this.value,
      required this.label,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14, left: 15),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 25.sp, color: color ?? Colors.deepPurple),
          SizedBox(width: 10.w),
          Column(
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.purple[400],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
