import 'package:flutter/material.dart';

class MobilePageFrame extends StatelessWidget {
  final Widget child;

  const MobilePageFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            child: child,
          ),
        ),
      ),
    );
  }
}
