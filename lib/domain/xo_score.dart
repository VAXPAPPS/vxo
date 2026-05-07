import 'xo_mark.dart';

class XoScore {
  final int xWins;
  final int oWins;
  final int draws;

  const XoScore({this.xWins = 0, this.oWins = 0, this.draws = 0});

  int get totalRounds => xWins + oWins + draws;

  XoScore addWin(XoMark mark) {
    return switch (mark) {
      XoMark.x => copyWith(xWins: xWins + 1),
      XoMark.o => copyWith(oWins: oWins + 1),
    };
  }

  XoScore addDraw() => copyWith(draws: draws + 1);

  XoScore copyWith({int? xWins, int? oWins, int? draws}) {
    return XoScore(
      xWins: xWins ?? this.xWins,
      oWins: oWins ?? this.oWins,
      draws: draws ?? this.draws,
    );
  }
}
