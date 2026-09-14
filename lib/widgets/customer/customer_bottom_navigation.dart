import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tongkrongan_umkm_owner_app/theme/app_theme.dart';

class CustomerBottomNavigation extends StatelessWidget {
  final String currentLocation;

  const CustomerBottomNavigation({
    Key? key,
    required this.currentLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'label': 'Beranda',
        'icon': Icons.home,
        'route': '/customer-home',
      },
      {
        'label': 'Favorit',
        'icon': Icons.bookmark,
        'route': '/customer-favorites',
      },
      {
        'label': 'Chat',
        'icon': Icons.message,
        'route': '/management-chat',
      },
      {
        'label': 'Profil',
        'icon': Icons.person,
        'route': '/customer-profile',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _getCurrentIndex(items),
        onTap: (index) {
          final route = items[index]['route'] as String;
          if (currentLocation != route) {
            context.go(route);
          }
        },
        items: items
            .map((item) => BottomNavigationBarItem(
                  icon: Icon(item['icon'] as IconData),
                  label: item['label'] as String,
                ))
            .toList(),
      ),
    );
  }

  int _getCurrentIndex(List<Map<String, dynamic>> items) {
    for (int i = 0; i < items.length; i++) {
      if (currentLocation.startsWith(items[i]['route'] as String)) {
        return i;
      }
    }
    return 0;
  }
}
