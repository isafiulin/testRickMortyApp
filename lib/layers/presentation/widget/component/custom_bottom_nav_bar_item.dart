import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testrickmortyapp/layers/core/theme/color.dart';

class CustomBottomNavBarItem {
  BottomNavigationBarItem getItem({
    final String? title,
    required final int selectedIndex,
    final String? activeImageName,
    final String? inActiveImageName,
    required final int itemIndex,
  }) {
    return BottomNavigationBarItem(
      label: title ?? '',
      icon: activeImageName != null && inActiveImageName != null
          ? Container(
              decoration: BoxDecoration(
                  color: selectedIndex == itemIndex
                      ? ColorConstant.greenPrimary
                      : Colors.transparent,
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  selectedIndex == itemIndex
                      ? activeImageName
                      : inActiveImageName,
                  colorFilter: ColorFilter.mode(
                      selectedIndex == itemIndex
                          ? ColorConstant.primary
                          : Colors.white,
                      BlendMode.srcIn),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
