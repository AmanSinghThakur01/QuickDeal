import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {

final TextEditingController controller;

final String hintText;

final TextInputType keyboardType;

const CustomTextField({
super.key,
required this.controller,
required this.hintText,
this.keyboardType = TextInputType.text,
});

@override
Widget build(BuildContext context) {

return TextField(

controller: controller,

keyboardType: keyboardType,

decoration: InputDecoration(

hintText: hintText,

filled: true,

fillColor: Colors.white,

contentPadding:
const EdgeInsets.symmetric(
horizontal: 18,
vertical: 16,
),

border: OutlineInputBorder(

borderRadius:
BorderRadius.circular(14),

borderSide: BorderSide.none,
),
),
);
}
}

