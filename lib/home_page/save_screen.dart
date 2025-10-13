// lib/home_page.dart DOSYASININ DOĞRU HİZALANMIŞ MENÜLÜ HALİ

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _savedPasswords = const [
    'j=S@oZ&R2I, x',
    'aV+!BTqB(Knv',
    'NMaAdn{P0!wL',
    'diger-sifre-1',
    'diger-sifre-2',
    'diger-sifre-3',
    'diger-sifre-4',
    'diger-sifre-5',
  ];

  String _currentSortOption = 'Latest';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1.0)),
        ),
      ),
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
                    const Text('Saved Passwords',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('View and manage your saved passwords',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 20),
                    for (final password in _savedPasswords)
                      PasswordCard(password: password),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 40.0),
              child: _buildSortButton(),
            ),
          ),
        ],
      ),
    );
  }

  // --- _buildSortButton FONKSİYONUNDAKİ DEĞİŞİKLİK ---
  Widget _buildSortButton() {
    return PopupMenuButton<String>(
      onSelected: (String newValue) {
        setState(() {
          _currentSortOption = newValue;
        });
      },
      color: Colors.white,
      position: PopupMenuPosition.over,

      // --- YENİ EKLENEN SATIR BURASI ---
      // Menüyü yatayda (X ekseninde) 24 birim sağa kaydırarak butonla hizalıyoruz.
      // Dikeyde (Y ekseninde) -10 birim yukarı kaydırarak butonla arasına boşluk koyuyoruz.
      offset: const Offset(0, -215),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(color: Colors.grey[300]!, width: 1.0),
      ),
      elevation: 4,

      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          disabledForegroundColor: Colors.black,
          side: BorderSide(color: Colors.grey[300]!),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.swap_vert, size: 18),
            const SizedBox(width: 8),
            Text(_currentSortOption),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
            value: 'Latest', child: Text('Latest First')),
        const PopupMenuItem<String>(
            value: 'Oldest', child: Text('Oldest First')),
        const PopupMenuItem<String>(
            value: 'By Password', child: Text('By Password (A-Z)')),
        const PopupMenuItem<String>(
            value: 'By Nickname', child: Text('By Nickname (A-Z)')),
      ],
    );
  }
}

class PasswordCard extends StatelessWidget {
  final String password;
  const PasswordCard({super.key, required this.password});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.edit_outlined, size: 18, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text('Add Nickname', style: TextStyle(color: Colors.grey[600]))
          ]),
          const SizedBox(height: 12),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8)),
              child: Text(password,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 12),
          const Text('Length: 12  ·  Oct 13, 2025, 01:55 PM',
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.copy, size: 18),
                    label: const Text('Copy'),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.grey[300]!)))),
            const SizedBox(width: 8),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.star_outline),
                visualDensity: VisualDensity.compact),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                visualDensity: VisualDensity.compact)
          ])
        ],
      ),
    );
  }
}
