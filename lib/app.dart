/// app.dart
/// Entry point cấu hình ứng dụng: Theme + Router + ScreenUtil
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';

class CareerGlobalApp extends StatelessWidget {
  const CareerGlobalApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// ScreenUtil design size: iPhone 14 Pro (390×844)
    /// Mọi kích thước trong app sẽ tự scale theo tỷ lệ này
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Career Global',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: appRouter,
        );
      },
    );
  }
}
