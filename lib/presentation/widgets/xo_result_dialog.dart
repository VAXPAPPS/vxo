import 'package:flutter/material.dart';

import '../../domain/xo_game_state.dart';

class XoResultDialog extends StatelessWidget {
  final XoGameState state;
  final VoidCallback onNewRound;
  final VoidCallback onResetScores;

  const XoResultDialog({
    super.key,
    required this.state,
    required this.onNewRound,
    required this.onResetScores,
  });

  @override
  Widget build(BuildContext context) {
    final title = state.winner == null
        ? 'draw'
        : 'The player won ${state.winner!.symbol}';
    final content = state.winner == null
        ? 'The round ended in a draw.'
        : 'Great result. Shall we start a new round?';

    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: Text(content, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        OutlinedButton.icon(
          onPressed: onResetScores,
          icon: const Icon(Icons.restart_alt_rounded),
          label: const Text('Reset Scores'),
        ),
        ElevatedButton.icon(
          onPressed: onNewRound,
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('New Round'),
        ),
      ],
    );
  }
}
