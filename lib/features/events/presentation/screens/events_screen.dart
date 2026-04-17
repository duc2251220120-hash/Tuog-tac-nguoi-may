/// events_screen.dart - Màn hình Sự kiện
/// Bổ sung: filter tabs (Tất cả/Online/Offline/Sắp diễn ra), 6 sự kiện đầy đủ
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['Tất cả', 'Sắp diễn ra', 'Online', 'Offline'];

  static final List<Map<String, dynamic>> _allEvents = [
    {
      'title': 'Tech Career Fair 2026',
      'date': '20/04/2026',
      'time': '09:00 - 17:00',
      'location': 'Sài Gòn Exhibition & Convention Center',
      'type': 'Offline',
      'registered': 1250,
      'capacity': 2000,
      'price': 'Miễn phí',
      'tags': ['IT', 'Career', 'Networking'],
      'isUpcoming': true,
      'color': AppColors.purpleDark,
    },
    {
      'title': 'Flutter Dev Summit Vietnam',
      'date': '25/04/2026',
      'time': '19:00 - 21:30',
      'location': 'Online - Zoom Webinar',
      'type': 'Online',
      'registered': 843,
      'capacity': 1000,
      'price': 'Miễn phí',
      'tags': ['Flutter', 'Dart', 'Mobile'],
      'isUpcoming': true,
      'color': AppColors.primary,
    },
    {
      'title': 'AI & Future of Work Conference',
      'date': '05/05/2026',
      'time': '08:30 - 17:00',
      'location': 'WeWork Saigon, Q.1, TP.HCM',
      'type': 'Offline',
      'registered': 320,
      'capacity': 400,
      'price': '500,000đ',
      'tags': ['AI', 'ML', 'Future'],
      'isUpcoming': true,
      'color': AppColors.warning,
    },
    {
      'title': 'UX/UI Design Masterclass',
      'date': '10/05/2026',
      'time': '14:00 - 17:00',
      'location': 'Online - Google Meet',
      'type': 'Online',
      'registered': 267,
      'capacity': 300,
      'price': 'Miễn phí',
      'tags': ['Design', 'UX', 'Figma'],
      'isUpcoming': true,
      'color': const Color(0xFFEC4899),
    },
    {
      'title': 'Startup Pitch Night Q2/2026',
      'date': '15/05/2026',
      'time': '18:00 - 21:00',
      'location': 'Toong Co-working, Q.3, TP.HCM',
      'type': 'Offline',
      'registered': 89,
      'capacity': 150,
      'price': '200,000đ',
      'tags': ['Startup', 'Pitch', 'Investment'],
      'isUpcoming': true,
      'color': AppColors.success,
    },
    {
      'title': 'Data Science Workshop Hands-on',
      'date': '20/05/2026',
      'time': '09:00 - 12:00',
      'location': 'Online - Teams',
      'type': 'Online',
      'registered': 412,
      'capacity': 500,
      'price': 'Miễn phí',
      'tags': ['Data', 'Python', 'Analytics'],
      'isUpcoming': false,
      'color': const Color(0xFF06B6D4),
    },
  ];

  List<Map<String, dynamic>> get _filteredEvents {
    switch (_selectedFilter) {
      case 1:
        return _allEvents.where((e) => e['isUpcoming'] as bool).toList();
      case 2:
        return _allEvents.where((e) => e['type'] == 'Online').toList();
      case 3:
        return _allEvents.where((e) => e['type'] == 'Offline').toList();
      default:
        return _allEvents;
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = _filteredEvents;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Sự kiện'),
      body: Column(
        children: [
          // Filter tabs
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenPaddingH, vertical: 10.h),
            child: SizedBox(
              height: 36.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (_, i) => GestureDetector(
                  onTap: () => setState(() => _selectedFilter = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: _selectedFilter == i ? AppColors.primary : AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: _selectedFilter == i ? AppColors.primary : AppColors.border,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _filters[i],
                      style: AppTextStyles.caption.copyWith(
                        color: _selectedFilter == i ? Colors.white : AppColors.textSecondary,
                        fontWeight: _selectedFilter == i ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const Divider(height: 1),

          // Event list
          Expanded(
            child: events.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_busy_rounded, size: 48.r, color: AppColors.textHint),
                        SizedBox(height: 12.h),
                        Text('Không có sự kiện', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint)),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(AppDimensions.screenPaddingH),
                    itemCount: events.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (_, i) => _EventCard(event: events[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatefulWidget {
  final Map<String, dynamic> event;
  const _EventCard({required this.event});

  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool _registered = false;

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final isOnline = event['type'] == 'Online';
    final color = event['color'] as Color;
    final registered = event['registered'] as int;
    final capacity = event['capacity'] as int;
    final percent = registered / capacity;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.border),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Container(
            height: 110.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withValues(alpha: 0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.radiusMD),
                topRight: Radius.circular(AppDimensions.radiusMD),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    isOnline ? Icons.videocam_rounded : Icons.event_rounded,
                    color: Colors.white.withValues(alpha: 0.3),
                    size: 56.r,
                  ),
                ),
                Positioned(
                  top: 10.h, left: 12.w,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(event['type'] as String,
                            style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(width: 6.w),
                      if (event['isUpcoming'] as bool)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text('Sắp diễn ra',
                              style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10.h, right: 12.w,
                  child: Text(
                    event['price'] as String,
                    style: AppTextStyles.bodyMediumBold.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event['title'] as String, style: AppTextStyles.h4, maxLines: 2),
                SizedBox(height: 8.h),

                Row(children: [
                  Icon(Icons.calendar_today_outlined, size: 13.r, color: AppColors.textHint),
                  SizedBox(width: 4.w),
                  Text('${event['date']} · ${event['time']}', style: AppTextStyles.caption),
                ]),
                SizedBox(height: 4.h),
                Row(children: [
                  Icon(isOnline ? Icons.videocam_outlined : Icons.location_on_outlined,
                      size: 13.r, color: AppColors.textHint),
                  SizedBox(width: 4.w),
                  Expanded(child: Text(event['location'] as String,
                      style: AppTextStyles.caption, overflow: TextOverflow.ellipsis)),
                ]),

                SizedBox(height: 10.h),

                // Tags
                Wrap(
                  spacing: 6.w, runSpacing: 4.h,
                  children: (event['tags'] as List<String>).map((tag) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(tag, style: AppTextStyles.caption.copyWith(
                      color: color, fontWeight: FontWeight.w600,
                    )),
                  )).toList(),
                ),

                SizedBox(height: 10.h),

                // Capacity progress
                Row(children: [
                  Icon(Icons.people_outline_rounded, size: 13.r, color: AppColors.textHint),
                  SizedBox(width: 4.w),
                  Text('$registered/$capacity người đăng ký', style: AppTextStyles.caption),
                ]),
                SizedBox(height: 6.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: LinearProgressIndicator(
                    value: percent,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation(
                      percent > 0.8 ? AppColors.error : color,
                    ),
                    minHeight: 5.h,
                  ),
                ),
                if (percent > 0.8) ...[
                  SizedBox(height: 4.h),
                  Text('⚠️ Sắp đầy chỗ!',
                      style: AppTextStyles.caption.copyWith(color: AppColors.error, fontWeight: FontWeight.w600)),
                ],

                SizedBox(height: 12.h),

                SizedBox(
                  height: 38.h,
                  child: ElevatedButton(
                    onPressed: () => setState(() => _registered = !_registered),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _registered ? AppColors.surfaceLight : color,
                      foregroundColor: _registered ? AppColors.textPrimary : Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                    ),
                    child: Text(
                      _registered ? '✓ Đã đăng ký' : 'Đăng ký tham dự',
                      style: AppTextStyles.buttonSmall.copyWith(
                        color: _registered ? AppColors.textPrimary : Colors.white,
                      ),
                    ),
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
