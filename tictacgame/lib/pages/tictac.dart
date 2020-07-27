class TicTac {
  int index;
  int column;
  int row;
  int xoChosen;
  String xo;
  bool chosen;

  // 1 for x, 0 for O in rows and column
  TicTac() {
    this.index = 0;
    this.xoChosen = -1;
    this.column = 0;
    this.row = 0;
    this.xo = '';
    this.chosen = false;
  }
}
