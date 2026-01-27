import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductTitleSection extends StatelessWidget {
  final String title;
  final double rating;
  final int reviewCount;
  final String? badge;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const ProductTitleSection({
    super.key,
    required this.title,
    required this.rating,
    required this.reviewCount,
    this.badge,
    required this.isFavorite,
    required this.onFavoriteTap,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge!,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (badge != null) const SizedBox(height: 8),

                // Title
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppPallete.secondaryColor,
                  ),
                ),
                const SizedBox(height: 8),

                // Rating
                Row(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Icon(
                        index < rating.floor() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      rating.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.secondaryColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '($reviewCount reviews)',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppPallete.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Favorite button
          GestureDetector(
            onTap: onFavoriteTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isFavorite ? Colors.red : AppPallete.secondaryColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isFavorite ? Colors.red : AppPallete.secondaryColor,
                  width: 1,
                ),
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : AppPallete.secondaryColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
