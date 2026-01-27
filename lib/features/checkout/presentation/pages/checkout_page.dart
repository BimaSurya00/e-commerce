import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_summary_section.dart';
import 'package:ecommerce/features/checkout/presentation/widgets/checkout_address_section.dart';
import 'package:ecommerce/features/checkout/presentation/widgets/checkout_order_items.dart';
import 'package:ecommerce/features/checkout/presentation/widgets/checkout_payment_method.dart';
import 'package:ecommerce/features/checkout/presentation/widgets/checkout_shipping_method.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutPage extends StatefulWidget {
  static const routeName = 'checkout-page';
  static const routePath = '/checkout';

  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Sample data
  final ShippingAddress _selectedAddress = const ShippingAddress(
    id: '1',
    name: 'John Doe',
    phone: '+62 812 3456 7890',
    address: 'Jl. Sudirman No. 123, Kav. 45',
    city: 'Jakarta Selatan',
    postalCode: '12190',
    isDefault: true,
  );

  final List<ShippingMethod> _shippingMethods = const [
    ShippingMethod(
      id: 'regular',
      name: 'Regular',
      description: 'Standard shipping',
      price: 15000,
      estimatedDays: '3-5 days',
      icon: Icons.local_shipping_outlined,
    ),
    ShippingMethod(
      id: 'express',
      name: 'Express',
      description: 'Fast delivery',
      price: 25000,
      estimatedDays: '1-2 days',
      icon: Icons.rocket_launch_outlined,
    ),
    ShippingMethod(
      id: 'sameday',
      name: 'Same Day',
      description: 'Delivered today',
      price: 40000,
      estimatedDays: 'Today',
      icon: Icons.flash_on_outlined,
    ),
  ];

  final List<PaymentMethod> _paymentMethods = const [
    PaymentMethod(
      id: 'bca',
      name: 'BCA',
      icon: Icons.account_balance,
      iconColor: Colors.blue,
    ),
    PaymentMethod(
      id: 'mandiri',
      name: 'Mandiri',
      icon: Icons.account_balance,
      iconColor: Colors.amber,
    ),
    PaymentMethod(
      id: 'gopay',
      name: 'GoPay',
      icon: Icons.wallet,
      iconColor: Colors.green,
    ),
    PaymentMethod(
      id: 'ovo',
      name: 'OVO',
      icon: Icons.wallet,
      iconColor: Colors.purple,
    ),
    PaymentMethod(
      id: 'shopeepay',
      name: 'ShopeePay',
      icon: Icons.wallet,
      iconColor: Colors.orange,
    ),
    PaymentMethod(
      id: 'cod',
      name: 'COD',
      icon: Icons.money,
      iconColor: Colors.teal,
    ),
  ];

  // Sample cart items
  final List<CartItem> _cartItems = const [
    CartItem(
      id: '1',
      productId: 'prod_1',
      name: 'Classic White Sneakers',
      price: 450000,
      originalPrice: 650000,
      quantity: 1,
      size: '42',
      color: 'White',
    ),
    CartItem(
      id: '2',
      productId: 'prod_2',
      name: 'Denim Jacket Premium',
      price: 850000,
      quantity: 2,
      size: 'L',
      color: 'Blue',
    ),
  ];

  String? _selectedShippingId = 'regular';
  String? _selectedPaymentId;
  bool _isPlacingOrder = false;

  double get _subtotal {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get _shippingFee {
    final method = _shippingMethods.firstWhere(
      (m) => m.id == _selectedShippingId,
      orElse: () => _shippingMethods.first,
    );
    return method.price;
  }

  double get _total => _subtotal + _shippingFee;

  String _formatPrice(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  void _placeOrder() {
    if (_selectedPaymentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select a payment method',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isPlacingOrder = true);

    // Simulate order placement
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isPlacingOrder = false);
      _showOrderSuccess();
    });
  }

  void _showOrderSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Order Placed!',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order has been placed successfully.\nThank you for shopping with us!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                context.go('/home');
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppPallete.secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Continue Shopping',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.thirdColor,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _buildAppBar(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Shipping Address
                      CheckoutAddressSection(
                        selectedAddress: _selectedAddress,
                        onChangeAddress: () {
                          // TODO: Show address selection
                        },
                      ),
                      const SizedBox(height: 16),
                      // Order Items
                      CheckoutOrderItems(
                        items: _cartItems,
                        onEditCart: () => context.go('/cart'),
                      ),
                      const SizedBox(height: 16),
                      // Shipping Method
                      CheckoutShippingMethod(
                        methods: _shippingMethods,
                        selectedMethodId: _selectedShippingId,
                        onMethodSelected: (method) {
                          setState(() => _selectedShippingId = method.id);
                        },
                      ),
                      const SizedBox(height: 16),
                      // Payment Method
                      CheckoutPaymentMethod(
                        methods: _paymentMethods,
                        selectedMethodId: _selectedPaymentId,
                        onMethodSelected: (method) {
                          setState(() => _selectedPaymentId = method.id);
                        },
                      ),
                      const SizedBox(height: 16),
                      // Order Summary
                      CartSummarySection(
                        summary: CartSummary(
                          subtotal: _subtotal,
                          shippingFee: _shippingFee,
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Place Order Button
      bottomNavigationBar: _buildPlaceOrderButton(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
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
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Checkout',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppPallete.secondaryColor,
              ),
            ),
          ),
          // Secure badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, color: Colors.green, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Secure',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppPallete.thirdColor.withOpacity(0),
            AppPallete.thirdColor,
          ],
        ),
      ),
      child: SafeArea(
        child: GestureDetector(
          onTap: _isPlacingOrder ? null : _placeOrder,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppPallete.primaryColor,
                  AppPallete.secondaryColor,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppPallete.secondaryColor.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: _isPlacingOrder
                ? const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Place Order',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _formatPrice(_total),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
