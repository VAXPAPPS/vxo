import 'package:flutter/material.dart';

import '../../application/xo_game_controller.dart';
import '../../core/theme/vaxp_theme.dart';
import '../widgets/xo_header_panel.dart';
import '../widgets/xo_score_strip.dart';

class XoHomeMenuPage extends StatelessWidget {
  final XoGameController controller;
  final VoidCallback onStart;
  final VoidCallback onSettings;
  final VoidCallback onStats;

  const XoHomeMenuPage({
    super.key,
    required this.controller,
    required this.onStart,
    required this.onSettings,
    required this.onStats,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final state = controller.state;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const XoHeaderPanel(
                title: 'XO',
                subtitle: 'لاعب ضد لاعب',
                icon: Icons.grid_3x3_rounded,
              ),
              const SizedBox(height: 14),
              XoScoreStrip(score: state.score),
              const SizedBox(height: 18),
              VaxpGlass(
                radius: BorderRadius.circular(24),
                opacity: 0.16,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        onPressed: onStart,
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('بدء اللعب'),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: onStats,
                        icon: const Icon(Icons.query_stats_rounded),
                        label: const Text('الإحصائيات'),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: onSettings,
                        icon: const Icon(Icons.tune_rounded),
                        label: const Text('الإعدادات'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
