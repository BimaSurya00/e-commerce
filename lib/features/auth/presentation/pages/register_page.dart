import 'package:ecommerce/core/shared_widgets/reusable_button.dart';
import 'package:ecommerce/core/shared_widgets/reusable_text_field.dart';
import 'package:ecommerce/core/themes/app_pallete.dart';
import 'package:ecommerce/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register-page';
  static const routePath = '/register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.thirdColor,
      body: Center(
        child: Container(
          width: 350,
          height: 550,
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
                'Sign Up',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppPallete.secondaryColor,
                ),
              ),
              Text(
                'Create a new account by filling in the details below.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppPallete.secondaryColor,
                ),
              ),

              SizedBox(height: 30),
              ReusableTextField(
                label: 'Full Name',
                hintText: 'Input your full name',
              ),
              SizedBox(height: 16),
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
                  title: 'Register',
                  onPressed: () {},
                  backgroundColor: AppPallete.secondaryColor,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      context.go(LoginPage.routePath);
                    },
                    child: Text(
                      'Sign In',
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
