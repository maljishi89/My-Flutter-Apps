import 'package:flutter/material.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator App',
      home: HomePage(),

    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String sign;
  double firstNumber;
  double secondNumber;
  double result;
  bool firstClicked= false;
  var txt = TextEditingController();
  Widget textfield =TextField();
  Widget floatSign = FloatingActionButton(

    onPressed: () {},
    child: Text(''),
      backgroundColor: Colors.blueAccent[800]

  );

  Widget button (String x){
    return RaisedButton(
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0)),
      onPressed: () {
        setState(() {
          txt.text += x;

        });


      },
      color: Colors.grey[50],
      child: Container(
        margin: EdgeInsets.all(25.0),

        child: Text(
          x,

          style: TextStyle(
              fontSize: 30.0,
              color: Colors.blueGrey

          ),
        ),
      ),

    );
  }
  // ignore: non_constant_identifier_names
  Widget DisplayEquation(){

    return Column(
      children: <Widget>[
        Container(

          margin: EdgeInsets.all(10.0),
          child: Row(

              children: <Widget>[
                Text('First number => $firstNumber',
                style: TextStyle(
                  fontSize: 20.0
                ),
                )
              ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Text('Second number => $secondNumber',
                style: TextStyle(
                  fontSize: 20.0
                ),

              ),
            ],
          ),
        )

      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            'Simple Calculator App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[900],
              fontSize: 25.0,

            ),

          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // 0 row Display Equation
            Row(
              children: <Widget>[
                DisplayEquation()
              ],
            ),
            //first row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[

               Expanded(
                 
                 child: Container(
                    //---------------------------textField---------------------------------------
                   margin: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 0),
                   child: textfield= TextField(
                      readOnly: true,
                     controller: txt,
                     style: TextStyle(
                       fontSize: 50.0,

                     ),
                   ),
                 ),
               )
               ,Container(
                 margin: EdgeInsets.all(8.0),
                 child: floatSign,
               )
             ],
            ),

            SizedBox(height: 10.0, width: 10.0,),
            //second row
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("1"),
              )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("2"),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("3"),
                      )
                  )
                ],
              ),
            ),

            // third row
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("4"),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("5"),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("6"),
                      )
                  )
                ],
              ),
            ),
            // forth row
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0 ,0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("7"),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("8"),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("9"),
                      )
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0)),
                        color: Colors.grey[50],
                        onPressed: (){
                          setState(() {
                            if(!txt.text.contains("."))
                              txt.text += '.';
                          });
                        }
                        , child: Container(
                                margin: EdgeInsets.all(25.0),

                          child: Text('.'
                          , style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.blueGrey
                          ),
                      ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: button("0"),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0)),
                          onPressed: () {

                              firstNumber= double.parse(txt.text);
                              print('first number is $firstNumber');
                              firstClicked= !firstClicked;

                              // ----------------------------------Change State of adding-----------------
                            setState(() {
                              floatSign = FloatingActionButton(
                                onPressed: () {},
                                child: Text(
                                    '+',
                                  style: TextStyle(
                                    fontSize: 30.0
                                  ),

                                ),

                                backgroundColor: Colors.blueAccent[800],

                              );
                              txt.text= "";
                              sign= "+";

                            });
                          },
                          color: Colors.blue[400],
                          child: Container(
                            margin: EdgeInsets.all(25.0),

                            child: Text(
                              '+',

                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white

                              ),
                            ),
                          ),

                        ),
                      )
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0)),
                          onPressed: () {

                            firstNumber= double.parse(txt.text);
                            print('first number is $firstNumber');
                            firstClicked= !firstClicked;

                            // ----------------------------------Change State of adding-----------------
                            setState(() {
                              floatSign = FloatingActionButton(
                                onPressed: () {},
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 30.0
                                  ),

                                ),

                                backgroundColor: Colors.blueAccent[800],

                              );
                              txt.text= "";
                              sign= "-";

                            });
                          },
                          color: Colors.blue[400],
                          child: Container(
                            margin: EdgeInsets.all(25.0),

                            child: Text(
                              '-',

                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white

                              ),
                            ),
                          ),

                        ),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: RaisedButton(
                            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0)),
                          onPressed: () {

                            firstNumber= double.parse(txt.text);
                            print('first number is $firstNumber');
                            firstClicked= !firstClicked;

                            // ----------------------------------Change State of adding-----------------
                            setState(() {
                              floatSign = FloatingActionButton(
                                onPressed: () {},
                                child: Text(
                                  'x',
                                  style: TextStyle(
                                      fontSize: 30.0
                                  ),

                                ),

                                backgroundColor: Colors.blueAccent[800],

                              );
                              txt.text= "";
                              sign= "x";

                            });
                          },
                          color: Colors.blue[400],
                          child: Container(
                            margin: EdgeInsets.all(25.0),

                            child: Text(
                              'x',

                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white

                              ),
                            ),
                          ),

                        ),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0)),
                          onPressed: () {

                            firstNumber= double.parse(txt.text);
                            print('first number is $firstNumber');
                            firstClicked= !firstClicked;

                            // ----------------------------------Change State of adding-----------------
                            setState(() {
                              floatSign = FloatingActionButton(
                                onPressed: () {},
                                child: Text(
                                  '÷',
                                  style: TextStyle(
                                      fontSize: 30.0
                                  ),

                                ),

                                backgroundColor: Colors.blueAccent[800],

                              );
                              txt.text= "";
                              sign= "÷";

                            });
                          },
                          color: Colors.blue[400],
                          child: Container(
                            margin: EdgeInsets.all(25.0),

                            child: Text(
                              '÷',

                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white

                              ),
                            ),
                          ),

                        ),
                      )
                  )
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0)),
                          onPressed: () {
                            firstClicked=false;
                            firstNumber=0;
                            secondNumber=0;
                            sign= "";
                            setState(() {
                              txt.text='';
                              floatSign= FloatingActionButton(
                                onPressed: () {},
                                child: Text(''),
                                backgroundColor: Colors.blueAccent[800],

                              );
                            });
                          },
                          color: Colors.teal[400],
                          child: Container(

                            margin: EdgeInsets.all(25.0),

                            child: Text(
                              'C',

                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white

                              ),
                            ),
                          ),

                        ),
                      )
                  ),
                ),

                Container(
                  
                  child: Expanded(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0)),
                          color: Colors.indigo,
                        onPressed: (){
                          setState(() {
                            if(txt.text.compareTo('')!=0)
                              if(sign.compareTo("+")==0){
                                secondNumber= double.parse(txt.text);
                                result= firstNumber+secondNumber;
                                txt.text= '$result';
                                firstNumber= result;

                              }
                              else if(sign.compareTo("-")==0){
                                secondNumber= double.parse(txt.text);
                                result= firstNumber-secondNumber;
                                txt.text= '$result';
                                firstNumber= result;

                              }
                              else if(sign.compareTo("x")==0){
                                secondNumber= double.parse(txt.text);
                                result= firstNumber*secondNumber;
                                txt.text= '$result';
                                firstNumber= result;

                              }
                              else if(sign.compareTo("÷")==0){
                                secondNumber= double.parse(txt.text);
                                result= firstNumber/secondNumber;
                                txt.text= '$result';
                                firstNumber= result;

                              }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(25.0),
                          child: Text(
                            '=',
                            style: TextStyle(
                                fontSize: 30.0,
                              color: Colors.white

                            ),
                          ),
                        ),


                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],

        ),

      )
      ,


    );
  }
}

