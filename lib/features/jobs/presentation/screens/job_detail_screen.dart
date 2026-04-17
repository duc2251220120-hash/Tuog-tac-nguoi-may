/// job_detail_screen.dart
/// Chi tiết công việc - "CHI TIẾT CÔNG VIỆC.pdf"
/// Bổ sung: thông tin công ty, thời hạn, số ứng viên, tab mô tả/công ty
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_button.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20.r,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        title: Text('Chi tiết công việc', style: AppTextStyles.h4),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => setState(() => _isSaved = !_isSaved),
            icon: Icon(
              _isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: _isSaved ? AppColors.primary : AppColors.textPrimary,
              size: AppDimensions.iconLG,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share_outlined,
              color: AppColors.textPrimary,
              size: AppDimensions.iconLG,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // ─── Header card ──────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppDimensions.screenPaddingH, 16.h,
                  AppDimensions.screenPaddingH, 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company logo + Job title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.r,
                          height: 60.r,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF97316),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Center(
                            child: Text(
                              'FS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Senior Frontend Developer',
                                  style: AppTextStyles.h3),
                              SizedBox(height: 2.h),
                              Text('FPT Software',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.textSecondary)),
                              SizedBox(height: 4.h),
                              Row(children: [
                                Icon(Icons.star_rounded,
                                    color: AppColors.warning, size: 14.r),
                                SizedBox(width: 3.w),
                                Text('4.2 · Top công ty IT',
                                    style: AppTextStyles.caption),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 14.h),

                    // ─── Info chips ──────────────────────────────────────
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _InfoChip(icon: Icons.location_on_outlined, label: 'TP.HCM'),
                        _InfoChip(icon: Icons.monetization_on_outlined, label: '\$3,000 - \$5,000'),
                        _InfoChip(icon: Icons.access_time_rounded, label: 'Toàn thời gian'),
                        _InfoChip(icon: Icons.people_outline_rounded, label: '38 ứng viên'),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // Badges row
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: AppColors.tagUrgent,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text('🔥 Tuyển gấp',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.error,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: AppColors.successLight,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text('⏰ Còn 7 ngày',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),
                  ],
                ),
              ),

              // ─── Tabs ────────────────────────────────────────────────
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: AppTextStyles.label.copyWith(fontWeight: FontWeight.w600),
                tabs: const [Tab(text: 'Mô tả'), Tab(text: 'Về công ty')],
              ),

              const Divider(height: 1),

              // ─── Tab content ─────────────────────────────────────────
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _JobDescriptionTab(),
                    _CompanyTab(),
                  ],
                ),
              ),
            ],
          ),

          // ─── Bottom Apply Button ─────────────────────────────────────
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                AppDimensions.screenPaddingH, 12.h,
                AppDimensions.screenPaddingH, 24.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(top: BorderSide(color: AppColors.border)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CGButton(
                      label: 'Ứng tuyển ngay',
                      onPressed: () => context.push(AppRoutePaths.applyJob),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab 1: Mô tả công việc ──────────────────────────────────────────────────
class _JobDescriptionTab extends StatelessWidget {
  const _JobDescriptionTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.screenPaddingH, 20.h,
        AppDimensions.screenPaddingH, 110.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Mô tả công việc', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          Text(
            'Chúng tôi đang tìm kiếm Senior Frontend Developer có kinh nghiệm để gia nhập team phát triển sản phẩm của FPT Software.\n\nBạn sẽ chịu trách nhiệm xây dựng và tối ưu hóa các ứng dụng web hiệu suất cao, làm việc chặt chẽ với team backend và design để tạo ra trải nghiệm người dùng xuất sắc.\n\nĐây là cơ hội tuyệt vời để phát triển sự nghiệp trong môi trường công nghệ quốc tế, với những dự án có tầm ảnh hưởng rộng.',
            style: AppTextStyles.bodyMedium.copyWith(
              height: 1.65, color: AppColors.textSecondary,
            ),
          ),

          SizedBox(height: 20.h),
          Text('Yêu cầu ứng viên', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          ...[
            '5+ năm kinh nghiệm với React.js hoặc Vue.js',
            'Thành thạo TypeScript, HTML5, CSS3/SCSS',
            'Có kinh nghiệm với RESTful API và GraphQL',
            'Hiểu biết về CI/CD, Docker, Git flow',
            'Kỹ năng giao tiếp tốt bằng tiếng Anh (B2+)',
            'Có kinh nghiệm Agile/Scrum là lợi thế lớn',
          ].map((req) => _BulletItem(text: req)),

          SizedBox(height: 20.h),
          Text('Kỹ năng mong muốn', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w, runSpacing: 8.h,
            children: [
              'React.js', 'TypeScript', 'Next.js', 'GraphQL',
              'Tailwind CSS', 'Jest', 'Webpack', 'AWS',
            ].map((s) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(s, style: AppTextStyles.caption.copyWith(
                color: AppColors.primary, fontWeight: FontWeight.w600,
              )),
            )).toList(),
          ),

          SizedBox(height: 20.h),
          Text('Phúc lợi', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          ...[
            'Lương cạnh tranh + thưởng hiệu suất hàng quý',
            'Bảo hiểm sức khỏe toàn diện cho nhân viên & gia đình',
            'Làm việc hybrid: 3 ngày remote/tuần',
            '15 ngày phép năm có lương + ngày nghỉ lễ',
            'Budget đào tạo \$1,000/năm (khóa học, conference)',
            'Môi trường làm việc quốc tế, cơ hội đi nước ngoài',
            'Bữa trưa miễn phí tại văn phòng',
          ].map((b) => _BulletItem(
            text: b,
            icon: Icons.check_circle_outline_rounded,
            color: AppColors.success,
          )),

          SizedBox(height: 20.h),
          // Quy trình tuyển dụng
          Text('Quy trình tuyển dụng', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          _ProcessStep(step: '01', title: 'Nộp hồ sơ', desc: 'CV & thư xin việc qua Career Global'),
          _ProcessStep(step: '02', title: 'Screening', desc: 'HR liên hệ phỏng vấn sơ bộ (30 phút)'),
          _ProcessStep(step: '03', title: 'Technical Test', desc: 'Bài test kỹ thuật online (2 giờ)'),
          _ProcessStep(step: '04', title: 'Phỏng vấn Final', desc: 'Phỏng vấn với Tech Lead & Manager'),
          _ProcessStep(step: '05', title: 'Offer', desc: 'Nhận offer trong vòng 3 ngày làm việc', isLast: true),
        ],
      ),
    );
  }
}

