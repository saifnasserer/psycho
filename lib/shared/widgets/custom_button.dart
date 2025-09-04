import 'package:flutter/material.dart';
import '../../core/responsive/responsive.dart';
import '../../core/constants/app_constants.dart';

enum ButtonType { primary, secondary, text, outline }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = Responsive.getButtonSize(context);
    final finalWidth =
        width ?? (isFullWidth ? double.infinity : buttonSize.width);
    final finalHeight = height ?? buttonSize.height;

    Widget buttonContent = _buildButtonContent(context);

    switch (type) {
      case ButtonType.primary:
        return SizedBox(
          width: finalWidth,
          height: finalHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppConstants.mintGreen),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(
                    context,
                    AppConstants.baseBorderRadius,
                  ),
                ),
              ),
            ),
            child: buttonContent,
          ),
        );

      case ButtonType.secondary:
        return SizedBox(
          width: finalWidth,
          height: finalHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A2A2A), // Dark gray
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(
                    context,
                    AppConstants.baseBorderRadius,
                  ),
                ),
              ),
            ),
            child: buttonContent,
          ),
        );

      case ButtonType.outline:
        return SizedBox(
          width: finalWidth,
          height: finalHeight,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(AppConstants.mintGreen),
              side: const BorderSide(
                color: Color(AppConstants.mintGreen),
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(
                    context,
                    AppConstants.baseBorderRadius,
                  ),
                ),
              ),
            ),
            child: buttonContent,
          ),
        );

      case ButtonType.text:
        return SizedBox(
          width: finalWidth,
          height: finalHeight,
          child: TextButton(
            onPressed: isLoading ? null : onPressed,
            style: TextButton.styleFrom(
              foregroundColor: const Color(AppConstants.mintGreen),
            ),
            child: buttonContent,
          ),
        );
    }
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: Responsive.getFontSize(context, 20),
        height: Responsive.getFontSize(context, 20),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == ButtonType.outline || type == ButtonType.text
                ? const Color(AppConstants.mintGreen)
                : Colors.white,
          ),
        ),
      );
    }

    final textStyle = TextStyle(
      fontSize: Responsive.getFontSize(context, AppConstants.baseFontSize),
      fontWeight: FontWeight.w600,
      color: _getTextColor(),
    );

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Responsive.getFontSize(context, 18)),
          SizedBox(width: Responsive.getSpacing(context, 8)),
          Text(text, style: textStyle),
        ],
      );
    }

    return Text(text, style: textStyle);
  }

  Color _getTextColor() {
    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
        return Colors.white;
      case ButtonType.outline:
      case ButtonType.text:
        return const Color(AppConstants.mintGreen);
    }
  }
}
