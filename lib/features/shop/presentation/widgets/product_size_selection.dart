import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductSizeSelection extends StatelessWidget {
  final List<String> sizes;
  final int selectedSizeIndex;
  final ValueChanged<int> onSizeSelected;
  final VoidCallback? onSizeGuidePressed;

  const ProductSizeSelection({
    super.key,
    required this.sizes,
    required this.selectedSizeIndex,
    required this.onSizeSelected,
    this.onSizeGuidePressed,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Size',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppPallete.secondaryColor,
                ),
              ),
              GestureDetector(
                onTap: onSizeGuidePressed,
                child: Text(
                  'Size Guide',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppPallete.secondaryColor.withOpacity(0.7),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              sizes.length,
              (index) => GestureDetector(
                onTap: () => onSizeSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: selectedSizeIndex == index
                        ? AppPallete.secondaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppPallete.secondaryColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      sizes[index],
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: selectedSizeIndex == index
                            ? Colors.white
                            : AppPallete.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
