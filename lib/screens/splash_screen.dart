import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppColors {
  static const background = Color(0xFF0F172A);

  static const primary = Color(0xFF3B82F6);

  static const card = Color(0xFF1E293B);

  static const textPrimary = Colors.white;

  static const textSecondary = Colors.white70;
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F172A),
              Color(0xFF1E3A8A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: Column(
              children: [

                /// Top Right Logo Text
                const Align(
                  alignment: Alignment.topRight,

                  child: Padding(
                    padding: EdgeInsets.only(top: 12),

                    child: Text(
                      'PT • v1.0',

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                /// Main Content
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      /// Animated Logo
                      TweenAnimationBuilder(
                        tween: Tween<double>(
                          begin: 0.7,
                          end: 1,
                        ),

                        duration: const Duration(seconds: 2),

                        curve: Curves.easeOut,

                        builder: (context, value, child) {

                          return Transform.scale(
                            scale: value,

                            child: Opacity(
                              opacity: value,
                              child: child,
                            ),
                          );
                        },

                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.15),
                                blurRadius: 30,
                                spreadRadius: 3,
                              ),
                            ],
                          ),

                          child: Image.asset(
                            'assets/splash_image.png',
                            width: 190,
                            height: 190,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      /// App Name
                      Text(
                        'Placement Tracker',

                        textAlign: TextAlign.center,

                        style: GoogleFonts.poppins(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Tagline
                      Text(
                        'Track • Apply • Get Hired',

                        textAlign: TextAlign.center,

                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white70,
                          letterSpacing: 0.5,
                        ),
                      ),

                      const SizedBox(height: 55),

                      /// Premium Loading Section
                      Column(
                        children: [

                          LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.white,
                            size: 42,
                          ),

                          const SizedBox(height: 18),

                          Text(
                            'Preparing opportunities...',

                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// Bottom Footer
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),

                  child: Text(
                    '© 2026 Placement Tracker',

                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                      letterSpacing: 0.5,
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