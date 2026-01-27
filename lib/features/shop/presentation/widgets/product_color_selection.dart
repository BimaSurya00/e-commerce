import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductColorSelection extends StatelessWidget {
  final List<Color> colors;
  final int selectedColorIndex;
  final ValueChanged<int> onColorSelected;

  const ProductColorSelection({
    super.key,
    required this.colors,
    required this.selectedColorIndex,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPallete.secondaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppPallete.secondaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              colors.length,
              (index) => GestureDetector(
                onTap: () => onColorSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 12),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selectedColorIndex == index
                          ? AppPallete.secondaryColor
                          : Colors.grey[300]!,
                      width: 3,
                    ),
                    boxShadow: selectedColorIndex == index
                        ? [
                            BoxShadow(
                              color: colors[index].withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: selectedColorIndex == index
                      ? Icon(
                          Icons.check,
                          color: colors[index] == Colors.white
                              ? Colors.black
                              : Colors.white,
                          size: 20,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
