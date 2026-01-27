import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailProductAppBar extends StatelessWidget {
  final int cartItemCount;
  final VoidCallback? onCartTap;

  const DetailProductAppBar({
    super.key,
    this.cartItemCount = 0,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppPallete.secondaryColor, width: 2),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppPallete.secondaryColor,
                size: 20,
              ),
            ),
          ),

          Text(
            'Product Detail',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppPallete.secondaryColor,
            ),
          ),

          // Cart button
          GestureDetector(
            onTap: onCartTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppPallete.secondaryColor, width: 2),
              ),
              child: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: AppPallete.secondaryColor,
                    size: 20,
                  ),
                  if (cartItemCount > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            cartItemCount.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
