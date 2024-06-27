import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayXO = List.filled(9, '');
  bool xTurn = true;
  int xScore = 0;
  int oScore = 0;

  void _tapped(int index) {
    setState(() {
      if (displayXO[index] == '') {
        displayXO[index] = xTurn ? 'X' : 'O';
        xTurn = !xTurn;
        _checkWinner();
      }
    });
  }

  void _showWinDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('WINNER!'),
          content: Text('$winner is the winner!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Play Again'),
              onPressed: () {
                Navigator.of(context).pop();
                _resetBoard();
              },
            )
          ],
        );
      },
    ).then((_) {
      _resetBoard();
    });

    // Update score
    if (winner == 'X') {
      xScore++;
    } else {
      oScore++;
    }
  }

  void _checkWinner() {
    // Check for a winner
    if (displayXO[0] == displayXO[1] &&
        displayXO[1] == displayXO[2] &&
        displayXO[0] != "") {
      _showWinDialog(displayXO[0]);
    } else if (displayXO[3] == displayXO[4] &&
        displayXO[4] == displayXO[5] &&
        displayXO[3] != "") {
      _showWinDialog(displayXO[3]);
    } else if (displayXO[6] == displayXO[7] &&
        displayXO[7] == displayXO[8] &&
        displayXO[6] != "") {
      _showWinDialog(displayXO[6]);
    } else if (displayXO[0] == displayXO[3] &&
        displayXO[3] == displayXO[6] &&
        displayXO[0] != "") {
      _showWinDialog(displayXO[0]);
    } else if (displayXO[1] == displayXO[4] &&
        displayXO[4] == displayXO[7] &&
        displayXO[1] != "") {
      _showWinDialog(displayXO[1]);
    } else if (displayXO[2] == displayXO[5] &&
        displayXO[5] == displayXO[8] &&
        displayXO[2] != "") {
      _showWinDialog(displayXO[2]);
    } else if (displayXO[0] == displayXO[4] &&
        displayXO[4] == displayXO[8] &&
        displayXO[0] != "") {
      _showWinDialog(displayXO[0]);
    } else if (displayXO[2] == displayXO[4] &&
        displayXO[4] == displayXO[6] &&
        displayXO[2] != "") {
      _showWinDialog(displayXO[2]);
    } else if (!displayXO.contains('')) {
      // If no winner and no empty cells, it's a draw
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Draw!'),
            content: const Text('It\'s a draw!'),
            actions: <Widget>[
              TextButton(
                child: const Text('Play Again'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _resetBoard();
                },
              )
            ],
          );
        },
      );
      _resetBoard();
    }
  }

  void _resetBoard() {
    setState(() {
      displayXO = List.filled(9, '');
      xTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double boxSize = (constraints.maxWidth - 48) / 3;
            double fontSize = boxSize / 2;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const Text('Player X',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                          Text('$xScore',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const Text('Player O',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24)),
                          Text('$oScore',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24)),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(4.0),
                        itemCount: 9,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => _tapped(index),
                            child: Container(
                              width: boxSize,
                              height: boxSize,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[700]!),
                              ),
                              child: Center(
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    double maxFontSize =
                                        constraints.maxWidth / 2;
                                    return Text(
                                      displayXO[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize > maxFontSize
                                            ? maxFontSize
                                            : fontSize,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
