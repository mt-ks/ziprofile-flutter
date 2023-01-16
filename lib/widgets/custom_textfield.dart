import 'package:flutter/material.dart';

import '../icons/nav_icons.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.obscureText = false,
    this.icon = NavIcons.search_icon,
  });
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.none,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(
          this.icon,
          size: 19,
        ),
        prefixIconColor: Colors.white,
        fillColor: Color.fromARGB(255, 24, 24, 24),
        filled: true,
        hintText: this.hintText,
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      autocorrect: false,
      obscureText: this.obscureText,
    );
  }
}
