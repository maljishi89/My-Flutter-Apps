import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteapp/Note/Note.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(NotePage());
}
class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return createNote();
  }
}

class createNote extends StatefulWidget {
  @override
  _createNoteState createState() => _createNoteState();
}

class _createNoteState extends State<createNote> {
  static int noteID=1;
  static FontStyle fontStyle;
  static FontWeight fontWeight;
  static TextDecoration fontDecoration;
  static Color favoriteColor= Color(0xff90e0ef);
  static bool favorite=false;
  static Color textColor;
  static Color backgroundColor= Color(0xff48cae4);
  static bool fav=false;
  static String text;
  static TextEditingController textController= TextEditingController(text: text);

  void changeTextColor(Color color){
    setState(() {
      textColor= color;
      Navigator.pop(context);
    });

  }

  void changeBackgroundColor(Color color){
    setState(() {
      backgroundColor= color;
      Navigator.pop(context);
    });

  }

  @override
  void initState() {
    super.initState();
    getDarkmode();
    if(noteID==1)
      getLastID();



  }

  void getLastID() async{
    var prefs= await SharedPreferences.getInstance();
    noteID=prefs.getInt('lastID')?? 1;
  }
  void setLastID() async{
    var prefs= await SharedPreferences.getInstance();
    prefs.setInt('lastID', noteID);
  }


  bool darkmode;
  void getDarkmode()async{
    final prefs = await SharedPreferences.getInstance();
    darkmode= prefs.getBool('darkmode')??false;
    print(darkmode);
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

    // text style
    TextStyle textStyle= TextStyle(
      fontSize: 22,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      decoration: fontDecoration,
      color: darkmode==false? textColor: Colors.white,

    );




    return Scaffold(
      backgroundColor: darkmode==false? Color(0xffCDF0F6): Colors.black,
      appBar: AppBar(
        title: Container(
          child: Row(
            children: <Widget>[
              // background color color
              Expanded(child: IconButton(icon: Icon(Icons.format_color_fill, color: darkmode==false? Colors.black: Colors.white), onPressed: (){
                showDialog(context: context, builder: (context){
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))
                    ) ,
                    child: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xff90e0ef),
                        borderRadius:
                        new BorderRadius.all(new Radius.circular(32.0)),
                      ),

                      width: 200,
                      height: 70,
                      child: Column(

                        children: <Widget>[
                          // first color row
                          Row(
                            children: <Widget>[
                              Expanded(child: IconButton(icon: Icon(Icons.color_lens, size: 52, color: Color(0xff48cae4),),
                                  onPressed: (){
                                    changeBackgroundColor(Color(0xff48cae4));

                                  }),
                                flex: 2,
                              ),
                              Expanded(child: IconButton(icon: Icon(Icons.color_lens, size: 52, color: Color(0xffe6fbff),),
                                  onPressed: (){
                                    changeBackgroundColor(Color(0xffe6fbff));

                                  }),
                                flex: 2,
                              ),
                              Expanded(child: IconButton(icon: Icon(Icons.color_lens, size: 52, color: Color(0xff3C2B88),),
                                  onPressed: (){
                                    changeBackgroundColor(Color(0xff3C2B88));

                                  }),
                                flex: 2,
                              ),

                            ],
                          ),


                        ],
                      ),
                    ),


                  );
                });

              }), flex: 2,),

              // underline button
              Expanded(child: IconButton(icon: Icon(Icons.format_underlined, color: darkmode==false? Colors.black: Colors.white), onPressed: (){

                setState(() {
                  if(fontDecoration !=TextDecoration.underline){
                    fontDecoration= TextDecoration.underline;
                  }
                  else {
                    fontDecoration= TextDecoration.none;
                  }

                });
              }), flex: 2,),
              // italic button
              Expanded(child: IconButton(icon: Icon(Icons.format_italic, color: darkmode==false? Colors.black: Colors.white ), onPressed: (){

                setState(() {
                  fontStyle= fontStyle==FontStyle.normal? FontStyle.italic: FontStyle.normal;

                });

              }), flex: 2,),
              // bold button
              Expanded(child: IconButton(icon: Icon(Icons.format_bold, color: darkmode==false? Colors.black: Colors.white,), onPressed: (){
                setState(() {

                  fontWeight= fontWeight!= FontWeight.bold? FontWeight.bold: FontWeight.normal;

                });

              }), flex: 2,),

              // favorite button
              Expanded(child: IconButton(icon: Icon(Icons.favorite, color: favorite==true? Colors.redAccent: (darkmode==false?Color(0xff90e0ef):Colors.grey)), onPressed: (){

              setState(() {
                favorite= !favorite;
                fav=!fav;
              });

              }), flex: 2,),




            ],
          ),
        ),
        backgroundColor:darkmode==false? Color(0xff0077b6): Colors.grey[900] ,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
        ) ,
      ),

      body: SafeArea(child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: darkmode==false ? backgroundColor: Colors.grey[850] ,

        ),
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(8.0),

        child: Column(
          children: <Widget>[
            Expanded(
              // Text Field for the note
              child: TextField(
                style: textStyle,
                scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                autofocus: true,
                controller: textController,





              ),


            ),

          ],
        ),
      )
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "doneCreate",
        onPressed: (){

          print(textController.text);
          // creating the note widget we pass

          Note note = Note(noteID, fav,textController.text, textStyle, backgroundColor);
          // reset all values after creating the object
          fontWeight= FontWeight.normal;
          fontStyle= FontStyle.normal;
          fontDecoration=null;
          textColor=Colors.black;
          backgroundColor= Color(0xff48cae4);
          fav=false;
          favorite= false;
          textController= TextEditingController(text: text);
          ++noteID;
          setLastID();
          setState(() {

          });
          Navigator.pop(context, note);




        },
        child: Icon(Icons.check),
        backgroundColor: darkmode==false? Color(0xff0077B6): Colors.blueGrey,

      ),
    );
  }
}
