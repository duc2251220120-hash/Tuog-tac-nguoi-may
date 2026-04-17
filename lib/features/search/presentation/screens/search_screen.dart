/// search_screen.dart
library;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../common/widgets/cg_avatar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  String _query = '';
  int _tabIndex = 0;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20)),
        title: TextField(
          controller: _ctrl,
          autofocus: true,
          onChanged: (v) => setState(() => _query = v),
          decoration: InputDecoration(
            hintText: 'Tìm kiếm...',
            hintStyle: AppTextStyles.hint,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          ),
        ),
        actions: [if (_query.isNotEmpty) IconButton(onPressed: () { _ctrl.clear(); setState(() => _query = ''); }, icon: const Icon(Icons.close))],
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 46.h),
          child: Column(
            children: [
              const Divider(height: 1),
              SizedBox(
                height: 44.h,
                child: Row(
                  children: ['Tất cả', 'Người', 'Việc làm', 'Công ty'].asMap().entries.map((e) => GestureDetector(
                    onTap: () => setState(() => _tabIndex = e.key),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                          color: _tabIndex == e.key ? AppColors.primary : Colors.transparent, width: 2,
                        )),
                      ),
                      alignment: Alignment.center,
                      child: Text(e.value, style: AppTextStyles.label.copyWith(
                        color: _tabIndex == e.key ? AppColors.primary : AppColors.textSecondary,
                        fontWeight: _tabIndex == e.key ? FontWeight.w600 : FontWeight.w400,
                      )),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _query.isEmpty
          ? _RecentSearches()
          : _SearchResults(query: _query),
    );
  }
}

class _RecentSearches extends StatelessWidget {
  const _RecentSearches();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppDimensions.screenPaddingH),
      children: [
        Text('Tìm kiếm gần đây', style: AppTextStyles.h4),
        SizedBox(height: 12.h),
        ...['Flutter Developer', 'FPT Software', 'Product Manager'].map((s) => ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.history, color: AppColors.textHint, size: 20.r),
          title: Text(s, style: AppTextStyles.bodyMedium),
          trailing: Icon(Icons.close, color: AppColors.textHint, size: 18.r),
        )),
      ],
    );
  }
}

class _SearchResults extends StatelessWidget {
  final String query;
  const _SearchResults({required this.query});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(AppDimensions.screenPaddingH),
      itemCount: 4,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) => ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
        leading: CGAvatar(name: 'Người $i', size: 44.r),
        title: Text('$query Developer $i', style: AppTextStyles.bodyMediumBold),
        subtitle: Text('Senior Engineer @ Company $i', style: AppTextStyles.caption),
        trailing: Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
        onTap: () {},
      ),
    );
  }
}
