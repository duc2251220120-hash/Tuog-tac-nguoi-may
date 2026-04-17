/// guide_screen.dart - Cẩm nang nghề nghiệp
/// Bổ sung: categories filter, 8 bài viết với thông tin đầy đủ, article detail
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});
  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  int _selectedCategory = 0;
  final List<String> _categories = ['Tất cả', 'Kỹ năng', 'CV & Hồ sơ', 'Phỏng vấn', 'Lương & Thị trường'];

  static final List<Map<String, dynamic>> _articles = [
    {
      'title': '10 kỹ năng Flutter Developer cần có năm 2026',
      'category': 'Kỹ năng',
      'readTime': '5 phút',
      'views': '12.4K',
      'color': AppColors.primary,
      'isNew': true,
      'isTrending': false,
      'summary': 'Từ state management đến DevOps, đây là những kỹ năng thiết yếu giúp bạn nổi bật trong thị trường Flutter.',
    },
    {
      'title': 'Cách viết CV kỹ thuật nổi bật để vào FAANG',
      'category': 'CV & Hồ sơ',
      'readTime': '8 phút',
      'views': '28.9K',
      'color': AppColors.success,
      'isNew': false,
      'isTrending': true,
      'summary': 'Hướng dẫn chi tiết từng mục trong CV kỹ thuật — từ Summary đến Projects, với ví dụ thực tế.',
    },
    {
      'title': 'System Design Interview: Hướng dẫn từ A đến Z',
      'category': 'Phỏng vấn',
      'readTime': '12 phút',
      'views': '45.2K',
      'color': AppColors.warning,
      'isNew': false,
      'isTrending': true,
      'summary': 'Cách tiếp cận và giải quyết bài phỏng vấn thiết kế hệ thống quy mô lớn cho các công ty top-tier.',
    },
    {
      'title': 'Mức lương IT Vietnam 2026 — Báo cáo đầy đủ',
      'category': 'Lương & Thị trường',
      'readTime': '4 phút',
      'views': '67.8K',
      'color': AppColors.purpleLight,
      'isNew': true,
      'isTrending': true,
      'summary': 'Khảo sát từ 5,000+ developer Việt Nam: lương theo cấp độ, tech stack và ngành nghề.',
    },
    {
      'title': '7 câu hỏi phỏng vấn Backend khó nhất và cách trả lời',
      'category': 'Phỏng vấn',
      'readTime': '10 phút',
      'views': '19.3K',
      'color': const Color(0xFFEF4444),
      'isNew': false,
      'isTrending': false,
      'summary': 'Từ database transactions đến distributed systems — các câu hỏi khó và cách trả lời ấn tượng.',
    },
    {
      'title': 'Negotiation lương: Làm sao đòi được mức tốt nhất?',
      'category': 'Lương & Thị trường',
      'readTime': '6 phút',
      'views': '23.1K',
      'color': const Color(0xFF06B6D4),
      'isNew': true,
      'isTrending': false,
      'summary': 'Scripts thực tế và chiến lược đàm phán lương đã được kiểm chứng bởi hàng nghìn developer.',
    },
    {
      'title': 'Portfolio GitHub: 5 dự án giúp bạn nổi bật',
      'category': 'CV & Hồ sơ',
      'readTime': '7 phút',
      'views': '31.6K',
      'color': const Color(0xFF8B5CF6),
      'isNew': false,
      'isTrending': true,
      'summary': 'Loại dự án nào trên GitHub thực sự thu hút nhà tuyển dụng? Phân tích từ 100+ hiring manager.',
    },
    {
      'title': 'Soft skills quan trọng nhất cho Senior Developer',
      'category': 'Kỹ năng',
      'readTime': '5 phút',
      'views': '14.7K',
      'color': const Color(0xFFF59E0B),
      'isNew': true,
      'isTrending': false,
      'summary': 'Kỹ thuật tốt chỉ đưa bạn đến Senior — soft skills sẽ đưa bạn lên Principal và leadership.',
    },
  ];

  List<Map<String, dynamic>> get _filteredArticles {
    if (_selectedCategory == 0) return _articles;
    final cat = _categories[_selectedCategory];
    return _articles.where((a) => a['category'] == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    final articles = _filteredArticles;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Cẩm nang nghề nghiệp'),
      body: ListView(
        children: [
          // Featured banner
          Padding(
            padding: EdgeInsets.fromLTRB(AppDimensions.screenPaddingH, AppDimensions.screenPaddingH, AppDimensions.screenPaddingH, 0),
            child: Container(
              constraints: BoxConstraints(minHeight: 140.h),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF0D47A1)]),
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              ),
              padding: EdgeInsets.all(20.r),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text('🔥 Trending', style: AppTextStyles.caption.copyWith(color: Colors.white)),
                        ),
                        SizedBox(height: 8.h),
                        Text('Cẩm nang toàn diện\nnghề Mobile Developer', style: AppTextStyles.h3.copyWith(color: Colors.white)),
                        SizedBox(height: 6.h),
                        Text('67.8K lượt đọc', style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.8))),
                      ],
                    ),
                  ),
                  Icon(Icons.menu_book_rounded, color: Colors.white.withValues(alpha: 0.3), size: 60.r),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Category filter
          SizedBox(
            height: 36.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenPaddingH),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => SizedBox(width: 8.w),
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => setState(() => _selectedCategory = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: _selectedCategory == i ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: _selectedCategory == i ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _categories[i],
                    style: AppTextStyles.caption.copyWith(
                      color: _selectedCategory == i ? Colors.white : AppColors.textSecondary,
                      fontWeight: _selectedCategory == i ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Section title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenPaddingH),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${articles.length} bài viết', style: AppTextStyles.h4),
                Text('Mới nhất', style: AppTextStyles.link),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Articles list
          ...articles.map((a) => Padding(
            padding: EdgeInsets.fromLTRB(AppDimensions.screenPaddingH, 0, AppDimensions.screenPaddingH, 10.h),
            child: _ArticleCard(article: a),
          )),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final Map<String, dynamic> article;
  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final color = article['color'] as Color;
    final isNew = article['isNew'] as bool;
    final isTrending = article['isTrending'] as bool;

    return GestureDetector(
      onTap: () => _showArticleDetail(context, article),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 52.r, height: 52.r,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
              ),
              child: Icon(Icons.article_outlined, color: color, size: 28.r),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isNew || isTrending)
                    Row(children: [
                      if (isNew) _Badge(label: 'Mới', color: AppColors.primary),
                      if (isNew && isTrending) SizedBox(width: 6.w),
                      if (isTrending) _Badge(label: '🔥 Hot', color: AppColors.error),
                      SizedBox(height: 4.h),
                    ]),
                  if (isNew || isTrending) SizedBox(height: 4.h),
                  Text(article['title'] as String,
                      style: AppTextStyles.bodyMediumBold, maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 4.h),
                  Text(article['summary'] as String,
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, height: 1.4),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 8.h),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(article['category'] as String,
                            style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.access_time_rounded, size: 11.r, color: AppColors.textHint),
                      SizedBox(width: 3.w),
                      Text(article['readTime'] as String, style: AppTextStyles.caption),
                      SizedBox(width: 8.w),
                      Icon(Icons.remove_red_eye_outlined, size: 11.r, color: AppColors.textHint),
                      SizedBox(width: 3.w),
                      Text(article['views'] as String, style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 18.r),
          ],
        ),
      ),
    );
  }

  void _showArticleDetail(BuildContext context, Map<String, dynamic> article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.92,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (_, ctrl) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w, height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: ctrl,
                  padding: EdgeInsets.all(AppDimensions.screenPaddingH),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: (article['color'] as Color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(article['category'] as String,
                            style: AppTextStyles.caption.copyWith(
                              color: article['color'] as Color,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      SizedBox(height: 12.h),
                      Text(article['title'] as String, style: AppTextStyles.h2),
                      SizedBox(height: 8.h),
                      Row(children: [
                        Icon(Icons.access_time_rounded, size: 14.r, color: AppColors.textHint),
                        SizedBox(width: 4.w),
                        Text('Đọc trong ${article['readTime']}', style: AppTextStyles.caption),
                        SizedBox(width: 12.w),
                        Icon(Icons.remove_red_eye_outlined, size: 14.r, color: AppColors.textHint),
                        SizedBox(width: 4.w),
                        Text('${article['views']} lượt đọc', style: AppTextStyles.caption),
                      ]),
                      const Divider(height: 24),
                      Text(article['summary'] as String,
                          style: AppTextStyles.bodyMedium.copyWith(
                            height: 1.7, color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          )),
                      SizedBox(height: 20.h),
                      Text(
                        'Nội dung bài viết đang được cập nhật đầy đủ trong phiên bản tiếp theo. '
                        'Hãy theo dõi Career Global để không bỏ lỡ những kiến thức hữu ích nhất cho sự nghiệp của bạn!\n\n'
                        'Trong khi đó, hãy khám phá các bài viết khác trong mục Cẩm nang hoặc tìm việc làm phù hợp với kỹ năng của bạn.',
                        style: AppTextStyles.bodyMedium.copyWith(height: 1.7, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: Text(label, style: AppTextStyles.caption.copyWith(
      color: color, fontWeight: FontWeight.w700, fontSize: 10.sp,
    )),
  );
}
