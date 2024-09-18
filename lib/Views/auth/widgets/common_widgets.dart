import 'package:flutter/material.dart';





//////////   Custom Button   ////////////

Widget customButton(void Function()? onPressed, String lable) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(lable),
  );
}





