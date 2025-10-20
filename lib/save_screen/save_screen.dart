import 'package:flutter/material.dart';
import 'package:test_group_project/save_screen/save_read_function.dart';
import 'package:test_group_project/save_screen/password_card/password_card.dart';
import 'package:test_group_project/save_screen/sort_button/sort_button.dart';
// import 'package:test_group_project/save_screen/password_card/add_password_util.dart';
import 'package:password_generator/widgets/app_navigation_bar.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  Map<String, String> _savedPasswords = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Load secure storage passwords with metadata
    final stored = await readPasswords();
    setState(() {
      _savedPasswords = stored;
    });
  }

  Future<void> _refreshData() async {
    await _loadData();
  }

  Future<void> _deletePassword(String passwordId) async {
    await deletePasswordById(passwordId);
    await _refreshData();
  }

  Widget _buildNavigationBar() {
    return AppNavigationBar(
      currentIndex: 2,
      onDataChanged: _refreshData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildNavigationBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: SizedBox(
                width: 672,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Saved Passwords',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'View and manage your saved passwords',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_savedPasswords.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Icon(Icons.lock_outline, size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                'No saved passwords yet',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Generate and save passwords to see them here',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ..._savedPasswords.entries.map((entry) {
                        final String passwordId = entry.key;
                        final String passwordData = entry.value;
                        return PasswordCard(
                          passwordName: passwordData.nickname,
                          password: passwordData.password,
                          dateText: passwordData.datetime,
                          onDelete: () => _deletePassword(passwordId),
                        );
                      }),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 40.0),
              child: SortButton()
            ),
          ),
        ],
      ),
    );
  }
}

// Keep bottom nav consistent when SaveScreen is shown directly
class _BottomNavProxy extends StatelessWidget {
  const _BottomNavProxy();

  @override
  Widget build(BuildContext context) {
    // Import deferred to avoid cycle
    // ignore: no_library_prefixes
    return const SizedBox.shrink();
  }
}


