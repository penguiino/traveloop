// lib/widgets/custom_button.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double elevation;
  final double borderRadius; // Remove default value
  final Icon? icon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = primaryColor,
    this.textColor = Colors.white,
    this.elevation = 2.0,
    this.borderRadius = 8.0, // Provide a constant default value
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: color, // Text color
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      ),
      child: isLoading
          ? SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) icon!,
          if (icon != null) const SizedBox(width: 8.0),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
