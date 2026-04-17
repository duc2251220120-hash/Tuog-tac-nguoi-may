/// apply_job_screen.dart - Màn hình ứng tuyển công việc
/// Bổ sung: thông tin liên hệ, portfolio, mức lương kỳ vọng, xem trước CV
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_button.dart';
import '../../../../common/widgets/cg_text_field.dart';

class ApplyJobScreen extends StatefulWidget {
  const ApplyJobScreen({super.key});
  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  bool _useProfileCV = true;
  bool _isLoading = false;
  int _currentStep = 0;

  final _coverLetterCtrl = TextEditingController();
  final _portfolioCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();
  final _linkedinCtrl = TextEditingController();
  final _availableCtrl = TextEditingController(text: '01/05/2026');

  @override
  void dispose() {
    _coverLetterCtrl.dispose();
    _portfolioCtrl.dispose();
    _salaryCtrl.dispose();
    _linkedinCtrl.dispose();
    _availableCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CGAppBar(title: 'Ứng tuyển'),
      body: Column(
        children: [
          // ─── Progress steps ────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenPaddingH, vertical: 12.h),
            child: Row(
              children: [
                _StepDot(index: 0, current: _currentStep, label: 'CV'),
                _StepLine(active: _currentStep >= 1),
                _StepDot(index: 1, current: _currentStep, label: 'Thư'),
                _StepLine(active: _currentStep >= 2),
                _StepDot(index: 2, current: _currentStep, label: 'Thông tin'),
              ],
            ),
          ),

          const Divider(height: 1),

          // ─── Step content ──────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.screenPaddingH),
              child: _currentStep == 0
                  ? _Step1CV(
                      useProfileCV: _useProfileCV,
                      onChanged: (v) => setState(() => _useProfileCV = v),
                    )
                  : _currentStep == 1
                      ? _Step2CoverLetter(controller: _coverLetterCtrl)
                      : _Step3Info(
                          portfolioCtrl: _portfolioCtrl,
                          salaryCtrl: _salaryCtrl,
                          linkedinCtrl: _linkedinCtrl,
                          availableCtrl: _availableCtrl,
                        ),
            ),
          ),

          // ─── Bottom navigation ─────────────────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(
              AppDimensions.screenPaddingH, 12.h,
              AppDimensions.screenPaddingH, 24.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                if (_currentStep > 0) ...[
                  Expanded(
                    child: CGButton(
                      label: 'Quay lại',
                      type: CGButtonType.outline,
                      onPressed: () => setState(() => _currentStep--),
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: CGButton(
                    label: _currentStep < 2 ? 'Tiếp theo' : 'Gửi hồ sơ',
                    isLoading: _isLoading,
                    onPressed: _currentStep < 2
                        ? () => setState(() => _currentStep++)
                        : _handleSubmit,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1800));
    if (!mounted) return;
    setState(() => _isLoading = false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.r, height: 80.r,
              decoration: const BoxDecoration(
                color: AppColors.successLight, shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_rounded, color: AppColors.success, size: 44.r),
            ),
            SizedBox(height: 16.h),
            Text('Ứng tuyển thành công!', style: AppTextStyles.h3, textAlign: TextAlign.center),
            SizedBox(height: 8.h),
            Text('Hồ sơ của bạn đã được gửi đến\nFPT Software thành công.\nNhà tuyển dụng sẽ liên hệ sớm!',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center),
          ],
        ),
        actions: [
          CGButton(
            label: 'Xem hồ sơ đã ứng tuyển',
            onPressed: () {
              Navigator.pop(context);
              context.push(AppRoutePaths.appliedJobs);
            },
          ),
          SizedBox(height: 8.h),
          CGButton(
            label: 'Tiếp tục tìm việc',
            type: CGButtonType.ghost,
            onPressed: () {
              Navigator.pop(context);
              context.push(AppRoutePaths.jobSearch);
            },
          ),
        ],
      ),
    );
  }
}

