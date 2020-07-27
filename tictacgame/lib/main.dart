import 'package:flutter/material.dart';
import 'package:tictacgame/pages/gameplay.dart';
void main() {
  runApp(MaterialApp(
    title: 'TicTac Game',
    initialRoute:'/home',
    routes: {
      '/home' : (context) => HomePage(),
      '/gameplay' : (context) => GamePlay(),

    },
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Tic Tac Toe Game',
                  style: TextStyle(
                    fontSize: 32.0
                  ),
                ),
                Image(
                    image: AssetImage('assets/tic.jpg'),
                  height: 256,
                ),

                SizedBox(height: 20.0,),
                RaisedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/gameplay');
                    },
                    child: Text(
                        'Start Game',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                    color: Colors.blue,
                )

              ],
            ),
          )
      ),
    );
  }
}

