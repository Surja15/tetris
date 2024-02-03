import 'dart:ui';

enum Direction{
  left, right, down,

}
//grid dimensions
int rowLength=10, colLength=15;


enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T,    //different styles of tetris pieces.
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color.fromARGB(255, 255, 148, 41),  // soft orange
  Tetromino.J: Color(0xFF6699FF),  // soft blue
  Tetromino.I: Color(0xFF66CCCC),  // soft cyan
  Tetromino.O: Color.fromARGB(255, 255, 255, 84),  // soft yellow
  Tetromino.S: Color.fromARGB(255, 109, 231, 109),  // soft green
  Tetromino.Z: Color.fromARGB(255, 255, 70, 70),  // soft red
  Tetromino.T: Color(0xFFCC99FF)   // soft purple
};

