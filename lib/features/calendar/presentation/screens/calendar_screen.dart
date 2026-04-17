/// calendar_screen.dart
/// Bổ sung: điều hướng tháng động, hiển thị tháng hiện tại, sự kiện theo ngày được chọn
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_app_bar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _currentMonth;
  late DateTime _selected;

  // Sự kiện theo ngày (key: 'yyyy-MM-dd')
  static final Map<String, List<Map<String, dynamic>>> _eventsByDate = {
    '2026-04-15': [
      {'title': 'Meeting với team Design', 'time': '10:00 - 11:00', 'color': AppColors.primary, 'type': 'meeting'},
    ],
    '2026-04-20': [
      {'title': 'Tech Career Fair 2026', 'time': '09:00 - 17:00', 'color': AppColors.purpleDark, 'type': 'event'},
    ],
    '2026-04-22': [
      {'title': 'Phỏng vấn Technical - Shopee', 'time': '14:00 - 15:00', 'color': AppColors.error, 'type': 'interview'},
      {'title': 'Buổi Mentor với Trần Minh Khoa', 'time': '19:00 - 20:00', 'color': const Color(0xFF06B6D4), 'type': 'mentor'},
    ],
    '2026-04-25': [
      {'title': 'Flutter Dev Summit Vietnam', 'time': '19:00 - 21:30', 'color': AppColors.primary, 'type': 'event'},
      {'title': 'Deadline nộp CV - VNG', 'time': 'Cả ngày', 'color': AppColors.warning, 'type': 'deadline'},
    ],
    '2026-04-28': [
      {'title': 'Review code Sprint 12', 'time': '15:00 - 16:00', 'color': AppColors.success, 'type': 'meeting'},
    ],
    '2026-05-05': [
      {'title': 'AI & Future of Work Conference', 'time': '08:30 - 17:00', 'color': AppColors.warning, 'type': 'event'},
    ],
    '2026-05-10': [
      {'title': 'UX/UI Design Masterclass', 'time': '14:00 - 17:00', 'color': const Color(0xFFEC4899), 'type': 'event'},
    ],
    '2026-05-15': [
      {'title': 'Startup Pitch Night Q2/2026', 'time': '18:00 - 21:00', 'color': AppColors.success, 'type': 'event'},
      {'title': 'Phỏng vấn Final - FPT Software', 'time': '10:00 - 11:30', 'color': AppColors.error, 'type': 'interview'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _selected = DateTime.now();
    _currentMonth = DateTime(_selected.year, _selected.month, 1);
  }

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  List<Map<String, dynamic>> get _selectedEvents =>
      _eventsByDate[_dateKey(_selected)] ?? [];

  // Ngày nào có sự kiện
  bool _hasEvent(DateTime d) => _eventsByDate.containsKey(_dateKey(d));

  // Ngày đầu tiên của tháng là thứ mấy (T2=0..CN=6)
  int get _firstWeekday {
    final wd = DateTime(_currentMonth.year, _currentMonth.month, 1).weekday;
    return (wd - 1) % 7; // 0=T2
  }

  int get _daysInMonth =>
      DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;

  static const List<String> _weekLabels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
  static const List<String> _monthNames = [
    '', 'Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
    'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12',
  ];

  void _prevMonth() => setState(() =>
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1));

  void _nextMonth() => setState(() =>
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1));

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final totalCells = _firstWeekday + _daysInMonth;
    final rows = (totalCells / 7).ceil();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CGAppBar(title: 'Lịch của tôi'),
      body: ListView(
        padding: EdgeInsets.all(AppDimensions.screenPaddingH),
        children: [
          // ─── Calendar card ──────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(color: AppColors.border),
              boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              children: [
                // Month navigation
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _prevMonth,
                        icon: Icon(Icons.chevron_left_rounded, color: AppColors.textSecondary),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          _currentMonth = DateTime(today.year, today.month, 1);
                          _selected = today;
                        }),
                        child: Text(
                          '${_monthNames[_currentMonth.month]}, ${_currentMonth.year}',
                          style: AppTextStyles.h4,
                        ),
                      ),
                      IconButton(
                        onPressed: _nextMonth,
                        icon: Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),

                // Weekday headers
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: _weekLabels.map((d) => Expanded(
                      child: Center(
                        child: Text(d,
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.w600,
                            color: d == 'CN' ? AppColors.error : AppColors.textSecondary,
                          )),
                      ),
                    )).toList(),
                  ),
                ),

                SizedBox(height: 6.h),

                // Days grid
                Padding(
                  padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 12.h),
                  child: Column(
                    children: List.generate(rows, (row) => Row(
                      children: List.generate(7, (col) {
                        final cell = row * 7 + col;
                        final dayNum = cell - _firstWeekday + 1;
                        if (dayNum < 1 || dayNum > _daysInMonth) {
                          return Expanded(child: SizedBox(height: 40.r));
                        }
                        final date = DateTime(_currentMonth.year, _currentMonth.month, dayNum);
                        final isSelected = date.year == _selected.year &&
                            date.month == _selected.month &&
                            date.day == _selected.day;
                        final isToday = date.year == today.year &&
                            date.month == today.month &&
                            date.day == today.day;
                        final hasEvent = _hasEvent(date);
                        final isSunday = date.weekday == 7;

                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selected = date),
                            child: Container(
                              height: 40.r,
                              margin: EdgeInsets.all(1.r),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary
                                    : isToday ? AppColors.primaryLight
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$dayNum',
                                    style: AppTextStyles.caption.copyWith(
                                      color: isSelected ? Colors.white
                                          : isToday ? AppColors.primary
                                          : isSunday ? AppColors.error
                                          : AppColors.textPrimary,
                                      fontWeight: isSelected || isToday
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                    ),
                                  ),
                                  if (hasEvent && !isSelected)
                                    Container(
                                      width: 4.r, height: 4.r,
                                      margin: EdgeInsets.only(top: 1.h),
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    )),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // ─── Legend ─────────────────────────────────────────────────
          Row(
            children: [
              _Legend(color: AppColors.primary, label: 'Được chọn'),
              SizedBox(width: 16.w),
              _Legend(color: AppColors.primaryLight, label: 'Hôm nay', textColor: AppColors.primary),
              SizedBox(width: 16.w),
              Row(children: [
                Container(width: 6.r, height: 6.r, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                SizedBox(width: 4.w),
                Text('Có sự kiện', style: AppTextStyles.caption),
              ]),
            ],
          ),

          SizedBox(height: 20.h),

          // ─── Selected date events ────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _selectedEvents.isEmpty
                      ? 'Không có sự kiện'
                      : '${_selectedEvents.length} sự kiện · ${_selected.day}/${_selected.month}',
                  style: AppTextStyles.h4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () {},
                child: Row(children: [
                  Icon(Icons.add_circle_outline, color: AppColors.primary, size: 18.r),
                  SizedBox(width: 4.w),
                  Text('Thêm', style: AppTextStyles.link),
                ]),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          if (_selectedEvents.isEmpty)
            Container(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Column(
                children: [
                  Icon(Icons.event_available_rounded, size: 40.r, color: AppColors.textHint),
                  SizedBox(height: 8.h),
                  Text('Ngày này trống, hãy thêm sự kiện!',
                      style: AppTextStyles.caption.copyWith(color: AppColors.textHint)),
                ],
              ),
            )
          else
            ..._selectedEvents.map((ev) => _EventCard(event: ev)),

          SizedBox(height: 16.h),

          // ─── Upcoming events ─────────────────────────────────────────
          Text('Sắp diễn ra', style: AppTextStyles.h4),
          SizedBox(height: 12.h),
          ..._getAllUpcoming().map((item) => _UpcomingItem(
            title: item['title'] as String,
            dateStr: item['dateStr'] as String,
            time: item['time'] as String,
            color: item['color'] as Color,
            type: item['type'] as String,
          )),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getAllUpcoming() {
    final today = DateTime.now();
    final result = <Map<String, dynamic>>[];
    _eventsByDate.forEach((key, events) {
      final parts = key.split('-');
      final date = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
      if (date.isAfter(today) || date.isAtSameMomentAs(today)) {
        for (final ev in events) {
          result.add({
            ...ev,
            'dateStr': '${date.day}/${date.month}/${date.year}',
          });
        }
      }
    });
    result.sort((a, b) => (a['dateStr'] as String).compareTo(b['dateStr'] as String));
    return result.take(6).toList();
  }
}

class _EventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  const _EventCard({required this.event});

  IconData get _typeIcon {
    switch (event['type'] as String) {
      case 'interview': return Icons.work_rounded;
      case 'event': return Icons.event_rounded;
      case 'mentor': return Icons.school_rounded;
      case 'deadline': return Icons.assignment_late_rounded;
      case 'meeting': return Icons.group_rounded;
      default: return Icons.circle_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = event['color'] as Color;
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 4, offset: const Offset(0, 1))],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        leading: Container(
          width: 36.r, height: 36.r,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
          child: Icon(_typeIcon, color: color, size: 18.r),
        ),
        title: Text(event['title'] as String, style: AppTextStyles.bodyMediumBold),
        subtitle: Text(event['time'] as String,
            style: AppTextStyles.caption.copyWith(color: color)),
      ),
    );
  }
}

class _UpcomingItem extends StatelessWidget {
  final String title;
  final String dateStr;
  final String time;
  final Color color;
  final String type;
  const _UpcomingItem({required this.title, required this.dateStr, required this.time, required this.color, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r, height: 44.r,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(dateStr.split('/')[0], style: TextStyle(color: color, fontSize: 16.sp, fontWeight: FontWeight.w800, height: 1)),
                Text(
                  'Tháng ${dateStr.split('/')[1]}',
                  style: TextStyle(color: color, fontSize: 9.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMediumBold, maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 2.h),
                Text(time, style: AppTextStyles.caption.copyWith(color: color)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: AppColors.textHint, size: 18.r),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  final Color? textColor;
  const _Legend({required this.color, required this.label, this.textColor});

  @override
  Widget build(BuildContext context) => Row(children: [
    Container(width: 14.r, height: 14.r, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    SizedBox(width: 4.w),
    Text(label, style: AppTextStyles.caption.copyWith(color: textColor)),
  ]);
}
