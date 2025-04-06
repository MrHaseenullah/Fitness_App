import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final String? errorText;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.onEditingComplete,
    this.textInputAction,
    this.errorText,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (widget.focusNode?.hasFocus != _isFocused) {
      setState(() {
        _isFocused = widget.focusNode?.hasFocus ?? false;
      });
    }
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      focusNode: widget.focusNode,
      onEditingComplete: widget.onEditingComplete,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      style: theme.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingL,
          vertical: AppConstants.spacingM,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
          borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5),
        ),
        filled: true,
        fillColor:
            _isFocused
                ? theme.colorScheme.primary.withAlpha(13)
                : theme.inputDecorationTheme.fillColor,
      ),
    );
  }
}
