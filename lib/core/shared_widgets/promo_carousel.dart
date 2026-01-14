import 'dart:async';
import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Model for promo/banner item
class PromoItem {
  final String id;
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const PromoItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.backgroundColor,
    this.textColor,
    this.onTap,
  });
}

/// Auto-sliding promo carousel with page indicators
/// 
/// Usage:
/// ```dart
/// PromoCarousel(
///   items: [
///     PromoItem(id: '1', title: 'Flash Sale!', subtitle: 'Up to 50% off'),
///     PromoItem(id: '2', title: 'New Arrivals', subtitle: 'Check out now'),
///   ],
///   onItemTap: (item) => print('Tapped: ${item.title}'),
/// )
/// ```
class PromoCarousel extends StatefulWidget {
  final List<PromoItem> items;
  final double height;
  final Duration autoSlideDuration;
  final bool autoSlide;
  final ValueChanged<PromoItem>? onItemTap;
  final EdgeInsets padding;
  final double borderRadius;

  const PromoCarousel({
    super.key,
    required this.items,
    this.height = 160,
    this.autoSlideDuration = const Duration(seconds: 4),
    this.autoSlide = true,
    this.onItemTap,
    this.padding = EdgeInsets.zero,
    this.borderRadius = 16,
  });

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    if (widget.autoSlide && widget.items.length > 1) {
      _startAutoSlide();
    }
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(widget.autoSlideDuration, (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentPage + 1) % widget.items.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _PromoCard(
                  item: item,
                  borderRadius: widget.borderRadius,
                  onTap: () {
                    item.onTap?.call();
                    widget.onItemTap?.call(item);
                  },
                ),
              );
            },
          ),
        ),
        if (widget.items.length > 1) ...[
          const SizedBox(height: 12),
          _PageIndicators(
            count: widget.items.length,
            currentIndex: _currentPage,
          ),
        ],
      ],
    );
  }
}

class _PromoCard extends StatelessWidget {
  final PromoItem item;
  final double borderRadius;
  final VoidCallback? onTap;

  const _PromoCard({
    required this.item,
    required this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              item.backgroundColor ?? AppPallete.primaryColor,
              item.backgroundColor?.withOpacity(0.7) ?? 
                  AppPallete.secondaryColor,
            ],
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: (item.backgroundColor ?? AppPallete.primaryColor)
                  .withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern/decoration
            Positioned(
              right: -20,
              bottom: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              right: 30,
              top: -30,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: item.textColor ?? Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle!,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: (item.textColor ?? Colors.white).withOpacity(0.9),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Shop Now',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: item.backgroundColor ?? AppPallete.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageIndicators extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _PageIndicators({
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive 
                ? AppPallete.secondaryColor 
                : AppPallete.secondaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
