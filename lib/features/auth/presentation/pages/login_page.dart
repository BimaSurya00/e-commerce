import 'package:ecommerce/core/shared_widgets/reusable_button.dart';
import 'package:ecommerce/core/shared_widgets/reusable_text_field.dart';
import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:ecommerce/features/auth/presentation/pages/register_page.dart';
import 'package:ecommerce/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login-page';
  static const routePath = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppPallete.thirdColor,
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          width: 350,
          height: 450,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppPallete.secondaryColor, width: 2),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppPallete.secondaryColor,
                ),
              ),
              Text(
                'Welcome back! Please enter your details.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppPallete.secondaryColor,
                ),
              ),
              SizedBox(height: 32),
              ReusableTextField(label: 'Email', hintText: 'Input your email'),
              SizedBox(height: 16),
              ReusableTextField(
                label: 'Password',
                hintText: 'Input your password',
                obscureText: true,
                suffixIcon: Icon(Icons.visibility_off),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ReusableButton(
                  title: 'Login',
                  onPressed: () {
                    context.go(HomePage.routePath);
                  },
                  backgroundColor: AppPallete.secondaryColor,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go(RegisterPage.routePath);
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppPallete.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
