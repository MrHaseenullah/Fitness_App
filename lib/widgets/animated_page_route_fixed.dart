import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AnimatedPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final bool fadeIn;
  final bool slideFromRight;
  final bool slideFromBottom;
  final bool scale;

  AnimatedPageRoute({
    required this.page,
    RouteSettings? settings,
    this.fadeIn = true,
    this.slideFromRight = true,
    this.slideFromBottom = false,
    this.scale = false,
  }) : super(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: AppConstants.mediumAnimationDuration,
          reverseTransitionDuration: AppConstants.shortAnimationDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset.zero;
            var end = Offset.zero;
            
            if (slideFromRight) {
              begin = const Offset(1.0, 0.0);
            } else if (slideFromBottom) {
              begin = const Offset(0.0, 1.0);
            }
            
            const curve = Curves.easeInOut;
            final tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            final offsetAnimation = animation.drive(tween);
            
            final fadeAnimation = fadeIn
                ? Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
                    ),
                  )
                : null;
            
            final scaleAnimation = scale
                ? Tween<double>(begin: 0.9, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: curve,
                    ),
                  )
                : null;
            
            Widget transitionChild = SlideTransition(
              position: offsetAnimation,
              child: child,
            );
            
            if (fadeAnimation != null) {
              transitionChild = FadeTransition(
                opacity: fadeAnimation,
                child: transitionChild,
              );
            }
            
            if (scaleAnimation != null) {
              transitionChild = ScaleTransition(
                scale: scaleAnimation,
                child: transitionChild,
              );
            }
            
            return transitionChild;
          },
        );
}

// Extension method for Navigator
extension NavigatorExtension on BuildContext {
  Future<T?> pushAnimatedRoute<T extends Object?>(
    Widget page, {
    bool fadeIn = true,
    bool slideFromRight = true,
    bool slideFromBottom = false,
    bool scale = false,
    RouteSettings? settings,
  }) {
    return Navigator.of(this).push<T>(
      AnimatedPageRoute<T>(
        page: page,
        fadeIn: fadeIn,
        slideFromRight: slideFromRight,
        slideFromBottom: slideFromBottom,
        scale: scale,
        settings: settings,
      ),
    );
  }

  Future<T?> pushReplacementAnimatedRoute<T extends Object?, TO extends Object?>(
    Widget page, {
    bool fadeIn = true,
    bool slideFromRight = true,
    bool slideFromBottom = false,
    bool scale = false,
    RouteSettings? settings,
    TO? result,
  }) {
    return Navigator.of(this).pushReplacement<T, TO>(
      AnimatedPageRoute<T>(
        page: page,
        fadeIn: fadeIn,
        slideFromRight: slideFromRight,
        slideFromBottom: slideFromBottom,
        scale: scale,
        settings: settings,
      ),
      result: result,
    );
  }
}
