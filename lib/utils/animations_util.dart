import 'package:flutter/material.dart';

class AnimationUtils {
  // Animation duration in milliseconds
  static const int _transitionDuration = 500;

  /// Creates a route that slides from bottom to top
  static Route<T> createBottomToTopRoute<T>(Widget destination) {
    // Starting position (bottom of screen)
    final startOffset = Offset(0.0, 1.0);
    // Ending position (normal position)
    final endOffset = Offset.zero;
    
    return _buildAnimatedPageRoute(destination, startOffset, endOffset);
  }

  /// Creates a route that slides from top to bottom
  static Route<T> createTopToBottomRoute<T>(Widget destination) {
    // Starting from top of screen
    final startOffset = Offset(0.0, -1.0);
    // Ending at normal position
    final endOffset = Offset.zero;
    
    return _buildAnimatedPageRoute(destination, startOffset, endOffset);
  }

  /// Helper method to create animated page routes
  static Route<T> _buildAnimatedPageRoute<T>(
      Widget destination, Offset startPosition, Offset endPosition) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: _transitionDuration),
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Create tween for position animation with easing
        var positionTween = Tween(begin: startPosition, end: endPosition)
            .chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(positionTween),
          child: child,
        );
      },
    );
  }

  /// Creates a modal sheet that appears from the top
  static Route<T> createTopSheetRoute<T>(Widget content,
      {double heightPercent = 0.5}) {
    return PageRouteBuilder<T>(
      opaque: false,
      transitionDuration: Duration(milliseconds: _transitionDuration),
      pageBuilder: (context, animation, secondaryAnimation) {
        return GestureDetector(
          // Dismiss when tapping outside
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Align(
              alignment: Alignment.topCenter,
              child: FractionallySizedBox(
                widthFactor: 1.0,
                heightFactor: heightPercent,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20)
                  ),
                  child: content,
                ),
              ),
            ),
          ),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var slideAnimation = Tween(
          begin: const Offset(0, -1),
          end: Offset.zero
        ).chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(slideAnimation),
          child: child,
        );
      },
    );
  }
}