// ─── Tab 2: Về công ty ───────────────────────────────────────────────────────
class _CompanyTab extends StatelessWidget {
  const _CompanyTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppDimensions.screenPaddingH, 20.h,
        AppDimensions.screenPaddingH, 110.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company header
          GestureDetector(
            onTap: () => context.push(AppRoutePaths.company),
            child: Row(
              children: [
                Container(
                  width: 56.r,
                  height: 56.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF97316),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text('FS', style: TextStyle(
                      color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700,
                    )),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FPT Software', style: AppTextStyles.h3),
                    Text('Công ty CNTT hàng đầu Việt Nam',
                        style: AppTextStyles.caption),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

          // Company stats
          Row(
            children: [
              _CompanyStat(value: '30,000+', label: 'Nhân viên'),
              _CompanyStat(value: '30+', label: 'Quốc gia'),
              _CompanyStat(value: '1988', label: 'Thành lập'),
              _CompanyStat(value: '4.2⭐', label: 'Đánh giá'),
            ],
          ),

          SizedBox(height: 20.h),
          Text('Giới thiệu', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          Text(
            'FPT Software là công ty công nghệ hàng đầu Việt Nam, cung cấp dịch vụ phần mềm và chuyển đổi số cho các doanh nghiệp tại hơn 30 quốc gia.\n\nVới hơn 30.000 nhân viên, chúng tôi không ngừng đổi mới và phát triển để trở thành đối tác công nghệ tin cậy toàn cầu.\n\nFPT Software đặc biệt chú trọng vào văn hóa học hỏi liên tục và phát triển con người.',
            style: AppTextStyles.bodyMedium.copyWith(
              height: 1.65, color: AppColors.textSecondary,
            ),
          ),

          SizedBox(height: 20.h),
          Text('Văn hóa công ty', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          ...[
            ('🚀', 'Tinh thần khởi nghiệp', 'Môi trường làm việc linh hoạt, sáng tạo không giới hạn'),
            ('🌍', 'Toàn cầu hóa', 'Cơ hội làm việc với khách hàng quốc tế tại 30+ quốc gia'),
            ('📚', 'Học hỏi liên tục', 'Budget đào tạo hàng năm và chương trình mentorship'),
            ('⚖️', 'Work-life balance', 'Làm việc hybrid, coi trọng sức khỏe tinh thần nhân viên'),
          ].map((item) => _CultureItem(emoji: item.$1, title: item.$2, desc: item.$3)),

          SizedBox(height: 20.h),
          Text('Các công việc khác tại FPT Software', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          ...[
            ('React Native Developer', 'TP.HCM · \$2,000-\$3,500'),
            ('DevOps Engineer', 'Hà Nội · \$2,500-\$4,000'),
            ('Business Analyst', 'TP.HCM · \$1,500-\$2,500'),
          ].map((job) => _RelatedJobItem(title: job.$1, info: job.$2)),
        ],
      ),
    );
  }
}

// ─── Supporting Widgets ───────────────────────────────────────────────────────
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.r, color: AppColors.textSecondary),
          SizedBox(width: 5.w),
          Text(label, style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary, fontWeight: FontWeight.w500,
          )),
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  const _BulletItem({
    required this.text,
    this.icon = Icons.fiber_manual_record_rounded,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.h),
            child: Icon(icon, size: 13.r, color: color),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(text, style: AppTextStyles.bodyMedium.copyWith(
              height: 1.5, color: AppColors.textSecondary,
            )),
          ),
        ],
      ),
    );
  }
}

class _ProcessStep extends StatelessWidget {
  final String step;
  final String title;
  final String desc;
  final bool isLast;
  const _ProcessStep({required this.step, required this.title, required this.desc, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36.r, height: 36.r,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text(step, style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w700))),
            ),
            if (!isLast) Container(width: 2, height: 36.h, color: AppColors.border),
          ],
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h, top: 6.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMediumBold),
                SizedBox(height: 2.h),
                Text(desc, style: AppTextStyles.caption),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CompanyStat extends StatelessWidget {
  final String value;
  final String label;
  const _CompanyStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: AppTextStyles.h4.copyWith(color: AppColors.primary)),
          SizedBox(height: 2.h),
          Text(label, style: AppTextStyles.caption, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _CultureItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String desc;
  const _CultureItem({required this.emoji, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: TextStyle(fontSize: 22.sp)),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMediumBold),
                SizedBox(height: 2.h),
                Text(desc, style: AppTextStyles.caption.copyWith(height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedJobItem extends StatelessWidget {
  final String title;
  final String info;
  const _RelatedJobItem({required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMediumBold),
                Text(info, style: AppTextStyles.caption),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 14.r, color: AppColors.textHint),
        ],
      ),
    );
  }
}
