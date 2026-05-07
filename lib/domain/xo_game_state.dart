import 'xo_mark.dart';
import 'xo_score.dart';

class XoGameState {
  final List<XoMark?> board;
  final XoMark currentPlayer;
  final XoMark startingPlayer;
  final XoMark? winner;
  final List<int> winningCells;
  final XoScore score;
  final bool roundFinished;
  final bool resultDialogEnabled;

  const XoGameState({
    required this.board,
    required this.currentPlayer,
    required this.startingPlayer,
    required this.winner,
    required this.winningCells,
    required this.score,
    required this.roundFinished,
    required this.resultDialogEnabled,
  });

  factory XoGameState.initial() {
    return XoGameState(
      board: List<XoMark?>.filled(9, null),
      currentPlayer: XoMark.x,
      startingPlayer: XoMark.x,
      winner: null,
      winningCells: const [],
      score: const XoScore(),
      roundFinished: false,
      resultDialogEnabled: true,
    );
  }

  bool get isDraw => roundFinished && winner == null;

  String get statusText {
    if (winner != null) return 'winner ${winner!.symbol}';
    if (isDraw) return 'draw';
    return 'player ${currentPlayer.symbol}\'s turn';
  }

  XoGameState copyWith({
    List<XoMark?>? board,
    XoMark? currentPlayer,
    XoMark? startingPlayer,
    XoMark? winner,
    List<int>? winningCells,
    XoScore? score,
    bool? roundFinished,
    bool? resultDialogEnabled,
    bool clearWinner = false,
  }) {
    return XoGameState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      startingPlayer: startingPlayer ?? this.startingPlayer,
      winner: clearWinner ? null : winner ?? this.winner,
      winningCells: winningCells ?? this.winningCells,
      score: score ?? this.score,
      roundFinished: roundFinished ?? this.roundFinished,
      resultDialogEnabled: resultDialogEnabled ?? this.resultDialogEnabled,
    );
  }
}
