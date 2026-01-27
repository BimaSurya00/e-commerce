import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:ecommerce/features/shop/presentation/widgets/detail_product_app_bar.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_bottom_bar.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_color_selection.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_description_section.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_image_carousel.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_price_section.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_quantity_section.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_reviews_section.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_size_selection.dart';
import 'package:ecommerce/features/shop/presentation/widgets/product_title_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailProductPage extends StatefulWidget {
  static const routeName = 'detail-product-page';
  static const routePath = 'detail/:productId';

  final String productId;

  const DetailProductPage({super.key, required this.productId});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int _currentImageIndex = 0;
  int _selectedSizeIndex = 1;
  int _selectedColorIndex = 0;
  int _quantity = 1;
  bool _isFavorite = false;
  int _cartItemCount = 3;

  // Sample product images
  final List<String> _productImages = [
    'https://via.placeholder.com/400x400/E8E8E8/333333?text=Image+1',
    'https://via.placeholder.com/400x400/D8D8D8/333333?text=Image+2',
    'https://via.placeholder.com/400x400/C8C8C8/333333?text=Image+3',
    'https://via.placeholder.com/400x400/B8B8B8/333333?text=Image+4',
  ];

  // Sample sizes
  final List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL'];

  // Sample colors
  final List<Color> _colors = [
    Colors.black,
    Colors.white,
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  // Sample reviews
  final List<Map<String, dynamic>> _reviews = [
    {
      'name': 'Sarah M.',
      'rating': 5,
      'date': '2 days ago',
      'comment':
          'Great quality! Fits perfectly and the material is very comfortable.',
      'avatar': 'SM',
    },
    {
      'name': 'John D.',
      'rating': 4,
      'date': '1 week ago',
      'comment': 'Nice product, fast delivery. Would buy again!',
      'avatar': 'JD',
    },
  ];

  void _addToCart() {
    setState(() {
      _cartItemCount += _quantity;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Added $_quantity item(s) to cart',
                style: GoogleFonts.poppins(),
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                context.push('/cart');
              },
              child: Text(
                'View Cart',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _buyNow() {
    // Navigate directly to checkout
    context.push('/checkout');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.thirdColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            DetailProductAppBar(
              cartItemCount: _cartItemCount,
              onCartTap: () {
                context.push('/cart');
              },
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Images
                    ProductImageCarousel(
                      productImages: _productImages,
                      currentImageIndex: _currentImageIndex,
                      onPageChanged: (index) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),

                    // Product Info
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Favorite
                          ProductTitleSection(
                            title: 'Classic White Sneakers Premium Edition',
                            rating: 4.8,
                            reviewCount: 128,
                            badge: 'SALE',
                            isFavorite: _isFavorite,
                            onFavoriteTap: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                              });
                            },
                          ),
                          const SizedBox(height: 16),

                          // Price Section
                          const ProductPriceSection(
                            originalPrice: 'Rp 650.000',
                            discountedPrice: 'Rp 450.000',
                            discountPercentage: '-30%',
                            hasFreeShipping: true,
                          ),
                          const SizedBox(height: 20),

                          // Size Selection
                          ProductSizeSelection(
                            sizes: _sizes,
                            selectedSizeIndex: _selectedSizeIndex,
                            onSizeSelected: (index) {
                              setState(() {
                                _selectedSizeIndex = index;
                              });
                            },
                            onSizeGuidePressed: () {
                              // Show size guide
                            },
                          ),
                          const SizedBox(height: 20),

                          // Color Selection
                          ProductColorSelection(
                            colors: _colors,
                            selectedColorIndex: _selectedColorIndex,
                            onColorSelected: (index) {
                              setState(() {
                                _selectedColorIndex = index;
                              });
                            },
                          ),
                          const SizedBox(height: 20),

                          // Quantity
                          ProductQuantitySection(
                            quantity: _quantity,
                            onDecrement: () {
                              if (_quantity > 1) {
                                setState(() {
                                  _quantity--;
                                });
                              }
                            },
                            onIncrement: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                          ),
                          const SizedBox(height: 24),

                          // Description
                          const ProductDescriptionSection(
                            description:
                                'Premium quality sneakers made with genuine leather and breathable mesh fabric. '
                                'Features a cushioned insole for all-day comfort and durable rubber outsole for excellent traction. '
                                'Perfect for casual wear or light sports activities.',
                            features: [
                              'Genuine Leather',
                              'Breathable',
                              'Comfortable',
                              'Durable',
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Reviews
                          ProductReviewsSection(
                            reviews: _reviews,
                            onSeeAllPressed: () {
                              // Navigate to all reviews
                            },
                          ),
                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Bar with Add to Cart and Buy Now
      bottomNavigationBar: ProductBottomBar(
        onAddToCart: _addToCart,
        onBuyNow: _buyNow,
      ),
    );
  }
}
