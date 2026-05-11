import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_app_management/features/search/presentation/pages/search_page.dart';

import 'auth/profile_page.dart';
import 'home_page/presentation/pages/home_pages.dart';

final indexBottomNavProvider = StateProvider<int>((ref) => 0);

class IndexPage extends ConsumerWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexBottomNavProvider);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24.sp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 24.sp),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24.sp),
            label: 'Profile',
          ),
        ],
        currentIndex: index,
        onTap: (value) {
          ref.read(indexBottomNavProvider.notifier).state = value;
        },
      ),
      body: _buildBody(index),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const HomePages();
      case 1:
        return const SearchPage();
      case 2:
        return const ProfilePage();
      default:
        return const HomePages();
    }
  }
}
