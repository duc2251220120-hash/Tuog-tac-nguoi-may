/// home_screen.dart
/// Trang chủ & Feeds - Pixel-perfect theo "TRANG CHỦ & FEEDS.pdf"
/// AppBar logo + Story bar + "Bạn đang nghĩ gì?" + Post feed
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../common/widgets/cg_app_bar.dart';
import '../../../../common/widgets/cg_post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Track liked state for each post
  late List<bool> _likedStates;

  @override
  void initState() {
    super.initState();
    _likedStates = _samplePosts.map((p) => p['isLiked'] as bool).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGHomeAppBar(
        notificationCount: 3,
        onSearchTap: () => context.push(AppRoutePaths.search),
        onNotificationTap: () => context.push(AppRoutePaths.notifications),
        onAddTap: () {},
      ),
      body: ListView(
        children: [
          // ─── "Bạn đang nghĩ gì?" Post composer ────────────────────────
          const _PostComposer(),

          Container(height: 8.h, color: AppColors.background),

          // ─── Feed Posts ───────────────────────────────────────────────
          ..._samplePosts.asMap().entries.map((entry) {
            final i = entry.key;
            final post = entry.value;
            return Column(
              children: [
                CGPostCard(
                  authorName: post['author'] as String,
                  authorTitle: post['title'] as String,
                  timeAgo: post['time'] as String,
                  content: post['content'] as String,
                  imageUrl: post['image'] as String?,
                  likeCount: (post['likes'] as int) +
                      (_likedStates[i] && !(post['isLiked'] as bool) ? 1 : 0),
                  commentCount: post['comments'] as int,
                  shareCount: post['shares'] as int,
                  isLiked: _likedStates[i],
                  onLike: () =>
                      setState(() => _likedStates[i] = !_likedStates[i]),

                  // ✅ Đã sửa: Truyền sự kiện chuyển trang khi ấn bình luận
                  onComment: () {
                    // Chuyển hướng đến màn hình comments
                    context.push('/comments');
                  },

                  onShare: () {},
                  onSave: () {},
                  onMore: () {},
                ),
                Container(height: 8.h, color: AppColors.background),
              ],
            );
          }),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // ─── Sample Posts Data ────────────────────────────────────────────────────
  static final List<Map<String, dynamic>> _samplePosts = [
    {
      'author': 'Nguyễn Như Ý',
      'title': 'Product Manager @ VNG Corporation',
      'time': '2 giờ trước',
      'content':
          'Vừa hoàn thành dự án lớn nhất trong sự nghiệp! 🚀 Cảm ơn team tuyệt vời đã đồng hành cùng tôi suốt 6 tháng qua.\n\n💡 3 điều tôi học được:\n• Giao tiếp rõ ràng luôn quan trọng hơn kỹ thuật\n• Fail fast, learn faster\n• Người dùng luôn đúng — hãy lắng nghe họ',
      'image': 'https://picsum.photos/seed/career1/600/300',
      'likes': 142,
      'comments': 25,
      'shares': 15,
      'isLiked': false,
    },
    {
      'author': 'FPT Software',
      'title': 'Công ty Công nghệ · Tuyển dụng',
      'time': '3 giờ trước',
      'content':
          '🔥 FPT Software đang tuyển dụng gấp!\n\n📌 Senior Frontend Developer\n💰 \$3,000 - \$5,000/tháng\n📍 TP.HCM | Hybrid\n\nBạn có đam mê với React.js và muốn làm việc trong môi trường quốc tế? Đây là cơ hội dành cho bạn!\n\n👉 Ứng tuyển ngay qua Career Global',
      'image': null,
      'likes': 67,
      'comments': 18,
      'shares': 42,
      'isLiked': false,
    },
    {
      'author': 'Phạm Duy',
      'title': 'Data Scientist @ MoMo',
      'time': '5 giờ trước',
      'content':
          'Xu hướng AI/ML nổi bật năm 2026 mà mọi developer cần biết 🤖\n\n1️⃣ LLM ứng dụng vào enterprise đang bùng nổ\n2️⃣ MLOps là kỹ năng bắt buộc, không còn là "nice to have"\n3️⃣ Edge AI — AI chạy trực tiếp trên thiết bị đang thay đổi cuộc chơi\n4️⃣ Multimodal models ngày càng phổ biến hơn\n\nBạn đang theo dõi trend nào? Comments bên dưới nhé!',
      'image': null,
      'likes': 89,
      'comments': 34,
      'shares': 28,
      'isLiked': true,
    },
    {
      'author': 'Trần Thị Lan',
      'title': 'Senior UX Designer @ Zalo',
      'time': '1 ngày trước',
      'content':
          'Vừa hoàn thành khóa học Design System từ đầu 🎨 Chia sẻ một số insight:\n\n✅ Atomic Design không chỉ là lý thuyết — áp dụng đúng sẽ tiết kiệm 50% thời gian\n✅ Tokens là linh hồn của Design System\n✅ Documentation quan trọng không kém gì component\n\n#DesignSystem #UX #Figma',
      'image': 'https://picsum.photos/seed/ux2026/600/300',
      'likes': 204,
      'comments': 45,
      'shares': 67,
      'isLiked': false,
    },
    {
      'author': 'Lê Văn Thành',
      'title': 'Software Engineer @ Google',
      'time': '2 ngày trước',
      'content':
          'Sau 3 năm làm việc tại Google, đây là những điều tôi ước mình biết sớm hơn:\n\n🔹 Code review không phải là tấn công cá nhân — hãy học từ feedback\n🔹 "Done is better than perfect" nhưng đừng lạm dụng điều này\n🔹 Networking quan trọng hơn bạn nghĩ, ngay cả ở trong công ty\n🔹 Đọc sách kỹ thuật 30 phút mỗi ngày thay đổi career hoàn toàn\n\nChúc mọi người có tuần làm việc hiệu quả! 💪',
      'image': null,
      'likes': 518,
      'comments': 87,
      'shares': 124,
      'isLiked': false,
    },
    {
      'author': 'Nguyễn Thị Mai',
      'title': 'Product Designer @ Grab',
      'time': '2 ngày trước',
      'content':
          'Grab vừa ra mắt tính năng mới và team tôi đã làm việc 3 tháng để hoàn thiện UX! 🎉\n\nQuy trình design sprint chúng tôi sử dụng:\n→ Week 1: Research & Define\n→ Week 2: Ideate & Prototype\n→ Week 3: User testing\n→ Week 4: Iterate & Polish\n\nKết quả: Tăng 23% conversion rate! 🚀',
      'image': 'https://picsum.photos/seed/grab2026/600/300',
      'likes': 331,
      'comments': 52,
      'shares': 89,
      'isLiked': true,
    },
    {
      'author': 'VNG Corporation',
      'title': 'Công ty Công nghệ · Tuyển dụng',
      'time': '3 ngày trước',
      'content':
          '🌟 VNG đang mở rộng team và cần tuyển:\n\n• Product Manager (Senior)\n• Backend Engineer (Go/Java)\n• Data Analyst\n• iOS/Android Developer\n\n💰 Lương hấp dẫn + stock options\n🏢 Văn phòng hiện đại, môi trường startup nhưng quy mô lớn\n\nXem thêm và ứng tuyển qua Career Global! 👇',
      'image': null,
      'likes': 95,
      'comments': 23,
      'shares': 51,
      'isLiked': false,
    },
  ];
}

class _PostComposer extends StatelessWidget {
  const _PostComposer();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(
        AppDimensions.screenPaddingH,
        12.h,
        AppDimensions.screenPaddingH,
        14.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar "HD" màu xanh lá theo thiết kế
              Container(
                width: 42.r,
                height: 42.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF10B981),
                ),
                child: Center(
                  child: Text(
                    'HD',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              // TextField giả lập
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push(AppRoutePaths.createPost),
                  child: Container(
                    height: 42.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusFullPill),
                      border: Border.all(color: AppColors.border),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Bạn đang nghĩ gì?',
                      style: AppTextStyles.hint,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Action row: Ảnh / Video / Bài viết
          Row(
            children: [
              _ComposerAction(
                icon: Icons.image_outlined,
                label: 'Ảnh',
                color: AppColors.success,
              ),
              _ComposerAction(
                icon: Icons.videocam_outlined,
                label: 'Video',
                color: AppColors.error,
              ),
              _ComposerAction(
                icon: Icons.article_outlined,
                label: 'Bài viết',
                color: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ComposerAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ComposerAction({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20.r),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
