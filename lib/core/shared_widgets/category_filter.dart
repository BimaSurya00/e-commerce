import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Model for category item
class CategoryItem {
  final String id;
  final String label;
  final IconData? icon;

  const CategoryItem({
    required this.id,
    required this.label,
    this.icon,
  });
}

/// Horizontal scrollable category filter widget
/// 
/// Usage:
/// ```dart
/// CategoryFilter(
///   categories: [
///     CategoryItem(id: 'all', label: 'All'),
///     CategoryItem(id: 'men', label: 'Men'),
///     CategoryItem(id: 'women', label: 'Women'),
///   ],
///   selectedId: 'all',
///   onSelected: (category) {
///     print('Selected: ${category.label}');
///   },
/// )
/// ```
class CategoryFilter extends StatelessWidget {
  final List<CategoryItem> categories;
  final String selectedId;
  final ValueChanged<CategoryItem> onSelected;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double height;
  final double itemSpacing;
  final EdgeInsets padding;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    this.selectedColor,
    this.unselectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.height = 40,
    this.itemSpacing = 12,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: itemSpacing),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == selectedId;

          return _CategoryChip(
            category: category,
            isSelected: isSelected,
            onTap: () => onSelected(category),
            selectedColor: selectedColor ?? AppPallete.secondaryColor,
            unselectedColor: unselectedColor ?? Colors.white,
            selectedTextColor: selectedTextColor ?? Colors.white,
            unselectedTextColor: unselectedTextColor ?? AppPallete.secondaryColor,
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final CategoryItem category;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const _CategoryChip({
    required this.category,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selectedTextColor,
    required this.unselectedTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : unselectedColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selectedColor,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: selectedColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category.icon != null) ...[
              Icon(
                category.icon,
                size: 18,
                color: isSelected ? selectedTextColor : unselectedTextColor,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              category.label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? selectedTextColor : unselectedTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