// ─── Step 1: Chọn CV ─────────────────────────────────────────────────────────
class _Step1CV extends StatelessWidget {
  final bool useProfileCV;
  final ValueChanged<bool> onChanged;
  const _Step1CV({required this.useProfileCV, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Job info banner
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
          child: Row(
            children: [
              Container(
                width: 44.r, height: 44.r,
                decoration: BoxDecoration(
                  color: const Color(0xFFF97316),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(child: Text('FS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14.sp))),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Senior Frontend Developer', style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.primary)),
                    Text('FPT Software · TP.HCM · \$3,000 - \$5,000', style: AppTextStyles.caption),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),
        Text('Bước 1: Chọn CV', style: AppTextStyles.h4),
        SizedBox(height: 6.h),
        Text('Chọn CV bạn muốn gửi đến nhà tuyển dụng', style: AppTextStyles.caption),
        SizedBox(height: 16.h),

        _CVOption(
          title: 'Dùng CV trong hồ sơ',
          subtitle: 'Nguyễn Hồng Duy — CV_FlutterDev_2026.pdf',
          isSelected: useProfileCV,
          icon: Icons.description_rounded,
          onTap: () => onChanged(true),
          badge: 'CV mới nhất',
        ),
        SizedBox(height: 10.h),
        _CVOption(
          title: 'Tải CV mới lên',
          subtitle: 'Hỗ trợ PDF, DOCX — tối đa 5MB',
          isSelected: !useProfileCV,
          icon: Icons.upload_file_rounded,
          onTap: () => onChanged(false),
        ),

        if (!useProfileCV) ...[
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                border: Border.all(color: AppColors.primary, style: BorderStyle.solid, width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_rounded, color: AppColors.primary, size: 32.r),
                  SizedBox(height: 8.h),
                  Text('Nhấn để chọn file CV', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary)),
                  Text('PDF, DOCX — tối đa 5MB', style: AppTextStyles.caption),
                ],
              ),
            ),
          ),
        ],

        SizedBox(height: 24.h),
        // CV Preview
        if (useProfileCV)
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.remove_red_eye_outlined, size: 16.r, color: AppColors.textHint),
                  SizedBox(width: 6.w),
                  Text('Xem trước CV', style: AppTextStyles.label.copyWith(color: AppColors.textHint)),
                ]),
                Divider(height: 20.h),
                Text('NGUYỄN HỒNG DUY', style: AppTextStyles.h3),
                Text('Flutter Developer', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary)),
                SizedBox(height: 4.h),
                Text('TP.HCM · nguyenhongduy@email.com · +84 900 000 000', style: AppTextStyles.caption),
                Divider(height: 20.h),
                Text('Kinh nghiệm · Flutter Developer @ Career Global (2023 - Nay)', style: AppTextStyles.bodySmall),
                SizedBox(height: 6.h),
                Text('Học vấn · Đại học Bách Khoa TP.HCM · Kỹ thuật Phần mềm', style: AppTextStyles.bodySmall),
                SizedBox(height: 6.h),
                Text('Kỹ năng · Flutter, Dart, React Native, Firebase, REST API', style: AppTextStyles.bodySmall),
              ],
            ),
          ),
      ],
    );
  }
}

// ─── Step 2: Thư xin việc ─────────────────────────────────────────────────────
class _Step2CoverLetter extends StatelessWidget {
  final TextEditingController controller;
  const _Step2CoverLetter({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bước 2: Thư xin việc', style: AppTextStyles.h4),
        SizedBox(height: 6.h),
        Text('Giới thiệu bản thân và lý do bạn phù hợp với vị trí này',
            style: AppTextStyles.caption),
        SizedBox(height: 16.h),

        TextFormField(
          controller: controller,
          maxLines: 10,
          maxLength: 1000,
          decoration: InputDecoration(
            hintText: 'Ví dụ:\n\nKính gửi Ban Tuyển dụng FPT Software,\n\nTôi là Nguyễn Hồng Duy, hiện đang làm Flutter Developer với 3 năm kinh nghiệm...',
            hintStyle: AppTextStyles.hint.copyWith(fontSize: 13.sp),
            filled: true,
            fillColor: AppColors.surfaceLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),

        SizedBox(height: 16.h),
        // Tips
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9E6),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.lightbulb_rounded, color: AppColors.warning, size: 16.r),
                SizedBox(width: 6.w),
                Text('Mẹo viết thư xin việc hay', style: AppTextStyles.label.copyWith(color: AppColors.warning)),
              ]),
              SizedBox(height: 8.h),
              ...[
                'Đề cập cụ thể kỹ năng phù hợp với yêu cầu JD',
                'Nêu thành tích đã đạt được với con số cụ thể',
                'Thể hiện sự tìm hiểu về công ty và vị trí',
                'Giữ ngắn gọn, tối đa 3-4 đoạn văn',
              ].map((tip) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary)),
                    Expanded(child: Text(tip, style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary))),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Step 3: Thông tin bổ sung ────────────────────────────────────────────────
