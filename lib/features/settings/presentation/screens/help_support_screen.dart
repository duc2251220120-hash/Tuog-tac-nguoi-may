import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../widgets/settings_card.dart';
import '../widgets/settings_tile.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Trợ giúp & Hỗ trợ'),
        backgroundColor: AppColors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          Row(
            children: [
              _buildSupportAction(Icons.chat_bubble_rounded, 'Chat hỗ trợ', AppColors.info),
              SizedBox(width: 12.w),
              _buildSupportAction(Icons.email_rounded, 'Gửi email', AppColors.success),
              SizedBox(width: 12.w),
              _buildSupportAction(Icons.open_in_new_rounded, 'Trung tâm HT', Colors.purple),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            title: 'Câu hỏi thường gặp',
            children: [
              _buildFaqTile(context, 'Làm thế nào để tối ưu hồ sơ của tôi?', 'Chắc chắn rằng bạn đã điền đầy đủ các thông tin quan trọng như kinh nghiệm làm việc, học vấn và kỹ năng kỹ thuật. Thêm ảnh đại diện chuyên nghiệp cũng giúp hồ sơ của bạn nổi bật hơn.'),
              const Divider(height: 1),
              _buildFaqTile(context, 'Làm sao để tìm được việc làm phù hợp?', 'Sử dụng các bộ lọc như mức lương, địa điểm, và loại hình công việc trong trang Tìm kiếm. Bạn cũng có thể dùng tính năng AI Matching để nhận gọi ý việc làm.'),
              const Divider(height: 1),
              _buildFaqTile(context, 'Tôi có thể ứng tuyển bao nhiêu vị trí?', 'Career Global không giới hạn số lượng công việc bạn có thể ứng tuyển. Hãy nộp đơn vào những vị trí phù hợp nhất với mục tiêu nghề nghiệp của bạn.'),
              const Divider(height: 1),
              _buildFaqTile(context, 'Làm sao để xóa tài khoản?', 'Bạn có thể xóa tài khoản trong phần Cài đặt > Dữ liệu & Bảo mật > Xóa tài khoản. Lưu ý, hành động này không thể hoàn tác.'),
            ],
          ),
          SizedBox(height: 24.h),
          SettingsCard(
            children: [
              SettingsTile(
                icon: Icons.report_problem_outlined,
                iconColor: AppColors.error,
                iconBgColor: AppColors.errorLight,
                title: 'Báo cáo sự cố',
                subtitle: 'Giúp chúng tôi cải thiện ứng dụng',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Center(
            child: Text(
              'support@careerglobal.vn · 1900-1234',
              style: AppTextStyles.caption.copyWith(color: AppColors.textHint),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  Widget _buildSupportAction(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.r),
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              style: AppTextStyles.captionBold.copyWith(color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqTile(BuildContext context, String question, String answer) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(question, style: AppTextStyles.bodyMediumBold),
        iconColor: AppColors.primary,
        collapsedIconColor: AppColors.textHint,
        childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
        children: [
          Text(answer, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary, height: 1.5)),
        ],
      ),
    );
  }
}
