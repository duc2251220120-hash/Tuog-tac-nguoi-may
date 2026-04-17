/// cg_text_field.dart
/// Widget ô nhập liệu tái sử dụng toàn ứng dụng Career Global
/// Hỗ trợ: text, password (có toggle ẩn/hiện), phone, search
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';

class CGTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;
  final bool isPhone;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  const CGTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.isPassword = false,
    this.isPhone = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.inputFormatters,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  State<CGTextField> createState() => _CGTextFieldState();
}

class _CGTextFieldState extends State<CGTextField> {
  bool _obscureText = true; // Ẩn mật khẩu mặc định

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.label),
          SizedBox(height: 6.h),
        ],

        // TextField
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscureText,
          keyboardType: widget.isPhone
              ? TextInputType.phone
              : widget.keyboardType ?? TextInputType.text,
          validator: widget.validator,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onSubmitted,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.hint,
            filled: true,
            fillColor: AppColors.surfaceLight,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppDimensions.textFieldPaddingH,
              vertical: AppDimensions.textFieldPaddingV,
            ),
            border: _buildBorder(AppColors.border),
            enabledBorder: _buildBorder(AppColors.border),
            focusedBorder: _buildBorder(AppColors.primary, width: 1.5),
            errorBorder: _buildBorder(AppColors.error),
            focusedErrorBorder: _buildBorder(AppColors.error, width: 1.5),
            // Prefix icon
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 14.w, right: 8.w),
                    child: widget.prefixIcon,
                  )
                : null,
            prefixIconConstraints: BoxConstraints(
              minWidth: 40.w,
              minHeight: AppDimensions.textFieldHeight,
            ),
            // Suffix icon: nút toggle mật khẩu hoặc custom
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => _obscureText = !_obscureText),
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textHint,
                      size: AppDimensions.iconMD,
                    ),
                  )
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }

  /// Tạo border với bo góc chuẩn theo thiết kế
  OutlineInputBorder _buildBorder(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

// ─── Search TextField (cho màn hình search/filter) ───────────────────────────
class CGSearchField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final VoidCallback? onFilterTap;

  const CGSearchField({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              readOnly: readOnly,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: hint ?? 'Tìm kiếm...',
                hintStyle: AppTextStyles.hint,
                filled: true,
                fillColor: AppColors.surfaceLight,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFullPill),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.textHint,
                  size: AppDimensions.iconLG,
                ),
              ),
            ),
          ),
        ),

        // Filter Button
        if (onFilterTap != null) ...[
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.tune_rounded,
                color: AppColors.white,
                size: AppDimensions.iconLG,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
