import 'package:flutter/material.dart';

import '../../core/theme/vaxp_theme.dart';
import '../../domain/xo_score.dart';

class XoScoreStrip extends StatelessWidget {
  final XoScore score;

  const XoScoreStrip({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return VaxpGlass(
      radius: BorderRadius.circular(22),
      opacity: 0.18,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: _ScoreItem(label: 'X', value: score.xWins),
            ),
            Expanded(
              child: _ScoreItem(label: 'draw', value: score.draws),
            ),
            Expanded(
              child: _ScoreItem(label: 'O', value: score.oWins),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreItem extends StatelessWidget {
  final String label;
  final int value;

  const _ScoreItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value',
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Text(label, style: textTheme.bodyMedium),
      ],
    );
  }
}
