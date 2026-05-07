import 'package:flutter/material.dart';

import '../../application/xo_game_controller.dart';
import '../widgets/xo_board.dart';
import '../widgets/xo_header_panel.dart';
import '../widgets/xo_result_dialog.dart';
import '../widgets/xo_score_strip.dart';

class XoGamePage extends StatefulWidget {
  final XoGameController controller;
  final VoidCallback onBack;
  final VoidCallback onSettings;
  final VoidCallback onStats;

  const XoGamePage({
    super.key,
    required this.controller,
    required this.onBack,
    required this.onSettings,
    required this.onStats,
  });

  @override
  State<XoGamePage> createState() => _XoGamePageState();
}

class _XoGamePageState extends State<XoGamePage> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void didUpdateWidget(covariant XoGamePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller == widget.controller) return;

    oldWidget.controller.removeListener(_handleControllerChange);
    widget.controller.addListener(_handleControllerChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleControllerChange);
    super.dispose();
  }

  void _handleControllerChange() {
    if (!widget.controller.consumeResultDialogRequest()) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return XoResultDialog(
            state: widget.controller.state,
            onResetScores: () {
              Navigator.of(context).pop();
              widget.controller.resetScores();
            },
            onNewRound: () {
              Navigator.of(context).pop();
              widget.controller.startNewRound();
            },
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final state = widget.controller.state;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              XoHeaderPanel(title: 'XO', subtitle: state.statusText),
              const SizedBox(height: 14),
              XoScoreStrip(score: state.score),
              const SizedBox(height: 18),
              XoBoard(
                board: state.board,
                winningCells: state.winningCells,
                onCellTap: widget.controller.playCell,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: widget.onBack,
                    tooltip: 'Home',
                    icon: Icon(Icons.arrow_back_rounded, color: textColor),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: widget.controller.restartRound,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Restart Round'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton.filledTonal(
                    onPressed: widget.onStats,
                    tooltip: 'Statistics',
                    icon: Icon(Icons.query_stats_rounded, color: textColor),
                  ),
                  const SizedBox(width: 10),
                  IconButton.filledTonal(
                    onPressed: widget.onSettings,
                    tooltip: 'Settings',
                    icon: Icon(Icons.tune_rounded, color: textColor),
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
