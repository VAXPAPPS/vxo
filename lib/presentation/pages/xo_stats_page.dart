import 'package:flutter/material.dart';

import '../../application/xo_game_controller.dart';
import '../../core/theme/vaxp_theme.dart';
import '../widgets/xo_header_panel.dart';

class XoStatsPage extends StatelessWidget {
  final XoGameController controller;
  final VoidCallback onBack;

  const XoStatsPage({
    super.key,
    required this.controller,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final score = controller.state.score;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const XoHeaderPanel(
                title: 'XO',
                subtitle: 'سجل الجلسة',
                icon: Icons.query_stats_rounded,
              ),
              const SizedBox(height: 14),
              VaxpGlass(
                radius: BorderRadius.circular(24),
                opacity: 0.16,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      _StatRow(label: 'انتصارات X', value: score.xWins),
                      const Divider(height: 22),
                      _StatRow(label: 'انتصارات O', value: score.oWins),
                      const Divider(height: 22),
                      _StatRow(label: 'التعادلات', value: score.draws),
                      const Divider(height: 22),
                      _StatRow(label: 'عدد الجولات', value: score.totalRounds),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: onBack,
                    tooltip: 'الرئيسية',
                    icon: Icon(Icons.arrow_back_rounded, color: textColor),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: controller.resetScores,
                      icon: const Icon(Icons.delete_sweep_rounded),
                      label: const Text('تصفير النتائج'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final int value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(child: Text(label, style: textTheme.bodyLarge)),
        Text(
          '$value',
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
