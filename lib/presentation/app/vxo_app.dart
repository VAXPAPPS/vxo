import 'package:flutter/material.dart';

import '../../core/theme/vaxp_theme.dart';
import '../pages/vxo_home_page.dart';

class VxoApp extends StatelessWidget {
  const VxoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: VaxpTheme.dark,
      home: const VxoHomePage(),
    );
  }
}
