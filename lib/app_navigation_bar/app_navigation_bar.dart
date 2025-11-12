import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../main.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black12, width: 1))
        ),
        child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Generate'),
                BottomNavigationBarItem(icon: Icon(LucideIcons.lock), label: 'Saved'),
                BottomNavigationBarItem(icon: Icon(LucideIcons.settings), label: 'Settings'),
              ],
              selectedItemColor: Colors.black,
              currentIndex: selectedIndex.value,
              onTap: (int index) {
                setState(() {
                  selectedIndex.value = index;
                });
              },
            )
        )
    );
  }
}