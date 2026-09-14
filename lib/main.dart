import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

// Authentication
import 'package:tongkrongan_umkm_owner_app/screens/auth/login_screen.dart';

// PHASE 1: OWNER / UMKM MANAGEMENT SYSTEM
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_dashboard_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/transaction_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/product_management_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/investment_expenses_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/employee_salary_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/bookkeeping_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/financial_report_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/notifications_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/profile_settings_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/hpp_management_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/admin_chat_list_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/admin_chat_screen.dart';

// PHASE 1B: OWNER ENHANCED FEATURES (Dashboard Enhancement)
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_dashboard_enhanced_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_sales_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_financial_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_product_management_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_hpp_expense_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_analytics_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_order_queue_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/owner/owner_chat_screen.dart';

// PHASE 2: CUSTOMER / CULINARY DISCOVERY EXPERIENCE
import 'package:tongkrongan_umkm_owner_app/screens/customer/customer_onboarding_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/customer_home_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/explore_map_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/category_results_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/detail_warung_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/menu_harga_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/favorit_tersimpan_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/notifikasi_pelanggan_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/customer_profile_screen.dart';

// PHASE 2B: CUSTOMER AUTHENTICATION & NEW FEATURES
import 'package:tongkrongan_umkm_owner_app/screens/customer/customer_login_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/customer_register_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/customer_favorites_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/kedai_detail_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/management_chat_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/customer/customer_reservation_screen.dart';

// PHASE 3: SMART ADVERTISING PLATFORM
import 'package:tongkrongan_umkm_owner_app/screens/advertising/advertising_dashboard_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/advertising/my_campaigns_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/advertising/create_campaign_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/advertising/auto_play_campaign_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/advertising/advertising_calendar_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/advertising/platform_management_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/advertising/creator_marketplace_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/advertising/creator_detail_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/advertising/advertising_analytics_screen.dart';
import 'package:tongkrongan_umkm_owner_app/screens/advertising/campaign_detail_screen.dart';

// PHASE 2.5: ADMIN / OPERATOR MANAGEMENT SYSTEM (10 Screens)
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
      child: TongkronganUMKMOwnerApp(),
    ),
  );
}

