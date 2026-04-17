/// main_navigation_screen.dart
/// Shell màn hình chính với 5-tab Bottom Navigation Bar
/// Quản lý việc chuyển đổi giữa: Home, Jobs, Connect, Messages, Profile
library;

import 'package:flutter/material.dart';
import '../home/presentation/screens/home_screen.dart';
import '../jobs/presentation/screens/job_search_screen.dart';
import '../connections/presentation/screens/explore_screen.dart';
import '../messages/presentation/screens/chat_screen.dart';
import '../profile/presentation/screens/my_profile_screen.dart';
import '../../common/widgets/cg_bottom_nav.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  /// Danh sách các màn hình tương ứng với 5 tab
  final List<Widget> _screens = const [
    HomeScreen(),
    JobSearchScreen(),
    ExploreScreen(),
    ChatScreen(),
    MyProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Không dùng AppBar ở đây - mỗi màn hình tự quản lý AppBar
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      // Custom bottom navigation bar
      bottomNavigationBar: CGBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
