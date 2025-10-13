import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: Colors.black12,
                    width: 1
                )
            )
        ),
        child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashFactory: NoSplash.splashFactory,
            ),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(LucideIcons.home),label: 'Generate'),
                BottomNavigationBarItem(icon: Icon(LucideIcons.lock),label: 'Saved'),
              ],
              selectedItemColor: Colors.black,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )
        )
    );
  }
}