class TongkronganUMKMOwnerApp extends StatelessWidget {
  const TongkronganUMKMOwnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TONGkrongan - Ekosistem UMKM & Kuliner',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: [
    // Authentication
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),

    // ==========================================
    // PHASE 1: OWNER / UMKM MANAGEMENT (10 Screens)
    // ==========================================
    GoRoute(
      path: '/owner-dashboard',
      name: 'owner-dashboard',
      builder: (context, state) => const OwnerDashboardScreen(),
    ),
    GoRoute(
      path: '/owner-dashboard-enhanced',
      name: 'owner-dashboard-enhanced',
      builder: (context, state) => const OwnerDashboardEnhancedScreen(),
    ),
    GoRoute(
      path: '/owner-sales',
      name: 'owner-sales',
      builder: (context, state) => const OwnerSalesScreen(),
    ),
    GoRoute(
      path: '/owner-financial',
      name: 'owner-financial',
      builder: (context, state) => const OwnerFinancialScreen(),
    ),
    GoRoute(
      path: '/owner-products',
      name: 'owner-products',
      builder: (context, state) => const OwnerProductManagementScreen(),
    ),
    GoRoute(
      path: '/owner-hpp',
      name: 'owner-hpp',
      builder: (context, state) => const OwnerHPPExpenseScreen(),
    ),
    GoRoute(
      path: '/owner-analytics',
      name: 'owner-analytics',
      builder: (context, state) => const OwnerAnalyticsScreen(),
    ),
    GoRoute(
      path: '/owner-order-queue',
      name: 'owner-order-queue',
      builder: (context, state) => const OwnerOrderQueueScreen(),
    ),
    GoRoute(
      path: '/owner-chat',
      name: 'owner-chat',
      builder: (context, state) => const OwnerChatScreen(),
    ),
    GoRoute(
      path: '/owner-expenses',
      name: 'owner-expenses',
      builder: (context, state) => const OwnerHPPExpenseScreen(),
    ),
    GoRoute(
      path: '/owner-transactions',
      name: 'owner-transactions',
      builder: (context, state) => const OwnerSalesScreen(),
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
    GoRoute(
      path: '/hpp',
      name: 'hpp',
      builder: (context, state) => const HPPManagementScreen(),
    ),
    GoRoute(
      path: '/admin-chat-list',
      name: 'admin-chat-list',
      builder: (context, state) => const AdminChatListScreen(),
    ),
    GoRoute(
      path: '/admin-chat',
      name: 'admin-chat',
      builder: (context, state) => const AdminChatScreen(),
    ),

    // ==========================================
    // PHASE 2: CUSTOMER DISCOVERY (9 Screens)
    // ==========================================
    GoRoute(
      path: '/customer-onboarding',
      name: 'customer-onboarding',
      builder: (context, state) => const CustomerOnboardingScreen(),
    ),
    GoRoute(
      path: '/customer-login',
      name: 'customer-login',
      builder: (context, state) => const CustomerLoginScreen(),
    ),
    GoRoute(
      path: '/customer-register',
      name: 'customer-register',
      builder: (context, state) => const CustomerRegisterScreen(),
    ),
    GoRoute(
      path: '/customer-home',
      name: 'customer-home',
      builder: (context, state) => const CustomerHomeScreen(),
    ),
    GoRoute(
      path: '/customer-favorites',
      name: 'customer-favorites',
      builder: (context, state) => const CustomerFavoritesScreen(),
    ),
    GoRoute(
      path: '/customer-profile',
      name: 'customer-profile',
      builder: (context, state) => const CustomerProfileScreen(),
    ),
    GoRoute(
      path: '/management-chat',
      name: 'management-chat',
      builder: (context, state) => const ManagementChatScreen(),
    ),
    GoRoute(
      path: '/management-chat/:kedaiId',
      name: 'management-chat-kedai',
      builder: (context, state) => ManagementChatScreen(
        kedaiId: state.pathParameters['kedaiId'] ?? '',
      ),
    ),
    GoRoute(
      path: '/customer-reservation/:kedaiId',
      name: 'customer-reservation',
      builder: (context, state) => CustomerReservationScreen(
        kedaiId: state.pathParameters['kedaiId'] ?? '',
      ),
    ),
    GoRoute(
      path: '/kedai-detail/:id',
      name: 'kedai-detail',
      builder: (context, state) => KedaiDetailScreen(
        kedaiId: state.pathParameters['id'] ?? '',
      ),
    ),
    GoRoute(
      path: '/explore-map',
      name: 'explore-map',
      builder: (context, state) => const ExploreMapScreen(),
    ),
    GoRoute(
      path: '/category-results/:category',
      name: 'category-results',
      builder: (context, state) => CategoryResultsScreen(
        categoryName: state.pathParameters['category'] ?? '',
      ),
    ),
    GoRoute(
      path: '/business-detail/:id',
      name: 'business-detail',
      builder: (context, state) => DetailWarungScreen(
        warungId: state.pathParameters['id'] ?? '',
      ),
    ),
    GoRoute(
      path: '/menu-harga/:id',
      name: 'menu-harga',
      builder: (context, state) => MenuHargaScreen(
        warungId: state.pathParameters['id'] ?? '',
      ),
    ),
    GoRoute(
      path: '/customer-notifications',
      name: 'customer-notifications',
      builder: (context, state) => const NotifikasiPelangganScreen(),
    ),

    // ==========================================
    // PHASE 3: SMART ADVERTISING PLATFORM (10 Screens)
    // ==========================================
    GoRoute(
      path: '/advertising-dashboard',
      name: 'advertising-dashboard',
      builder: (context, state) => const AdvertisingDashboardScreen(),
    ),
    GoRoute(
      path: '/my-campaigns',
      name: 'my-campaigns',
      builder: (context, state) => const MyCampaignsScreen(),
    ),
    GoRoute(
      path: '/create-campaign',
      name: 'create-campaign',
      builder: (context, state) => const CreateCampaignScreen(),
    ),
    GoRoute(
      path: '/auto-play',
      name: 'auto-play',
      builder: (context, state) => const AutoPlayCampaignScreen(),
    ),
    GoRoute(
      path: '/advertising-calendar',
      name: 'advertising-calendar',
      builder: (context, state) => const AdvertisingCalendarScreen(),
    ),
    GoRoute(
      path: '/platform-management',
      name: 'platform-management',
      builder: (context, state) => const PlatformManagementScreen(),
    ),
    GoRoute(
      path: '/creator-marketplace',
      name: 'creator-marketplace',
      builder: (context, state) => const CreatorMarketplaceScreen(),
    ),
    GoRoute(
      path: '/creator-detail/:id',
      name: 'creator-detail',
      builder: (context, state) => CreatorDetailScreen(
        creatorId: state.pathParameters['id'] ?? '',
      ),
    ),
    GoRoute(
      path: '/advertising-analytics',
      name: 'advertising-analytics',
      builder: (context, state) => const AdvertisingAnalyticsScreen(),
    ),
    GoRoute(
      path: '/campaign-detail/:id',
      name: 'campaign-detail',
      builder: (context, state) => CampaignDetailScreen(
        campaignId: state.pathParameters['id'] ?? '',
      ),
    ),

    // ==========================================
    // PHASE 2.5: ADMIN / OPERATOR MANAGEMENT (10 Screens)
    // ==========================================
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