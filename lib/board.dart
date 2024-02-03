import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris_by_surja/piece.dart';
import 'package:tetris_by_surja/pixel.dart';
import 'package:tetris_by_surja/values.dart';

//create 2*2 gameboard list
List<List<Tetromino?>> gameBoard =List.generate(colLength, (i) => List.generate(
rowLength,
(j)=>null,
),);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {

//current piece
Piece currentPiece=Piece(type:Tetromino.I);

//SCORE
int currentScore=0;

//GAMEOVER

bool gameOver=false;
  @override
  void initState(){
    super.initState();

    //start game when app starts

    startGame();
  }

  void startGame(){
    currentPiece.initializePiece();
    //refresh rate
    Duration frameRate = const Duration(milliseconds: 400); //speed of blocks falling down.
    gameLoop(frameRate);

  }

  //game loop
  void gameLoop(Duration frameRate){
    Timer.periodic(frameRate,
    (timer){
      setState((){

        //clear lines

        clearLines();
        //check landing
        checkLanding();

        //check gameover

        if(gameOver==true){
          timer.cancel();
          showGameOverDialog();
        }
      //move the curent piece down

      currentPiece.movePiece(Direction.down);
    }
    );
    },
    );
  }

  //gameovermsg
  void showGameOverDialog()
  {
    showDialog(context: context, builder: (context)=>AlertDialog(
        title: Text('Game Over'),
        content: Text('Your score is: $currentScore'),
        actions:[
          TextButton(onPressed:(){
            resetGame();

            Navigator.pop(context);
          },
          child:Text('Play Again')
          )
        ]
    ),);
  }
//reset game
void resetGame(){
  //clear game board
  gameBoard= List.generate(colLength, (i) => List.generate(
    rowLength,
    (j) =>null,
  ),);

  //newgame
  gameOver = false;
  currentScore=0;

  createNewPiece();
  startGame();
}
  //check for collision in future location
  //return true if collision
  //false if none
  bool checkCollision(Direction direction){
    //loop through each pos of current piece
    for (int i=0;i<currentPiece.position.length;i++){
      //calculate row and column of current
      int row=(currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      //adjust row an col based on direction

      if(direction==Direction.left)
      {
        col-=1;

      } else if(direction ==Direction.right){
        col +=1;
      }else if(direction==Direction.down)
{
  row+=1;
}
//check if piece is out of bounds

if(row>=colLength || col<0||col>=rowLength){
  return true;
}
    
    }
    return false;
  }
//check landing
void checkLanding() {
    // if going down is occupied or landed on other pieces
    if (checkCollision(Direction.down) || checkLanded()) {
      // mark position as occupied on the game board
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }

      // once landed, create the next piece
      createNewPiece();
    }
  }

  bool checkLanded() {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // check if the cell below is already occupied
      if (row + 1 < colLength && row >= 0 && gameBoard[row + 1][col] != null) {
        return true; // collision with a landed piece
      }
    }

    return false; // no collision with landed pieces
  }

//func to create new piece
void createNewPiece()
{
   Random rand = Random();

   //create a new piece with random type
   Tetromino randomType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
   currentPiece= Piece(type: randomType);
   currentPiece.initializePiece();
   if(isGameOver()){
    gameOver=true;
   }
}
//controls

void moveLeft(){
//make sure move valid
if(!checkCollision(Direction.left)){
  setState((){
    currentPiece.movePiece(Direction.left);
  });

}

}

void moveRight(){
  if(!checkCollision(Direction.right)){
  setState((){
    currentPiece.movePiece(Direction.right);
  });

}
  
}

void rotatePiece(){
  setState((){
    currentPiece.rotatePiece();

  });
  
}

//clear lines

void clearLines(){
  //step1: loop through each row of the game board from bottom to top.
  for(int row=colLength -1;row>=0;row--)
  {
    bool rowIsFull=true;
    for(int col =0;col<rowLength;col++)
    {
      if(gameBoard[row][col] ==null){
        rowIsFull = false;
        break;
      }
    }

    //row full
    if(rowIsFull){
      for(int r=row;r>0;r--){
        gameBoard[r] =List.from(gameBoard[r-1]);
      }
      gameBoard[0]=List.generate(row,(index)=>null);

      currentScore++;
    }
  }
}

//GAME OVER
bool isGameOver(){
  for(int col=0;col<rowLength;col++){
    if(gameBoard[0][col]!=null){
      return true;
    }
  }
  return false;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, //discord black 
      body: Column(
        children: [
          //game grid
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * colLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: rowLength),
             itemBuilder: (context, index) {
               int row=(index / rowLength).floor();
            int col = index % rowLength;
              if(currentPiece.position.contains(index)){
                return Pixel(color: currentPiece.color,
             child: index);
              }
              //landed pieces
              else if(gameBoard[row][col] != null){
                final Tetromino? tetrominoType = gameBoard[row][col];
                return Pixel(color: tetrominoColors[tetrominoType], child: '');
              }
                    
              else{
                return Pixel(color: Colors.grey[800],
             child: index);
              }
             }
             ),
          ),

          //score
          Text('Score: $currentScore ',
          style: TextStyle(color: Colors.white)),


          //controls
          Padding(
            padding: const EdgeInsets.only(bottom:15.0, top:10), //cuz im Surja15
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
              //left
              IconButton(onPressed: moveLeft,color:Colors.white, icon:Icon(Icons.arrow_back_ios_new)),
              Text('Made by',style:TextStyle(color: Colors.white54)),
              //rotate
              IconButton(onPressed: rotatePiece, color:Colors.white,icon:Icon(Icons.rotate_right)),
              Text('Surja', style:TextStyle(color: Colors.white54)),
              //right
              IconButton(onPressed: moveRight, color:Colors.white,icon:Icon(Icons.arrow_forward_ios)), 
            ],),
          )
        ],
      ),
    );
  }
}