import 'xo_mark.dart';

class XoRoundResult {
  final XoMark? winner;
  final List<int> winningCells;
  final bool isDraw;

  const XoRoundResult({
    this.winner,
    this.winningCells = const [],
    this.isDraw = false,
  });

  bool get isFinished => winner != null || isDraw;
}

class XoRoundEvaluator {
  static const winningLines = <List<int>>[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  const XoRoundEvaluator();

  XoRoundResult evaluate(List<XoMark?> board) {
    for (final line in winningLines) {
      final first = board[line[0]];
      if (first == null) continue;

      if (board[line[1]] == first && board[line[2]] == first) {
        return XoRoundResult(winner: first, winningCells: line);
      }
    }

    if (board.every((cell) => cell != null)) {
      return const XoRoundResult(isDraw: true);
    }

    return const XoRoundResult();
  }
}
