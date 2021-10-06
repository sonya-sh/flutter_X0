import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<List> _matrix;

  HomePageState() {
    initMatrix();
  }

  initMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix[i].length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('X0X0')),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  _buildElement(0, 0),
                  _buildElement(0, 1),
                  _buildElement(0, 2),
                ],
              ),
              Row(
                children: [
                  _buildElement(1, 0),
                  _buildElement(1, 1),
                  _buildElement(1, 2),
                ],
              ),
              Row(
                children: [
                  _buildElement(2, 0),
                  _buildElement(2, 1),
                  _buildElement(2, 2),
                ],
              ),
            ],
          ),
        ));
  }

  String _lastChar = '0';

  _buildElement(int i, int j) {
    return GestureDetector(
      onTap: () {
        _changeMatrixField(i, j);
        _checkWinner(i, j);
      },
      child: Container(
        width: 90.0,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, border: Border.all(color: Colors.black)),
        child: Center(
          child: Text(
            _matrix[i][j],
            style: TextStyle(fontSize: 92.0),
          ),
        ),
      ),
    );
  }

  _changeMatrixField(int i, int j) {
    setState(() {
      if (_matrix[i][j] == ' ') {
        if (_lastChar == '0')
          _matrix[i][j] = 'X';
        else
          _matrix[i][j] = '0';
        _lastChar = _matrix[i][j];
      }
    });
  }

  _checkWinner(int x, int y) {
    var col = 0, row = 0, diag1 = 0, diag2 = 0;
    var n = _matrix.length - 1;
    var player = _matrix[x][y];

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) col++;
      if (_matrix[i][y] == player) row++;
      if (_matrix[i][i] == player) diag1++;
      if (_matrix[i][n - i] == player) diag2++;
    }
    if (row == n + 1 || col == n + 1 || diag1 == n + 1 || diag2 == n + 1) {
      print('$player win');
      initMatrix();
    }
  }
}
