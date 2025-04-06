import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.longAnimationDuration,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.05), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.05, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Navigate to the sign-in screen
        Navigator.pushReplacementNamed(context, '/sign_in');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : theme.colorScheme.surface,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fitness_background.jpg'),
            fit: BoxFit.cover,
            // alignment: Alignment.centerRight,
            alignment: Alignment(0.5, 0.0),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(102), // 0.4 opacity
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeInAnimation,
                  child: Transform.scale(
                    scale: _scaleAnimation.value * _pulseAnimation.value,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Welcome Text
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Welcome to',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 32,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Colors.black.withAlpha(150),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // App Name
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Fitness App',
                              style: theme.textTheme.displayLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 48,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(2.0, 2.0),
                                    blurRadius: 4.0,
                                    color: Colors.black.withAlpha(180),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
