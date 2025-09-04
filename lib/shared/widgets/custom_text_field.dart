import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/responsive/responsive.dart';
import '../../core/constants/app_constants.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool autofocus;

  const CustomTextField({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: Responsive.getFontSize(context, 14),
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(height: Responsive.getSpacing(context, 8)),
        ],
        // Fixed height container for the text field
        SizedBox(
          height: Responsive.getFontSize(
            context,
            56,
          ), // Fixed height for all fields
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            enabled: enabled,
            readOnly: readOnly,
            maxLines: maxLines,
            maxLength: maxLength,
            onTap: onTap,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            inputFormatters: inputFormatters,
            validator: validator,
            focusNode: focusNode,
            autofocus: autofocus,
            style: TextStyle(
              fontSize: Responsive.getFontSize(
                context,
                AppConstants.baseFontSize,
              ),
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: hint,
              errorText: null, // Don't show error text inside the field
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: EdgeInsets.all(
                        Responsive.getSpacing(context, 12),
                      ),
                      child: prefixIcon!,
                    )
                  : null,
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: EdgeInsets.all(
                        Responsive.getSpacing(context, 12),
                      ),
                      child: suffixIcon!,
                    )
                  : null,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Responsive.getSpacing(
                  context,
                  AppConstants.baseSpacing,
                ),
                vertical: Responsive.getSpacing(context, 16),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(
                    context,
                    AppConstants.baseBorderRadius,
                  ),
                ),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(
                    context,
                    AppConstants.baseBorderRadius,
                  ),
                ),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(
                    context,
                    AppConstants.baseBorderRadius,
                  ),
                ),
                borderSide: const BorderSide(
                  color: Color(AppConstants.mintGreen),
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(
                    context,
                    AppConstants.baseBorderRadius,
                  ),
                ),
                borderSide: const BorderSide(
                  color: Color(0xFFE57373),
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Responsive.getBorderRadius(
                    context,
                    AppConstants.baseBorderRadius,
                  ),
                ),
                borderSide: const BorderSide(
                  color: Color(0xFFE57373),
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: const Color(0xFF2A2A2A), // Dark gray background
              hintStyle: TextStyle(
                fontSize: Responsive.getFontSize(
                  context,
                  AppConstants.baseFontSize,
                ),
                color: Colors.grey[400],
              ),
              errorStyle: TextStyle(
                fontSize: Responsive.getFontSize(context, 12),
                color: const Color(0xFFE57373),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
