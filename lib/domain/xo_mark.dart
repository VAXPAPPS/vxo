enum XoMark {
  x('X'),
  o('O');

  final String symbol;

  const XoMark(this.symbol);

  XoMark get next => this == XoMark.x ? XoMark.o : XoMark.x;
}
