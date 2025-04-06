import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool isLoading;
  final IconData? icon;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.isLoading = false,
    this.icon,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onPressed,
      child: Container(
        width: widget.width ?? double.infinity,
        height: widget.height ?? AppConstants.buttonHeightM,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          boxShadow: [
            BoxShadow(
              color: (widget.backgroundColor ?? theme.colorScheme.primary)
                  .withAlpha(77),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child:
              widget.isLoading
                  ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.textColor ?? Colors.white,
                      ),
                    ),
                  )
                  : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          color: widget.textColor ?? Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: AppConstants.spacingS),
                      ],
                      Text(
                        widget.text,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: widget.textColor ?? Colors.white,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
