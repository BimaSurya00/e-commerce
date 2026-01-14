import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:ecommerce/features/home/presentation/pages/home_page.dart';
import 'package:ecommerce/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BasePage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const BasePage({super.key, required this.navigationShell});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppPallete.secondaryColor, width: 2),
        ),
        child: GNav(
          selectedIndex: widget.navigationShell.currentIndex,
          onTabChange: (index) {
            // Gunakan goBranch untuk navigasi dengan StatefulShellRoute
            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
          },
          tabBackgroundColor: AppPallete.secondaryColor,
          activeColor: Colors.white,
          color: Colors.white,
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
              iconColor: Colors.black,
              leading: Image.asset(
                'assets/icons/home.webp',
                width: 24,
                color: widget.navigationShell.currentIndex == 0
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            GButton(
              icon: Icons.shopping_bag_outlined,
              text: 'Shop',
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
              iconColor: Colors.black,
              leading: Icon(
                Icons.shopping_bag_outlined,
                size: 24,
                color: widget.navigationShell.currentIndex == 1
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
              textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
              iconColor: Colors.black,
              leading: Icon(
                Icons.person_2_outlined,
                size: 24,
                color: widget.navigationShell.currentIndex == 2
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
