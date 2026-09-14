import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

// Admin screens only for testing
import 'package:tongkrongan_umkm_owner_app/screens/admin/admin_login_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/admin/admin_dashboard_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/admin/admin_kedai_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/admin/admin_products_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/admin/admin_content_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/admin/admin_promo_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/admin/admin_appointments_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/admin/admin_chat_support_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/admin/admin_social_media_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AdminTestApp(),
    ),
  );
}

class AdminTestApp extends StatelessWidget {
  const AdminTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Admin Testing - Tongkrongan UMKM',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/admin-dashboard',
  routes: [
    // Admin Routes Only
    GoRoute(
      path: '/admin-login',
      name: 'admin-login',
      builder: (context, state) => const AdminLoginScreen(),
    ),
    GoRoute(
      path: '/admin-dashboard',
      name: 'admin-dashboard',
      builder: (context, state) => const AdminDashboardScreen(),
    ),
    GoRoute(
      path: '/admin-kedai',
      name: 'admin-kedai',
      builder: (context, state) => const AdminKedaiScreen(),
    ),
    GoRoute(
      path: '/admin-products',
      name: 'admin-products',
      builder: (context, state) => const AdminProductsScreen(),
    ),
    GoRoute(
      path: '/admin-content',
      name: 'admin-content',
      builder: (context, state) => const AdminContentScreen(),
    ),
    GoRoute(
      path: '/admin-promo',
      name: 'admin-promo',
      builder: (context, state) => const AdminPromoScreen(),
    ),
    GoRoute(
      path: '/admin-appointments',
      name: 'admin-appointments',
      builder: (context, state) => const AdminAppointmentsScreen(),
    ),
    GoRoute(
      path: '/admin-chat-support',
      name: 'admin-chat-support',
      builder: (context, state) => const AdminChatSupportScreen(),
    ),
    GoRoute(
      path: '/admin-social-media',
      name: 'admin-social-media',
      builder: (context, state) => const AdminSocialMediaScreen(),
    ),
  ],
);