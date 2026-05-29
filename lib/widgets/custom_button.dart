import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {

final String title;

final VoidCallback onTap;

final bool isLoading;

const CustomButton({
super.key,
required this.title,
required this.onTap,
this.isLoading = false,
});

@override
Widget build(BuildContext context) {

return SizedBox(

width: double.infinity,
height: 55,

child: ElevatedButton(

onPressed: isLoading
? null
    : onTap,

style: ElevatedButton.styleFrom(

backgroundColor:
AppColors.primary,

shape: RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(14),
),
),

child: isLoading

? const SizedBox(
height: 22,
width: 22,

child:
CircularProgressIndicator(
color: Colors.white,
strokeWidth: 2.5,
),
)

    : Text(

title,

style: const TextStyle(
fontSize: 16,
fontWeight: FontWeight.w600,
color: Colors.white,
),
),
),
);
}
}
