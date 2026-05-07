import 'package:flutter/material.dart';

import '../../core/theme/vaxp_theme.dart';

class XoHeaderPanel extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const XoHeaderPanel({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return VaxpGlass(
      radius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.displayLarge?.copyWith(
                      fontSize: 44,
                      height: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: textTheme.headlineMedium?.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
            if (icon != null) Icon(icon, size: 34),
          ],
        ),
      ),
    );
  }
}
