// import 'package:flutter/material.dart';
// import 'package:password_generator/pages/password_generator_page.dart';

// void main() {
//   runApp(const PasswordGeneratorApp());
// }

// class PasswordGeneratorApp extends StatelessWidget {
//   const PasswordGeneratorApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: PasswordGeneratorPage(),
//     );
//   }
// }

// import '../utils/app_data.dart';

// class AnotherPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Text('Last Nickname: ${AppData.lastSavedNickname ?? "None"}'),
//             Text('Last Save Time: ${AppData.lastSavedDateTime ?? "None"}'),
//           ],
//         ),
//       ),
//     );
//   }
// }