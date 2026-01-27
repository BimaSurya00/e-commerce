import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_empty_state.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_promo_input.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_summary_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  static const routeName = 'cart-page';
  static const routePath = '/cart';

  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Sample cart data
  final List<CartItem> _cartItems = [
    const CartItem(
      id: '1',
      productId: 'prod_1',
      name: 'Classic White Sneakers',
      price: 450000,
      originalPrice: 650000,
      quantity: 1,
      size: '42',
      color: 'White',
    ),
    const CartItem(
      id: '2',
      productId: 'prod_2',
      name: 'Denim Jacket Premium',
      price: 850000,
      quantity: 2,
      size: 'L',
      color: 'Blue',
    ),
    const CartItem(
      id: '3',
      productId: 'prod_3',
      name: 'Casual Cotton T-Shirt',
      price: 199000,
      originalPrice: 299000,
      quantity: 1,
      size: 'M',
    ),
  ];

  String? _appliedPromoCode;
  double _discount = 0;
  bool _isApplyingPromo = false;

  double get _subtotal {
    return _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void _updateQuantity(String itemId, int newQuantity) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.id == itemId);
      if (index != -1) {
        final oldItem = _cartItems[index];
        _cartItems[index] = CartItem(
          id: oldItem.id,
          productId: oldItem.productId,
          name: oldItem.name,
          imageUrl: oldItem.imageUrl,
          price: oldItem.price,
          originalPrice: oldItem.originalPrice,
          quantity: newQuantity,
          size: oldItem.size,
          color: oldItem.color,
        );
      }
    });
  }

  void _removeItem(String itemId) {
    setState(() {
      _cartItems.removeWhere((item) => item.id == itemId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Item removed from cart',
          style: GoogleFonts.poppins(),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // TODO: Implement undo
          },
        ),
      ),
    );
  }

  void _applyPromoCode(String code) {
    setState(() {
      _isApplyingPromo = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isApplyingPromo = false;
        if (code.toUpperCase() == 'SAVE20') {
          _appliedPromoCode = code.toUpperCase();
          _discount = _subtotal * 0.2; // 20% discount
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Promo code applied! 20% discount',
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Invalid promo code',
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    });
  }

  void _removePromoCode() {
    setState(() {
      _appliedPromoCode = null;
      _discount = 0;
    });
  }

  void _clearCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear Cart',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to remove all items from your cart?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cartItems.clear();
                _appliedPromoCode = null;
                _discount = 0;
              });
              Navigator.pop(context);
            },
            child: Text(
              'Clear',
              style: GoogleFonts.poppins(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Proceeding to checkout...',
          style: GoogleFonts.poppins(),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
    // TODO: Navigate to checkout page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.thirdColor,
      body: SafeArea(
        child: _cartItems.isEmpty
            ? CartEmptyState(
                onContinueShopping: () {
                  context.go('/shop');
                },
              )
            : Column(
                children: [
                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            _buildHeader(),
                            const SizedBox(height: 20),
                            // Cart items
                            _buildCartItemsList(),
                            const SizedBox(height: 20),
                            // Promo code
                            CartPromoInput(
                              appliedPromoCode: _appliedPromoCode,
                              onApply: _applyPromoCode,
                              onRemove: _removePromoCode,
                              isLoading: _isApplyingPromo,
                            ),
                            const SizedBox(height: 16),
                            // Order summary
                            CartSummarySection(
                              summary: CartSummary(
                                subtotal: _subtotal,
                                discount: _discount,
                                discountLabel: _appliedPromoCode != null
                                    ? 'Promo ($_appliedPromoCode)'
                                    : null,
                                shippingFee: 0, // Free shipping
                              ),
                            ),
                            const SizedBox(height: 100), // Space for bottom bar
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      // Checkout button
      bottomNavigationBar: _cartItems.isEmpty ? null : _buildCheckoutButton(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Cart',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppPallete.secondaryColor,
              ),
            ),
            Text(
              '${_cartItems.length} item${_cartItems.length > 1 ? 's' : ''}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppPallete.secondaryColor.withOpacity(0.7),
              ),
            ),
          ],
        ),
        // Clear cart button
        GestureDetector(
          onTap: _clearCart,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppPallete.secondaryColor,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.delete_sweep_outlined,
              color: AppPallete.secondaryColor,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItemsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _cartItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        return CartItemCard(
          item: item,
          onQuantityChanged: (quantity) => _updateQuantity(item.id, quantity),
          onDelete: () => _removeItem(item.id),
          onTap: () {
            context.go('/shop/detail/${item.productId}');
          },
        );
      },
    );
  }

  Widget _buildCheckoutButton() {
    final total = _subtotal - _discount;
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
          onTap: () => context.push('/checkout'),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  'Checkout',
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
                    _formatPrice(total),
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

  String _formatPrice(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
}
