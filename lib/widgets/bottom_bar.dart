import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key, required this.index});

  int index;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return CrystalNavigationBar(
      currentIndex: widget.index,
      borderRadius: 20,
      marginR: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      unselectedItemColor: Colors.grey.shade700,
      backgroundColor: Colors.grey.withOpacity(0.1),
      enableFloatingNavBar: true,
      curve: Curves.easeInOutQuart,
      indicatorColor: Colors.transparent,
      items: [
        CrystalNavigationBarItem(
          icon: HugeIcons.strokeRoundedHome03,
          selectedColor: Colors.white,
        ),
        CrystalNavigationBarItem(
          icon: HugeIcons.strokeRoundedSearch01,
          selectedColor: Colors.white,
        ),
        CrystalNavigationBarItem(
          icon: HugeIcons.strokeRoundedPlaylist02,
          selectedColor: Colors.white,
        ),
        CrystalNavigationBarItem(
          icon: HugeIcons.strokeRoundedUser,
          selectedColor: Colors.white,
        ),
      ],
      onTap: (indexBar) {
        switch (indexBar) {
          case 0:
            {
              setState(() {
                widget.index = 0;
              });
              if (kDebugMode) {
                print('home page');
              }
            }
          case 1:
            {
              setState(() {
                widget.index = 1;
              });
              if (kDebugMode) {
                print('search page');
              }
            }
          case 2:
            {
              setState(() {
                widget.index = 2;
              });
              if (kDebugMode) {
                print('playlist page');
              }
            }
          case 3:
            {
              setState(() {
                widget.index = 3;
              });
              if (kDebugMode) {
                print('acc page');
              }
            }

          default:
            if (kDebugMode) {
              print('');
            }
        }
      },
    );
  }
}
