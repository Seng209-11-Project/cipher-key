import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../save_screen/password_card/add_password_util.dart';
import '../../save_screen/save_screen.dart';
import '../pages/password_generator_page.dart';

class AppNavigationBar extends StatefulWidget {
  final int currentIndex;
  final VoidCallback? onDataChanged;
  const AppNavigationBar({super.key, this.currentIndex = 0, this.onDataChanged});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  static const double _fabSize = 56.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bottom Navigation Bar with notch
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border.all(color: Colors.black12, width: 1),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      LucideIcons.home,
                      size: widget.currentIndex == 0 ? 26 : 22,
                    ),
                    label: 'Generate',
                  ),
                  const BottomNavigationBarItem(
                    icon: SizedBox.shrink(),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      LucideIcons.lock,
                      size: widget.currentIndex == 2 ? 26 : 22,
                    ),
                    label: 'Saved',
                  ),
                ],
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                currentIndex: widget.currentIndex,
                onTap: (int index) {
                if (index == 1) {
                  // Show add password dialog
                  showAddPasswordDialog(context, onSaved: widget.onDataChanged);
                  return;
                }
                  
                  if (widget.currentIndex == index) return;
                  
                  if (index == 0) {
                    // Navigate to Password Generator Page
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const PasswordGeneratorPage()),
                    );
                  } else if (index == 2) {
                    // Navigate to Save Screen
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const SaveScreen()),
                    );
                  }
                },
              ),
            ),
          ),
          
          // Floating Action Button with notch
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - _fabSize / 2,
            top: -_fabSize / 2,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                child: InkWell(
                  borderRadius: BorderRadius.circular(_fabSize / 2),
                  onTap: () => showAddPasswordDialog(context, onSaved: widget.onDataChanged),
                  child: Container(
                    width: _fabSize,
                    height: _fabSize,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
