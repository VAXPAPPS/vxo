import 'package:flutter/material.dart';

import '../../application/xo_game_controller.dart';
import '../../core/venom_layout.dart';
import '../widgets/mobile_page_frame.dart';
import 'xo_game_page.dart';
import 'xo_home_menu_page.dart';
import 'xo_settings_page.dart';
import 'xo_stats_page.dart';

enum VxoPage { home, game, settings, stats }

class VxoHomePage extends StatefulWidget {
  const VxoHomePage({super.key});

  @override
  State<VxoHomePage> createState() => _VxoHomePageState();
}

class _VxoHomePageState extends State<VxoHomePage> {
  final XoGameController _controller = XoGameController();
  VxoPage _page = VxoPage.home;

  String get _title {
    return switch (_page) {
      VxoPage.home => 'VXO',
      VxoPage.game => 'اللعبة',
      VxoPage.settings => 'الإعدادات',
      VxoPage.stats => 'الإحصائيات',
    };
  }

  void _open(VxoPage page) {
    setState(() => _page = page);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VenomScaffold(
      title: _title,
      body: MobilePageFrame(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeOutCubic,
          child: switch (_page) {
            VxoPage.home => XoHomeMenuPage(
              key: const ValueKey('home'),
              controller: _controller,
              onStart: () => _open(VxoPage.game),
              onSettings: () => _open(VxoPage.settings),
              onStats: () => _open(VxoPage.stats),
            ),
            VxoPage.game => XoGamePage(
              key: const ValueKey('game'),
              controller: _controller,
              onBack: () => _open(VxoPage.home),
              onSettings: () => _open(VxoPage.settings),
              onStats: () => _open(VxoPage.stats),
            ),
            VxoPage.settings => XoSettingsPage(
              key: const ValueKey('settings'),
              controller: _controller,
              onBack: () => _open(VxoPage.home),
            ),
            VxoPage.stats => XoStatsPage(
              key: const ValueKey('stats'),
              controller: _controller,
              onBack: () => _open(VxoPage.home),
            ),
          },
        ),
      ),
    );
  }
}
