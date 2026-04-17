/// profile_screen.dart - Hồ sơ người dùng khác (view mode)
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_avatar.dart';
import '../../../../common/widgets/cg_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ─── Banner + AppBar ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Banner gradient
                Container(
                  height: AppDimensions.profileBannerHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.purpleDark, AppColors.purpleLight],
                    ),
                  ),
                ),

                // Back & more buttons
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: Icon(Icons.arrow_back_ios_new_rounded,
                              color: AppColors.white, size: 20.r),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_horiz, color: AppColors.white, size: 24.r),
                        ),
                      ],
                    ),
                  ),
                ),

                // Avatar overlapping
                Positioned(
                  bottom: -(AppDimensions.avatarXL / 2),
                  left: AppDimensions.screenPaddingH,
                  child: Container(
                    padding: EdgeInsets.all(3.r),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CGAvatar(
                      name: 'Trần Thị Nhật',
                      size: AppDimensions.avatarXL,
                      backgroundColor: AppColors.purpleLight,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: AppColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimensions.avatarXL / 2 + 12.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenPaddingH),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Trần Thị Nhật', style: AppTextStyles.h3),
                        SizedBox(height: 4.h),
                        Text('Product Manager tại VNG Corporation',
                            style: AppTextStyles.bodySmall),
                        SizedBox(height: 4.h),
                        Wrap(
                          spacing: 12.w,
                          runSpacing: 4.h,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.location_on_outlined,
                                    size: 14.r, color: AppColors.textHint),
                                SizedBox(width: 4.w),
                                Text('TP.HCM', style: AppTextStyles.caption),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.people_outline_rounded,
                                    size: 14.r, color: AppColors.textHint),
                                SizedBox(width: 4.w),
                                Text('12 kết nối chung', style: AppTextStyles.caption),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        Row(
                          children: [
                            Expanded(
                              child: CGButton(
                                label: 'Kết nối',
                                prefixIcon: Icon(Icons.person_add_outlined,
                                    color: AppColors.white, size: 18.r),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CGButton(
                                label: 'Nhắn tin',
                                type: CGButtonType.outline,
                                prefixIcon: Icon(Icons.chat_bubble_outline_rounded,
                                    color: AppColors.textPrimary, size: 18.r),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),
                  const Divider(),
                ],
              ),
            ),
          ),

          // ─── Sections ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Column(
              children: [
                _ProfileSection(
                  title: 'Giới thiệu',
                  child: Text(
                    'Product Manager với 6 năm kinh nghiệm tại các công ty công nghệ hàng đầu Việt Nam. Chuyên xây dựng sản phẩm B2C với hàng triệu người dùng.',
                    style: AppTextStyles.bodyMedium.copyWith(height: 1.6),
                  ),
                ),

                _ProfileSection(
                  title: 'Kinh nghiệm',
                  child: _ExperienceItem(
                    company: 'VNG',
                    role: 'Product Manager',
                    period: '2020 - Hiện tại',
                  ),
                ),

                _ProfileSection(
                  title: 'Kỹ năng',
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: ['Product Strategy', 'Agile', 'User Research', 'Data Analysis']
                        .map((s) => _SkillChip(label: s))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _ProfileSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(AppDimensions.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final String company;
  final String role;
  final String period;

  const _ExperienceItem({required this.company, required this.role, required this.period});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CGAvatar(name: company, size: 40.r, backgroundColor: AppColors.avatarBlue),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$role \u00b7 $company', style: AppTextStyles.bodyMediumBold),
              Text(period, style: AppTextStyles.caption),
            ],
          ),
        ),
        Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(label, style: AppTextStyles.caption.copyWith(
        color: AppColors.primary, fontWeight: FontWeight.w500,
      )),
    );
  }
}
