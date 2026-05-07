import 'package:flutter/material.dart';

import '../../core/theme/vaxp_theme.dart';
import '../../domain/xo_mark.dart';

class XoBoard extends StatelessWidget {
  final List<XoMark?> board;
  final List<int> winningCells;
  final ValueChanged<int> onCellTap;

  const XoBoard({
    super.key,
    required this.board,
    required this.winningCells,
    required this.onCellTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: VaxpGlass(
        radius: BorderRadius.circular(26),
        opacity: 0.16,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: board.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return _BoardCell(
                value: board[index]?.symbol ?? '',
                isWinning: winningCells.contains(index),
                onTap: () => onCellTap(index),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BoardCell extends StatelessWidget {
  final String value;
  final bool isWinning;
  final VoidCallback onTap;

  const _BoardCell({
    required this.value,
    required this.isWinning,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white;

    return Material(
      color: Colors.white.withValues(alpha: isWinning ? 0.22 : 0.08),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: AnimatedScale(
          scale: value.isEmpty ? 1 : 0.94,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: Text(
                value,
                key: ValueKey(value),
                style: TextStyle(
                  color: color,
                  fontSize: 48,
                  height: 1,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
