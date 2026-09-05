import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

// PHASE 1: OWNER/UMKM Management System Screens
import 'package:tongkrongan_umkm_owner_app/screens/auth/login_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_dashboard_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/transaction_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/product_management_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/investment_expenses_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/employee_salary_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/bookkeeping_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/financial_report_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/notifications_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/profile_settings_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TongkronganUMKMOwnerApp(),
    ),
  );
}

class TongkronganUMKMOwnerApp extends StatelessWidget {
  const TongkronganUMKMOwnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TONGkrongan UMKM Owner',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    // Authentication Routes
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    
    // PHASE 1: OWNER/UMKM Management System Routes
    GoRoute(
      path: '/owner-dashboard',
      name: 'owner-dashboard',
      builder: (context, state) => const OwnerDashboardScreen(),
    ),
    GoRoute(
      path: '/transactions',
      name: 'transactions',
      builder: (context, state) => const TransactionScreen(),
    ),
    GoRoute(
      path: '/products',
      name: 'products',
      builder: (context, state) => const ProductManagementScreen(),
    ),
    GoRoute(
      path: '/expenses',
      name: 'expenses',
      builder: (context, state) => const InvestmentExpensesScreen(),
    ),
    GoRoute(
      path: '/employees',
      name: 'employees',
      builder: (context, state) => const EmployeeSalaryScreen(),
    ),
    GoRoute(
      path: '/bookkeeping',
      name: 'bookkeeping',
      builder: (context, state) => const BookkeepingScreen(),
    ),
    GoRoute(
      path: '/reports',
      name: 'reports',
      builder: (context, state) => const FinancialReportScreen(),
    ),
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileSettingsScreen(),
    ),
  ],
);