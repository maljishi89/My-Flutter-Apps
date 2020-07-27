import 'package:flutter/material.dart';
import 'package:tictacgame/pages/tictac.dart';
import 'tictac.dart';
import 'package:tictacgame/pages/gameplayController.dart';

class GamePlay extends StatefulWidget {
  @override
  _GamePlayState createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  List<TicTac> ticTacGame;
  bool chosen = false;
  bool player1 = true;
  String player1Choice = '';
  bool player2 = false;
  String player2Choice = '';
  String xo = '';

  Color oColor = Colors.greenAccent[400];
  Color xColor = Colors.blueAccent;

  List<Widget> createGameButtons() {
    int x = 0;
    Widget gameArea;
    final List<Widget> buttons = new List<Widget>.generate(10, (index) {
      return ticButton(index);
    });
    final List<Widget> expandedButtons = new List<Widget>.generate(9, (index) {
      return Expanded(
        child: buttons[index],
        flex: 3,
      );
    });
    x = 0;
    final List<Widget> rows = new List<Widget>.generate(3, (index) {
      Row row = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: expandedButtons.sublist(x, x + 3));
      x += 3;
      return row;
    });

    return rows;
  }

  bool checkWinner(List<TicTac> list) {
    return (GamePlayController().hlineWin(list) ||
        GamePlayController().vlineWin(list) ||
        GamePlayController().crossWin(list));
  }

  Widget ticButton(int index) {
    return Container(
      margin: EdgeInsets.all(0),
      child: ButtonTheme(
        height: 120.0,
        buttonColor: Colors.white,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          onPressed: () {
            if (chosen) {
              setState(() {
                ticTacGame[index].xo = '' + xo;
                if (xo.contains('X')) {
                  ticTacGame[index].xoChosen = 1;
                  xColor = Colors.blueAccent;
                } else if (xo.contains('O')) {
                  ticTacGame[index].xoChosen = 0;
                  oColor = Colors.greenAccent[400];
                }
                chosen = !chosen;
                if (checkWinner(ticTacGame)) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('We have a winner'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('Ok'))
                          ],
                          elevation: 24.0,
                        );
                      });
                }
              });
            }
          },
          child: Text(
            '${ticTacGame[index].xo}',
            style: TextStyle(fontSize: 60.0, color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    ticTacGame = new List<TicTac>(11);
    for (int i = 0; i < 10; i++) {
      ticTacGame[i] = new TicTac();
    }
    int c = 1;
    int r = 1;
    for (int i = 0; i < 9; i++) {
      ticTacGame[i].index = i;
      ticTacGame[i].column = c;
      ticTacGame[i].row = r;
      ++c;
      if (c == 4) {
        ++r;
        c = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: Text('In Game'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Choose X or O',
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  height: 75.0,
                  buttonColor: xColor,
                  child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          xColor = Colors.blueAccent[
                              700]; //------------------------------------------
                          chosen = !chosen;
                          xo = 'X';
                        });
                      },
                      child: Text(
                        'X',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0),
                      )),
                ),
                ButtonTheme(
                  height: 75.0,
                  buttonColor: Colors.greenAccent,
                  child: RaisedButton(
                      onPressed: () {
                        setState(
                          () {
                            oColor = Colors.greenAccent[700];
                            chosen = !chosen;
                            xo = 'O';
                          },
                        );
                      },
                      color: oColor,
                      child: Text(
                        'O',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40.0),
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: createGameButtons(),
                // the widget of the game
              ),
            ),
          ],
        ),
      ),
    );
  }
}
