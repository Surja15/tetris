

import 'dart:ui';

import 'package:tetris_by_surja/board.dart';
import 'package:tetris_by_surja/values.dart';

class Piece{
  //type of piece
  Tetromino type;

  Piece({required this.type});

  // the piece is a list of integers
  List<int> position=[];
//color of pieces

Color get color{
  return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  
}
  //generate the integers

  void initializePiece()
  {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,-16,-6,-5,
        ];
        break;
        case Tetromino.J:
        position = [
          -25,-15,-5,-6,
        ];
        break;
        case Tetromino.I:
        position = [
          -4,-5,-6,-7,
        ];
        break;
        case Tetromino.O:
        position = [
          -15,-16,-5,-6,
        ];
        break;
        case Tetromino.S:
        position = [
          -15,-14,-6,-5,
        ];
        break;
        case Tetromino.Z:
        position = [
          -17,-16,-6,-5,
        ];
        break;
        case Tetromino.T:
        position = [
          -26,-16,-6,-15,
        ];
        break;
      default:
    }
  }
//move piece
void movePiece(Direction direction)
{
  switch (direction)
  {
    case Direction.down:
    for(int i=0;i<position.length;i++) {
      position[i] += rowLength;
    }
    break;
    case Direction.left:
    for(int i=0;i<position.length;i++) {
      position[i] -= 1;
    }
    break;
    case Direction.right:
    for(int i=0;i<position.length;i++) {
      position[i] += 1;
    }
    break;
    default:
  }
}

//rotate piece
int rotationState =1;
void rotatePiece()
{
  //new position
  List<int> newPosition=[];

  switch (type) {
    case Tetromino.L:    //CORRECT
    switch(rotationState){
      case 0:

      //get new position
      newPosition = [
        position[1] -rowLength,
        position[1],
        position[1]+rowLength,
        position[1]+rowLength+1,
      ];

      //update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
      case 1:
  // Get new position
   newPosition = [
    position[1] - 1,
    position[1],
    position[1] + 1,
    position[1] + rowLength - 1,
  ];
        //update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
  break;

case 2:
  // Get new position
  newPosition = [
    position[1] + rowLength,
    position[1],
    position[1]-rowLength,
    position[1] - rowLength - 1,
  ];
        //update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
  break;

case 3:
  // Get new position
  newPosition = [
    position[1] - rowLength - 1,
    position[1],
    position[1] + 1,
    position[1] - 1,
  ];
        //update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
  break;
    }
  case Tetromino.J:                       //CORRECT
  switch(rotationState){
    case 0:
      newPosition = [
        position[1] - rowLength,
        position[1],
        position[1] + rowLength,
        position[1] + rowLength - 1,
      ];
      //update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    case 1:
      newPosition = [
        position[1] -rowLength -1,
        position[1],
        position[1] - 1,
        position[1] + 1,
      ];
      //update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    case 2:
      newPosition = [
        position[1] + rowLength,
        position[1],
        position[1] - rowLength,
        position[1] - rowLength + 1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    case 3:
      newPosition = [
        position[1] + 1,
        position[1],
        position[1] - 1,
        position[1] + rowLength + 1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
  }
  break;
case Tetromino.I:                                     //Correct
  switch(rotationState){
    case 0:
    newPosition = [
        position[1] -1,
        position[1],
        position[1] +1,
        position[1] +2,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    
    case 1:
    newPosition = [
        position[1] - rowLength,
        position[1],
        position[1] + rowLength,
        position[1] + 2 * rowLength,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
      case 2:
      newPosition = [
        position[1] +1,
        position[1],
        position[1] -1,
        position[1] - 2 ,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    case 3:
      newPosition = [
        position[1] +rowLength,
        position[1],
        position[1] -rowLength,
        position[1] -2*rowLength,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
  }
  break;
case Tetromino.O:     //CORRECT
  // O tetromino does not rotate
  break;
case Tetromino.S:                             //Correct
  switch(rotationState){
    case 0:
    newPosition = [
        position[1] ,
        position[1]+1,
        position[1] + rowLength -1,
        position[1] +rowLength,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
      case 1:
      newPosition = [
        position[1] - rowLength,
        position[1],
        position[1] + 1,
        position[1] + rowLength + 1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;

    case 2:
    
      newPosition = [
        position[1] ,
        position[1]+1,
        position[1] +rowLength - 1,
        position[1] +rowLength,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    
    case 3:
      newPosition = [
        position[1] -rowLength,
        position[1],
        position[1] + 1,
        position[1] + rowLength + 1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
  }
  break;
case Tetromino.Z:    //Wrong
  switch(rotationState){
    case 0:
    newPosition = [
        position[0] +rowLength -2,
        position[1],
        position[2] + rowLength -1,
        position[3] +1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
      case 1:
      newPosition = [
        position[0] - rowLength +2,
        position[1],
        position[2] -rowLength+1,
        position[3] - 1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;

    case 2:
    
      newPosition = [
        position[0] +rowLength-2 ,
        position[1],
        position[2] +rowLength - 1,
        position[3] +1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    
    case 3:
      newPosition = [
        position[0] -rowLength+2,
        position[1],
        position[2] -rowLength +1,
        position[3] - 1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
  }
  break;
case Tetromino.T:      //CORRECT
  switch(rotationState){
    case 0:
      newPosition = [
        position[2] - rowLength,
        position[2],
        position[2] + rowLength,
        position[2] - 1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    case 1:
      newPosition = [
        position[1] - 1,
        position[1],
        position[1] + 1,
        position[1] + rowLength,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    case 2:
      newPosition = [
        position[1] - rowLength,
        position[1]-1,
        position[1] ,
        position[1] + rowLength,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
    case 3:
      newPosition = [
        position[2] -rowLength,
        position[2] -1,
        position[2] ,
        position[2] +1,
      ];//update position
      if(piecePositionIsValid(newPosition)){
        position=newPosition;

      //update rotationstate
      rotationState = (rotationState+1) % 4;
      }
      break;
  
  


  
  

  
    }
      
      break;
    default:
    
  }
}

//check valid pos

bool positionIsValid(int position)
{
  //get the row and col of position
  int row = (position/rowLength).floor();
  int col = position % rowLength;

  //if pos taken, return false

if(row<0 ||col<0||gameBoard[row][col]!=null){return false;}
else{
//pos valid
return true;}
}

//check if piece is valid pos

bool piecePositionIsValid(List<int>piecePosition){
  bool firstColOccupied=false;
  bool lastColOccupied=false;

  for(int pos in piecePosition){
    //return false if pos taken

    if(!positionIsValid(pos)){
      return false;
    }

    //get col of pos

    int col = pos%rowLength;

    //check if col first or last occupied

    if(col ==0){
      firstColOccupied =true;
    }
    if(col == rowLength-1){
      lastColOccupied =true;
    }
  }
  //if there is piece in first last col, wall glitch

  return !(firstColOccupied && lastColOccupied);
}
}