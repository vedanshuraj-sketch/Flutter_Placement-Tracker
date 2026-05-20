import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:placement_tracker/widgets/fragment_holder.dart';
import 'package:flutter_svg/flutter_svg.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Placement Tracker',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Poppins'),
      home: const SplashScreen(),
    );
  }
}

class AppColors {
  static const Color backgroundStart = Color(0xFF020617);
  static const Color backgroundEnd = Color(0xFF0F172A);
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color secondaryBlue = Color(0xFF1E40AF);
  static const Color glowColor = Color(0xFF60A5FA);
  static const Color textWhite = Colors.white;
  static const Color textGrey = Color(0xFF94A3B8);
  static const Color glassWhite = Color(0x33FFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _floatController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    );

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeController.forward();

    Future.delayed(const Duration(seconds: 4), _navigateToHome);
  }

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FragmentHolder()),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
          ),
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/splash_bg.svg',
                fit: BoxFit.cover,
              ),
            ),

            // Dark overlay for readability
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.35)),
            ),

            // Main Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    _buildHeader(),
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Transform.scale(
                              scale: 0.8 + (_fadeAnimation.value * 0.2),
                              child: child,
                            ),
                          );
                        },
                        child: _buildCenterContent(),
                      ),
                    ),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'PT • v1.0',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textGrey,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatAnimation.value),
              child: child,
            );
          },
          child: _buildGlassLogoContainer(),
        ),

        const SizedBox(height: 45),

        Text(
          'Track • Apply • Get Hired',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textGrey,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 60),
        _buildLoadingIndicator(),
      ],
    );
  }

  Widget _buildGlassLogoContainer() {
    // Shared corner radius handles crisp alignment for shadows, clip boundary, and borders
    const double containerRadius = 36.0;

    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(containerRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(containerRadius),
        child: 
        //BackdropFilter(
         // filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //child: 
          Container(
            // decoration: BoxDecoration(
            //   color: AppColors.glassWhite,
            //   border: Border.all(color: AppColors.glassBorder, width: 1.2),
            //   borderRadius: BorderRadius.circular(containerRadius),
            // ),
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              'assets/splash_image.png',
              fit: BoxFit.contain,
              //color: Colors.white,
            ),
          ),
        ),
      );
    //);
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: 35),
        const SizedBox(height: 16),
        Text(
          'Preparing opportunities...',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textGrey.withValues(alpha: 0.7),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        '© 2026 Placement Tracker',
        style: GoogleFonts.poppins(
          fontSize: 11,
          color: AppColors.textGrey.withValues(alpha: 0.5),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}