class _Step3Info extends StatelessWidget {
  final TextEditingController portfolioCtrl;
  final TextEditingController salaryCtrl;
  final TextEditingController linkedinCtrl;
  final TextEditingController availableCtrl;

  const _Step3Info({
    required this.portfolioCtrl,
    required this.salaryCtrl,
    required this.linkedinCtrl,
    required this.availableCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bước 3: Thông tin bổ sung', style: AppTextStyles.h4),
        SizedBox(height: 6.h),
        Text('Thêm thông tin để tăng cơ hội được chú ý', style: AppTextStyles.caption),
        SizedBox(height: 20.h),

        CGTextField(
          label: 'Mức lương kỳ vọng (USD/tháng)',
          hint: 'VD: 3000',
          controller: salaryCtrl,
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(Icons.attach_money_rounded),
        ),
        SizedBox(height: 16.h),

        CGTextField(
          label: 'Portfolio / Website cá nhân',
          hint: 'https://yourportfolio.com',
          controller: portfolioCtrl,
          keyboardType: TextInputType.url,
          prefixIcon: const Icon(Icons.language_rounded),
        ),
        SizedBox(height: 16.h),

        CGTextField(
          label: 'LinkedIn Profile',
          hint: 'https://linkedin.com/in/username',
          controller: linkedinCtrl,
          keyboardType: TextInputType.url,
          prefixIcon: const Icon(Icons.link_rounded),
        ),
        SizedBox(height: 16.h),

        CGTextField(
          label: 'Ngày có thể bắt đầu làm việc',
          hint: 'dd/mm/yyyy',
          controller: availableCtrl,
          prefixIcon: const Icon(Icons.calendar_today_rounded),
        ),
        SizedBox(height: 24.h),

        // Xác nhận
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('📋 Tóm tắt hồ sơ ứng tuyển', style: AppTextStyles.label.copyWith(color: AppColors.primary)),
              SizedBox(height: 10.h),
              _SummaryRow(label: 'Vị trí', value: 'Senior Frontend Developer'),
              _SummaryRow(label: 'Công ty', value: 'FPT Software'),
              _SummaryRow(label: 'CV', value: 'CV_FlutterDev_2026.pdf'),
              _SummaryRow(label: 'Thư xin việc', value: 'Đã điền'),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Shared Widgets ──────────────────────────────────────────────────────────
class _CVOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;
  final String? badge;

  const _CVOption({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.icon = Icons.description_outlined,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textHint, size: 24.r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(title, style: AppTextStyles.bodyMediumBold.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    )),
                    if (badge != null) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(badge!, style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ]),
                  SizedBox(height: 2.h),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final int index;
  final int current;
  final String label;
  const _StepDot({required this.index, required this.current, required this.label});

  @override
  Widget build(BuildContext context) {
    final isActive = index == current;
    final isDone = index < current;
    return Column(
      children: [
        Container(
          width: 28.r, height: 28.r,
          decoration: BoxDecoration(
            color: isDone ? AppColors.success : (isActive ? AppColors.primary : AppColors.border),
            shape: BoxShape.circle,
          ),
          child: Center(child: isDone
              ? Icon(Icons.check_rounded, color: Colors.white, size: 14.r)
              : Text('${index + 1}', style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w700))),
        ),
        SizedBox(height: 4.h),
        Text(label, style: AppTextStyles.caption.copyWith(
          color: isActive ? AppColors.primary : AppColors.textHint,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        )),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool active;
  const _StepLine({required this.active});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      height: 2,
      margin: EdgeInsets.only(bottom: 18.h),
      color: active ? AppColors.primary : AppColors.border,
    ),
  );
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 6.h),
    child: Row(children: [
      SizedBox(width: 80.w, child: Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.textHint))),
      Expanded(child: Text(value, style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600))),
    ]),
  );
}
