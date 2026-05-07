import 'package:flutter/foundation.dart';

import '../domain/xo_game_state.dart';
import '../domain/xo_mark.dart';
import '../domain/xo_round_evaluator.dart';
import '../domain/xo_score.dart';

class XoGameController extends ChangeNotifier {
  final XoRoundEvaluator _evaluator;

  XoGameState _state = XoGameState.initial();
  bool _resultDialogPending = false;

  XoGameController({XoRoundEvaluator evaluator = const XoRoundEvaluator()})
    : _evaluator = evaluator;

  XoGameState get state => _state;

  bool consumeResultDialogRequest() {
    if (!_resultDialogPending) return false;
    _resultDialogPending = false;
    return true;
  }

  void playCell(int index) {
    if (index < 0 || index >= _state.board.length) return;
    if (_state.board[index] != null || _state.roundFinished) return;

    final board = List<XoMark?>.of(_state.board);
    board[index] = _state.currentPlayer;

    final result = _evaluator.evaluate(board);
    var score = _state.score;

    if (result.winner != null) {
      score = score.addWin(result.winner!);
    } else if (result.isDraw) {
      score = score.addDraw();
    }

    _resultDialogPending = result.isFinished && _state.resultDialogEnabled;

    _state = _state.copyWith(
      board: board,
      currentPlayer: result.isFinished
          ? _state.currentPlayer
          : _state.currentPlayer.next,
      winner: result.winner,
      winningCells: result.winningCells,
      score: score,
      roundFinished: result.isFinished,
    );
    notifyListeners();
  }

  void startNewRound() {
    final nextStarter = _state.startingPlayer.next;

    _state = _state.copyWith(
      board: List<XoMark?>.filled(9, null),
      currentPlayer: nextStarter,
      startingPlayer: nextStarter,
      winningCells: const [],
      roundFinished: false,
      clearWinner: true,
    );
    _resultDialogPending = false;
    notifyListeners();
  }

  void restartRound() {
    _state = _state.copyWith(
      board: List<XoMark?>.filled(9, null),
      currentPlayer: _state.startingPlayer,
      winningCells: const [],
      roundFinished: false,
      clearWinner: true,
    );
    _resultDialogPending = false;
    notifyListeners();
  }

  void resetScores() {
    _state = _state.copyWith(
      board: List<XoMark?>.filled(9, null),
      currentPlayer: _state.startingPlayer,
      winningCells: const [],
      score: const XoScore(),
      roundFinished: false,
      clearWinner: true,
    );
    _resultDialogPending = false;
    notifyListeners();
  }

  void setStartingPlayer(XoMark mark) {
    _state = _state.copyWith(
      board: List<XoMark?>.filled(9, null),
      currentPlayer: mark,
      startingPlayer: mark,
      winningCells: const [],
      roundFinished: false,
      clearWinner: true,
    );
    _resultDialogPending = false;
    notifyListeners();
  }

  void setResultDialogEnabled(bool enabled) {
    _state = _state.copyWith(resultDialogEnabled: enabled);
    notifyListeners();
  }
}
