/// app_routes.dart
/// Cấu hình điều hướng toàn cục dùng go_router
/// Định nghĩa tất cả 32 routes của ứng dụng Career Global
library;

import 'package:go_router/go_router.dart';

// Auth
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';

// Main Navigation
import '../../features/main_navigation/main_navigation_screen.dart';

// Profile
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/cv_screen.dart';
import '../../features/profile/presentation/screens/cv_preview_screen.dart';
import '../../features/profile/presentation/screens/complete_profile_screen.dart';
import '../../features/profile/presentation/screens/analytics_screen.dart';

// Jobs
import '../../features/jobs/presentation/screens/job_search_screen.dart';
import '../../features/jobs/presentation/screens/job_detail_screen.dart';
import '../../features/jobs/presentation/screens/job_filter_screen.dart';
import '../../features/jobs/presentation/screens/job_suggestions_screen.dart';
import '../../features/jobs/presentation/screens/saved_jobs_screen.dart';
import '../../features/jobs/presentation/screens/applied_jobs_screen.dart';
import '../../features/jobs/presentation/screens/apply_job_screen.dart';
import '../../features/jobs/presentation/screens/company_profile_screen.dart';

// Connections
import '../../features/connections/presentation/screens/explore_screen.dart';
import '../../features/connections/presentation/screens/friends_screen.dart';
import '../../features/connections/presentation/screens/connect_friends_screen.dart';

// Messages
import '../../features/messages/presentation/screens/chat_screen.dart';

// Notifications
import '../../features/notifications/presentation/screens/notifications_screen.dart';

// Events
import '../../features/events/presentation/screens/events_screen.dart';

// Mentor
import '../../features/mentor/presentation/screens/find_mentor_screen.dart';
import '../../features/mentor/presentation/screens/mentor_profile_screen.dart';
import '../../features/mentor/presentation/screens/book_mentor_screen.dart';

// Search
import '../../features/search/presentation/screens/search_screen.dart';

// Settings
import '../../features/settings/presentation/screens/settings_screen.dart';

// Calendar & Guide
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/guide/presentation/screens/guide_screen.dart';

// Home Extensions
import '../../features/home/presentation/screens/create_post_screen.dart';
import '../../features/home/presentation/screens/comments_screen.dart';

/// Định nghĩa các route name constants
class AppRoutePaths {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const otp = '/otp';
  static const forgotPassword = '/forgot-password';
  static const resetPassword = '/reset-password';
  static const home = '/home';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const cv = '/profile/cv';
  static const cvPreview = '/profile/cv-preview';
  static const completeProfile = '/complete-profile';
  static const analytics = '/analytics';
  static const jobSearch = '/jobs';
  static const jobDetail = '/jobs/detail';
  static const jobFilter = '/jobs/filter';
  static const jobSuggestions = '/jobs/suggestions';
  static const savedJobs = '/jobs/saved';
  static const appliedJobs = '/jobs/applied';
  static const applyJob = '/jobs/apply';
  static const company = '/company';
  static const explore = '/explore';
  static const friends = '/friends';
  static const connectFriends = '/friends/connect';
  static const chat = '/chat';
  static const notifications = '/notifications';
  static const events = '/events';
  static const findMentor = '/mentor';
  static const mentorProfile = '/mentor/profile';
  static const bookMentor = '/mentor/book';
  static const search = '/search';
  static const settings = '/settings';
  static const calendar = '/calendar';
  static const guide = '/guide';
  // ✅ Đổi từ '/home/create-post' → '/create-post'
  static const createPost = '/create-post';
  // ✅ Đổi từ '/home/comments' → '/comments'
  static const comments = '/comments';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutePaths.splash,
  debugLogDiagnostics: false,
  routes: [
    // ─── Auth ───────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.onboarding,
      builder: (_, __) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.login,
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.register,
      builder: (_, __) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.otp,
      builder: (context, state) {
        final phone = state.extra as String? ?? '';
        return OtpScreen(phoneNumber: phone);
      },
    ),
    GoRoute(
      path: AppRoutePaths.forgotPassword,
      builder: (_, __) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.resetPassword,
      builder: (_, __) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.completeProfile,
      builder: (_, __) => const CompleteProfileScreen(),
    ),

    // ─── Main (Shell - Bottom Nav) ───────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.home,
      builder: (_, __) => const MainNavigationScreen(),
    ),

    // ─── Profile ────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.profile,
      builder: (_, __) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.editProfile,
      builder: (_, __) => const EditProfileScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.cv,
      builder: (_, __) => const CvScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.cvPreview,
      builder: (_, __) => const CvPreviewScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.analytics,
      builder: (_, __) => const AnalyticsScreen(),
    ),

    // ─── Jobs ───────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.jobSearch,
      builder: (_, __) => const JobSearchScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.jobDetail,
      builder: (_, __) => const JobDetailScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.jobFilter,
      builder: (_, __) => const JobFilterScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.jobSuggestions,
      builder: (_, __) => const JobSuggestionsScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.savedJobs,
      builder: (_, __) => const SavedJobsScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.appliedJobs,
      builder: (_, __) => const AppliedJobsScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.applyJob,
      builder: (_, __) => const ApplyJobScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.company,
      builder: (_, __) => const CompanyProfileScreen(),
    ),

    // ─── Connections ────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.explore,
      builder: (_, __) => const ExploreScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.friends,
      builder: (_, __) => const FriendsScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.connectFriends,
      builder: (_, __) => const ConnectFriendsScreen(),
    ),

    // ─── Messages ───────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.chat,
      builder: (_, __) => const ChatScreen(),
    ),

    // ─── Notifications ──────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.notifications,
      builder: (_, __) => const NotificationsScreen(),
    ),

    // ─── Events ─────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.events,
      builder: (_, __) => const EventsScreen(),
    ),

    // ─── Mentor ─────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.findMentor,
      builder: (_, __) => const FindMentorScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.mentorProfile,
      builder: (_, __) => const MentorProfileScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.bookMentor,
      builder: (_, __) => const BookMentorScreen(),
    ),

    // ─── Search ─────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.search,
      builder: (_, __) => const SearchScreen(),
    ),

    // ─── Settings ───────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.settings,
      builder: (_, __) => const SettingsScreen(),
    ),

    // ─── Calendar & Guide ───────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.calendar,
      builder: (_, __) => const CalendarScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.guide,
      builder: (_, __) => const GuideScreen(),
    ),

    // ─── Home Extensions ────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutePaths.createPost, // '/create-post'
      builder: (_, __) => const CreatePostScreen(),
    ),
    GoRoute(
      path: AppRoutePaths.comments, // '/comments'
      builder: (_, __) => const CommentsScreen(),
    ),
  ],
);
