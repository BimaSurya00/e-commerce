import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Model for cart summary data
class CartSummary {
  final double subtotal;
  final double? discount;
  final double shippingFee;
  final String? discountLabel;

  const CartSummary({
    required this.subtotal,
    this.discount,
    this.shippingFee = 0,
    this.discountLabel,
  });

  double get total => subtotal - (discount ?? 0) + shippingFee;
}

/// Widget displaying cart summary with subtotal, discount, shipping, and total
class CartSummarySection extends StatelessWidget {
  final CartSummary summary;

  const CartSummarySection({
    super.key,
    required this.summary,
  });

  String _formatPrice(double price) {
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
          Text(
            'Order Summary',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppPallete.secondaryColor,
            ),
          ),
          const SizedBox(height: 16),
          // Subtotal
          _buildSummaryRow(
            label: 'Subtotal',
            value: _formatPrice(summary.subtotal),
          ),
          const SizedBox(height: 10),
          // Discount (if any)
          if (summary.discount != null && summary.discount! > 0) ...[
            _buildSummaryRow(
              label: summary.discountLabel ?? 'Discount',
              value: '-${_formatPrice(summary.discount!)}',
              valueColor: Colors.green,
            ),
            const SizedBox(height: 10),
          ],
          // Shipping
          _buildSummaryRow(
            label: 'Shipping',
            value: summary.shippingFee > 0
                ? _formatPrice(summary.shippingFee)
                : 'Free',
            valueColor:
                summary.shippingFee > 0 ? null : Colors.green,
          ),
          const SizedBox(height: 12),
          // Divider
          Container(
            height: 1,
            color: AppPallete.secondaryColor.withOpacity(0.2),
          ),
          const SizedBox(height: 12),
          // Total
          _buildSummaryRow(
            label: 'Total',
            value: _formatPrice(summary.total),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal
                ? AppPallete.secondaryColor
                : AppPallete.secondaryColor.withOpacity(0.7),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: valueColor ??
                (isTotal ? AppPallete.primaryColor : AppPallete.secondaryColor),
          ),
        ),
      ],
    );
  }
}
