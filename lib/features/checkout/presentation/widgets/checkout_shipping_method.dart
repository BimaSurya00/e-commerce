import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Model for shipping method option
class ShippingMethod {
  final String id;
  final String name;
  final String description;
  final double price;
  final String estimatedDays;
  final IconData icon;

  const ShippingMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.estimatedDays,
    this.icon = Icons.local_shipping_outlined,
  });
}

/// Widget for selecting shipping method
class CheckoutShippingMethod extends StatelessWidget {
  final List<ShippingMethod> methods;
  final String? selectedMethodId;
  final void Function(ShippingMethod) onMethodSelected;

  const CheckoutShippingMethod({
    super.key,
    required this.methods,
    this.selectedMethodId,
    required this.onMethodSelected,
  });

  String _formatPrice(double price) {
    if (price == 0) return 'Free';
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

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
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppPallete.secondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.local_shipping_outlined,
                  color: AppPallete.secondaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Shipping Method',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppPallete.secondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Shipping options
          ...methods.map((method) => _buildMethodOption(method)),
        ],
      ),
    );
  }

  Widget _buildMethodOption(ShippingMethod method) {
    final isSelected = selectedMethodId == method.id;
    return GestureDetector(
      onTap: () => onMethodSelected(method),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppPallete.secondaryColor.withOpacity(0.08)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppPallete.secondaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio indicator
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppPallete.secondaryColor : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppPallete.secondaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            // Icon
            Icon(
              method.icon,
              color: isSelected ? AppPallete.secondaryColor : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(width: 12),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.name,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppPallete.secondaryColor : Colors.black87,
                    ),
                  ),
                  Text(
                    '${method.description} • ${method.estimatedDays}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Price
            Text(
              _formatPrice(method.price),
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: method.price == 0 ? Colors.green : AppPallete.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
