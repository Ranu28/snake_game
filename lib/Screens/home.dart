import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_game/Screens/pixels/blank_pixcels.dart';
import 'package:snake_game/Screens/pixels/food_pixcels.dart';
import 'package:snake_game/Screens/pixels/snake_pixcels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//enum for directions
enum snake_directions { UP, DOWN, LEFT, RIGHT }

class _HomeScreenState extends State<HomeScreen> {
  //grid dimensions
  int rows = 10;
  int totalNumberOfSquares = 100;

  //player Score
  int currentScore = 0;

  //snack position
  List<int> snakePosition = [0, 1, 2];

  //food position
  int foodPosition = 55;

  // default snake direction
  var currentDirection = snake_directions.RIGHT;

  //score map
  final Map<String, int> scoreAll = {};

  TextEditingController name = new TextEditingController();
  //start game
  void startGame() {
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        //Keep the snake moving
        moveSnake();
        //if game is over
        if (isGameOver()) {
          timer.cancel();

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.grey[400],
                  title: const Text("GAME OVER"),
                  content: Text("Your Score : ${currentScore.toString()}"),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                      color: Colors.redAccent,
                    ),
                  ],
                );
              });

          snakePosition = [0, 1, 2];
          currentDirection = snake_directions.RIGHT;
        }
      });
    });
  }

  void eatFood() {
    currentScore += 10;
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(totalNumberOfSquares);
    }
  }

  bool isGameOver() {
    //create a sub list of snakePosition without head
    var snackeWithoutHead = snakePosition.sublist(0, snakePosition.length - 1);
    //if snake head position is in the newly created array return true.(game over)
    if (snackeWithoutHead.contains(snakePosition.last)) {
      return true;
    }
    return false;
  }

  void moveSnake() {
    switch (currentDirection) {
      case snake_directions.RIGHT:
        {
          //add new head
          //if snake hits wall re position to 1st in that row or column
          if (snakePosition.last % rows == 9) {
            snakePosition.add(snakePosition.last + 1 - rows);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
        }

        break;
      case snake_directions.LEFT:
        {
          //add new head
          //if snake hits wall re position to 1st in that row or column
          if (snakePosition.last % rows == 0) {
            snakePosition.add(snakePosition.last - 1 + rows);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
        }

        break;
      case snake_directions.DOWN:
        {
          //add new head
          //if snake hits wall re position to 1st in that row or column
          if (snakePosition.last + rows > totalNumberOfSquares) {
            snakePosition.add(snakePosition.last + rows - totalNumberOfSquares);
          } else {
            snakePosition.add(snakePosition.last + rows);
          }
        }

        break;
      case snake_directions.UP:
        {
          //add new head
          //if snake hits wall re position to 1st in that row or column
          if (snakePosition.last < rows) {
            snakePosition.add(snakePosition.last - rows + totalNumberOfSquares);
          } else {
            snakePosition.add(snakePosition.last - rows);
          }
        }

        break;
      default:
    }
    if (snakePosition.last == foodPosition) {
      eatFood();
    } else {
      //remove tail
      snakePosition.removeAt(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(
        children: [
          //High score
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Score",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        currentScore.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  // Text("High Score", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
          //Game grid
          Expanded(
            flex: 3,
            child: Container(
              child: GestureDetector(
                onVerticalDragUpdate: ((details) {
                  if (details.delta.dy > 0 &&
                      currentDirection != snake_directions.UP) {
                    currentDirection = snake_directions.DOWN;
                  }
                  if (details.delta.dy < 0 &&
                      currentDirection != snake_directions.DOWN) {
                    currentDirection = snake_directions.UP;
                  }
                }),
                onHorizontalDragUpdate: ((details) {
                  if (details.delta.dx < 0 &&
                      currentDirection != snake_directions.RIGHT) {
                    currentDirection = snake_directions.LEFT;
                  }
                  if (details.delta.dx > 0 &&
                      currentDirection != snake_directions.LEFT) {
                    currentDirection = snake_directions.RIGHT;
                  }
                }),
                child: GridView.builder(
                    itemCount: totalNumberOfSquares,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rows,
                    ),
                    itemBuilder: (context, index) {
                      if (snakePosition.contains(index)) {
                        return SnackPixels();
                      } else if (foodPosition == index) {
                        return FoodPixels();
                      } else {
                        return BlankPixels();
                      }
                    }),
              ),
            ),
          ),
          //play button
          Expanded(
            child: Container(
              child: Center(
                  child: MaterialButton(
                      child: Text("PLAY"),
                      color: Colors.red,
                      onPressed: startGame)),
            ),
          ),
        ],
      ),
    );
  }
}
