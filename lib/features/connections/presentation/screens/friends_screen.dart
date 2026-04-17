/// friends_screen.dart
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_avatar.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  static final List<String> _requests = ['Nguyễn Minh Tuấn', 'Trần Thị Bích', 'Lê Hoàng Nam'];
  static final List<String> _friends = ['Phạm Duy', 'Nguyễn Như Ý', 'Diệu Danh', 'Văn Long'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          title: Text('Bạn bè', style: AppTextStyles.h4),
          bottom: TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: const [Tab(text: 'Lời mời (3)'), Tab(text: 'Kết nối của tôi')],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              padding: EdgeInsets.all(AppDimensions.screenPaddingH),
              itemCount: _requests.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (_, i) => _FriendRequestCard(name: _requests[i]),
            ),
            ListView.separated(
              padding: EdgeInsets.all(AppDimensions.screenPaddingH),
              itemCount: _friends.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (_, i) => _FriendCard(name: _friends[i]),
            ),
          ],
        ),
      ),
    );
  }
}

class _FriendRequestCard extends StatefulWidget {
  final String name;
  const _FriendRequestCard({required this.name});
  @override
  State<_FriendRequestCard> createState() => _FriendRequestCardState();
}

class _FriendRequestCardState extends State<_FriendRequestCard> {
  bool _handled = false;

  @override
  Widget build(BuildContext context) {
    if (_handled) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CGAvatar(name: widget.name, size: 48.r),
          SizedBox(width: 12.w),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.name, style: AppTextStyles.bodyMediumBold),
            Text('Muốn kết nối với bạn', style: AppTextStyles.caption),
          ])),
          Row(
            children: [
              SizedBox(
                width: 70.w, height: 32.h,
                child: ElevatedButton(onPressed: () => setState(() => _handled = true),
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),
                  child: Text('Chấp nhận', style: TextStyle(fontSize: 11.sp, color: AppColors.white)),
                ),
              ),
              SizedBox(width: 6.w),
              SizedBox(
                width: 60.w, height: 32.h,
                child: OutlinedButton(onPressed: () => setState(() => _handled = true),
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.zero, side: const BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),
                  child: Text('Từ chối', style: TextStyle(fontSize: 11.sp)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FriendCard extends StatelessWidget {
  final String name;
  const _FriendCard({required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppDimensions.radiusMD), border: Border.all(color: AppColors.border)),
      child: Row(children: [
        CGAvatar(name: name, size: 44.r),
        SizedBox(width: 12.w),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: AppTextStyles.bodyMediumBold),
          Text('Đã kết nối', style: AppTextStyles.caption.copyWith(color: AppColors.success)),
        ])),
        Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary, size: 22.r),
      ]),
    );
  }
}
