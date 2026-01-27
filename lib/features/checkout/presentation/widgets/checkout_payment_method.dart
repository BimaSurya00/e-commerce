import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Model for payment method
class PaymentMethod {
  final String id;
  final String name;
  final String? description;
  final IconData icon;
  final Color? iconColor;

  const PaymentMethod({
    required this.id,
    required this.name,
    this.description,
    required this.icon,
    this.iconColor,
  });
}

/// Widget for selecting payment method
class CheckoutPaymentMethod extends StatelessWidget {
  final List<PaymentMethod> methods;
  final String? selectedMethodId;
  final void Function(PaymentMethod) onMethodSelected;

  const CheckoutPaymentMethod({
    super.key,
    required this.methods,
    this.selectedMethodId,
    required this.onMethodSelected,
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
                  Icons.payment_outlined,
                  color: AppPallete.secondaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Payment Method',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppPallete.secondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Payment options grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: methods.length,
            itemBuilder: (context, index) => _buildPaymentOption(methods[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(PaymentMethod method) {
    final isSelected = selectedMethodId == method.id;
    return GestureDetector(
      onTap: () => onMethodSelected(method),
      child: Container(
        padding: const EdgeInsets.all(12),
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
            // Check indicator
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppPallete.secondaryColor : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppPallete.secondaryColor : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 10),
            // Icon
            Icon(
              method.icon,
              color: method.iconColor ?? (isSelected ? AppPallete.secondaryColor : Colors.grey[600]),
              size: 22,
            ),
            const SizedBox(width: 8),
            // Name
            Expanded(
              child: Text(
                method.name,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppPallete.secondaryColor : Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
