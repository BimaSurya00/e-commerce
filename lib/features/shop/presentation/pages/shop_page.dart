import 'package:ecommerce/core/shared_widgets/category_filter.dart';
import 'package:ecommerce/core/shared_widgets/product_grid.dart';
import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopPage extends StatefulWidget {
  static const routeName = 'shop-page';
  static const routePath = '/shop';
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _selectedCategoryId = 'all';
  
  final List<CategoryItem> _categories = const [
    CategoryItem(id: 'all', label: 'All'),
    CategoryItem(id: 'men', label: 'Men'),
    CategoryItem(id: 'women', label: 'Women'),
    CategoryItem(id: 'kids', label: 'Kids'),
    CategoryItem(id: 'accessories', label: 'Accessories'),
    CategoryItem(id: 'shoes', label: 'Shoes'),
  ];

  // Sample products data
  final List<ProductItem> _products = [
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
    const ProductItem(
      id: '5',
      name: 'Summer Floral Dress',
      price: 550000,
      originalPrice: 750000,
      rating: 4.6,
      reviewCount: 78,
      badge: 'SALE',
    ),
    const ProductItem(
      id: '6',
      name: 'Leather Belt Classic',
      price: 350000,
      rating: 4.4,
      reviewCount: 45,
    ),
    const ProductItem(
      id: '7',
      name: 'Sunglasses Aviator',
      price: 299000,
      rating: 4.7,
      reviewCount: 167,
      badge: 'NEW',
    ),
    const ProductItem(
      id: '8',
      name: 'Canvas Backpack',
      price: 425000,
      originalPrice: 550000,
      rating: 4.2,
      reviewCount: 93,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.thirdColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Page Title
                Text(
                  'Shop',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppPallete.secondaryColor,
                  ),
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
                                color: AppPallete.secondaryColor.withOpacity(0.5),
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
                const SizedBox(height: 20),

                // Categories section
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
                    Text(
                      '${_products.length} items',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.secondaryColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Category filter
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

                // Products Grid
                ProductGrid(
                  products: _products,
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
