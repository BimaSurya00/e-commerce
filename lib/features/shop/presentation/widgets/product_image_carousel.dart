import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';

class ProductImageCarousel extends StatelessWidget {
  final List<String> productImages;
  final int currentImageIndex;
  final ValueChanged<int> onPageChanged;

  const ProductImageCarousel({
    super.key,
    required this.productImages,
    required this.currentImageIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),  
        border: Border.all(color: AppPallete.secondaryColor, width: 2),
      ),
      child: Column(
        children: [
          // Main Image
          Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: PageView.builder(
              itemCount: productImages.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                  ),
                );
              },
            ),
          ),

          // Image Indicators
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                productImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentImageIndex == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentImageIndex == index
                        ? AppPallete.secondaryColor
                        : AppPallete.secondaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
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
