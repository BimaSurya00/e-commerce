import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final bool isEnabled;
  final TextStyle? textStyle;
  final double? borderRadius;
  final Color? borderColor;
  final Color? textColor;

  const ReusableButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
    this.isEnabled = true,
    this.textStyle,
    this.borderRadius,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? backgroundColor : Colors.grey[400],
        disabledBackgroundColor: Colors.grey[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 24),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderColor != null ? 1.5 : 0,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          title,
          style:
              textStyle ??
              GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isEnabled
                    ? (textColor ?? Colors.white)
                    : Colors.grey[600],
              ),
        ),
      ),
    );
  }
}
