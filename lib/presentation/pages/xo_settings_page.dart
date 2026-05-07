import 'package:flutter/material.dart';

import '../../application/xo_game_controller.dart';
import '../../core/theme/vaxp_theme.dart';
import '../../domain/xo_mark.dart';
import '../widgets/xo_header_panel.dart';

class XoSettingsPage extends StatelessWidget {
  final XoGameController controller;
  final VoidCallback onBack;

  const XoSettingsPage({
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
        final state = controller.state;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const XoHeaderPanel(
                title: 'XO',
                subtitle: 'Game settings',
                icon: Icons.tune_rounded,
              ),
              const SizedBox(height: 14),
              VaxpGlass(
                radius: BorderRadius.circular(24),
                opacity: 0.16,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Starting Player',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 10),
                      SegmentedButton<XoMark>(
                        segments: const [
                          ButtonSegment(value: XoMark.x, label: Text('X')),
                          ButtonSegment(value: XoMark.o, label: Text('O')),
                        ],
                        selected: {state.startingPlayer},
                        onSelectionChanged: (selection) {
                          controller.setStartingPlayer(selection.first);
                        },
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: state.resultDialogEnabled,
                        onChanged: controller.setResultDialogEnabled,
                        title: const Text('Result Dialog'),
                        secondary: const Icon(Icons.open_in_new_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  IconButton.filledTonal(
                    onPressed: onBack,
                    tooltip: 'Home',
                    icon: Icon(Icons.arrow_back_rounded, color: textColor),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: controller.restartRound,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Restart Round'),
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
