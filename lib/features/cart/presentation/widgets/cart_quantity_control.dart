import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Compact quantity control widget for cart items
class CartQuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final double buttonSize;

  const CartQuantityControl({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    this.buttonSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppPallete.secondaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement button
          _buildButton(
            icon: Icons.remove,
            onTap: onDecrement,
            isEnabled: quantity > 1,
          ),
          // Quantity display
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              quantity.toString(),
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppPallete.secondaryColor,
              ),
            ),
          ),
          // Increment button
          _buildButton(
            icon: Icons.add,
            onTap: onIncrement,
            isEnabled: true,
            isHighlighted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isEnabled,
    bool isHighlighted = false,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: isHighlighted
              ? AppPallete.secondaryColor
              : (isEnabled
                  ? AppPallete.secondaryColor.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isHighlighted
              ? Colors.white
              : (isEnabled ? AppPallete.secondaryColor : Colors.grey),
        ),
      ),
    );
  }
}
