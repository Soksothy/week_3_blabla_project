import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// A costomizable button widget
///
/// This button have a few types:
/// - Primary: filled and Secondary: outlined
/// - With or without icon
/// - Enabled or disabled
/// - Costom size

class BlaButton extends StatelessWidget {
  /// the text to display on the button
  final String text;

  /// If this is primary is true or secondary is false
  final bool isPrimary;

  /// Optional icon to display before the text
  final IconData? icon;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// If this is enabled is true the button is enabled or disabled is false
  final bool isEnabled;

  /// Costom button width
  final double? width;

  /// Costom button height
  final double? height;

  const BlaButton({
    super.key,
    required this.text,
    this.isPrimary = true,
    this.icon,
    this.onPressed,
    this.isEnabled = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Button styling based on primary / secondary and enabled / disabled
    final Color backgroundColor = isPrimary
        ? isEnabled
            ? BlaColors.primary
            : BlaColors.greyLight
        : Colors.transparent;

    final Color textColor = isPrimary
        ? BlaColors.white
        : isEnabled
            ? BlaColors.primary
            : BlaColors.disabled;

    final Color borderColor = isPrimary
        ? Colors.transparent
        : isEnabled
            ? BlaColors.primary
            : BlaColors.disabled;

    // Button shape and border
    final border = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(BlaSpacings.radius),
      side: BorderSide(
        color: borderColor,
        width: 1.5,
      ),
    );

    // Create button content with or without icon
    Widget buttonContent = Text(
      text,
      style: BlaTextStyles.button.copyWith(color: textColor),
    );

    // Add icon if provided
    if (icon != null) {
      buttonContent =
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Icon(icon, color: textColor, size: 20),
        SizedBox(width: BlaSpacings.s),
        buttonContent,
      ]);
    }

    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.m),
          shape: border,
          disabledBackgroundColor: backgroundColor, // Keep same color when disabled
        ),
        child: buttonContent,
      ),
    );
  
  
  }
}
