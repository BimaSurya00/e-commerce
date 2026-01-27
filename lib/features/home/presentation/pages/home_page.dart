import 'package:ecommerce/core/shared_widgets/category_filter.dart';
import 'package:ecommerce/core/shared_widgets/product_grid.dart';
import 'package:ecommerce/core/shared_widgets/promo_carousel.dart';
import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home-page';
  static const routePath = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Selected category state
  String _selectedCategoryId = 'all';

  // Category list
  final List<CategoryItem> _categories = const [
    CategoryItem(id: 'all', label: 'All'),
    CategoryItem(id: 'men', label: 'Men'),
    CategoryItem(id: 'women', label: 'Women'),
    CategoryItem(id: 'kids', label: 'Kids'),
    CategoryItem(id: 'accessories', label: 'Accessories'),
    CategoryItem(id: 'shoes', label: 'Shoes'),
  ];

  // Promo/Banner list
  final List<PromoItem> _promoItems = [
    PromoItem(
      id: '1',
      title: 'Flash Sale! 🔥',
      subtitle: 'Up to 50% off on selected items',
      backgroundColor: AppPallete.primaryColor,
    ),
    PromoItem(
      id: '2',
      title: 'New Arrivals',
      subtitle: 'Check out the latest collection',
      backgroundColor: AppPallete.secondaryColor,
    ),
    PromoItem(
      id: '3',
      title: 'Free Shipping',
      subtitle: 'On orders above Rp 500.000',
      backgroundColor: const Color(0xFF2E7D32),
    ),
    PromoItem(
      id: '4',
      title: 'Member Exclusive',
      subtitle: 'Extra 10% off for members',
      backgroundColor: const Color(0xFFE65100),
    ),
  ];

  // Featured products
  final List<ProductItem> _featuredProducts = [
    const ProductItem(
      id: '1',
      name: 'Classic White Sneakers',
      price: 450000,
      originalPrice: 650000,
      rating: 4.8,
      reviewCount: 128,
      badge: 'SALE',
    ),
    const ProductItem(
      id: '2',
      name: 'Denim Jacket Premium',
      price: 850000,
      rating: 4.5,
      reviewCount: 89,
      badge: 'NEW',
    ),
    const ProductItem(
      id: '3',
      name: 'Casual Cotton T-Shirt',
      price: 199000,
      originalPrice: 299000,
      rating: 4.3,
      reviewCount: 256,
    ),
    const ProductItem(
      id: '4',
      name: 'Running Shoes Pro',
      price: 1250000,
      rating: 4.9,
      reviewCount: 512,
      isFavorite: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppPallete.thirdColor,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with greeting
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, John',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: AppPallete.secondaryColor,
                          ),
                        ),
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: AppPallete.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 32,
                          color: AppPallete.secondaryColor,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Search bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppPallete.secondaryColor,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: AppPallete.secondaryColor.withOpacity(0.5),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Search products...',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: AppPallete.secondaryColor.withOpacity(
                                  0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppPallete.secondaryColor,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        size: 28,
                        color: AppPallete.secondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Promo Carousel
                PromoCarousel(
                  items: _promoItems,
                  height: 160,
                  autoSlideDuration: const Duration(seconds: 4),
                  onItemTap: (item) {
                    debugPrint('Promo tapped: ${item.title}');
                  },
                ),
                const SizedBox(height: 24),

                // Categories section header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.secondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to all categories
                      },
                      child: Text(
                        'See All',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppPallete.secondaryColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Category Filter (horizontal scrollable)
                CategoryFilter(
                  categories: _categories,
                  selectedId: _selectedCategoryId,
                  onSelected: (category) {
                    setState(() {
                      _selectedCategoryId = category.id;
                    });
                    debugPrint('Selected category: ${category.label}');
                  },
                ),
                const SizedBox(height: 24),

                // Featured Products section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Featured Products',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppPallete.secondaryColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to all products
                      },
                      child: Text(
                        'See All',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppPallete.secondaryColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Product Grid
                ProductGrid(
                  products: _featuredProducts,
                  crossAxisCount: 2,
                  childAspectRatio: 0.62,
                  onProductTap: (product) {
                    context.go('/shop/detail/${product.id}');
                  },
                  onFavoriteTap: (product) {
                    debugPrint('Favorite tapped: ${product.name}');
                    // TODO: Toggle favorite
                  },
                  onAddToCart: (product) {
                    debugPrint('Add to cart: ${product.name}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart'),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
