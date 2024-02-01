// ignore_for_file: avoid_void_async

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testrickmortyapp/layers/core/theme/color.dart';
import 'package:testrickmortyapp/layers/presentation/widget/component/custom_bottom_nav_bar_item.dart';

class MainTabScreen extends StatelessWidget {
  MainTabScreen(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;
  final CustomBottomNavBarItem customBottomNavBarItem =
      CustomBottomNavBarItem();

  @override
  Widget build(BuildContext context) => Scaffold(
      body: navigationShell, bottomNavigationBar: _bottomNavigationBarWidget());

  Widget _bottomNavigationBarWidget() => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          child: BottomNavigationBar(
            onTap: _onDestinationSelected,
            backgroundColor: ColorConstant.primary,
            currentIndex: navigationShell.currentIndex,
            iconSize: 30,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: Colors.green,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: [
              customBottomNavBarItem.getItem(
                title: 'Characters',
                selectedIndex: navigationShell.currentIndex,
                itemIndex: 0,
              ),
              customBottomNavBarItem.getItem(
                title: 'Episodes',
                selectedIndex: navigationShell.currentIndex,
                itemIndex: 1,
              ),
            ],
          ),
        ),
      );

  void _onDestinationSelected(int index) async {
    navigationShell.goBranch(index,
        initialLocation: index == navigationShell.currentIndex);
  }
}
