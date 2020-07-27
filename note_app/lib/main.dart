import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:noteapp/pages/createNote.dart';
import 'package:noteapp/Note/Note.dart';
import 'package:noteapp/pages/editNote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Notes X",
      home: HomePage(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("en", "US"),
          Locale("ar", "AE"),
        ],


    );
  }


}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static bool darkMode=false;
  ThemeData light=ThemeData(
      appBarTheme: AppBarTheme(color:Color(0xff0077b6) ),
      canvasColor: Color(0xffCDF0F6),
  );
  ThemeData dark=ThemeData(
      appBarTheme: AppBarTheme(color:Colors.grey[900] ),
      canvasColor: Colors.black,
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: Colors.blueGrey)
  );



  @override
  static String page= "Notes X";
  static Note note;
  static List<Note> notes= List<Note>();
  static List<Note> favNotes= List<Note>();
  static List<Note> recentlyDeleted= List<Note>();
  static var toRemove;
  static bool darkmode=false;

    @override
    void initState() {
      super.initState();
      print("InitState here.......................");

      // Save into Storage and load them
      if(notes.isEmpty)
        setState(() {
          getData();
        });
      else {
        // set the favorite notes again
        favNotes = List<Note>();
        for (int i = 0; i < notes.length; i++) {
          if (notes[i].fav == true)
            favNotes.add(notes[i]);
        }

        setState(() {

        });
        setData();

      }

    }

     getData() async{
      print("getting Data .............................");
      // getting the data from the storage
      final prefs = await SharedPreferences.getInstance();
      List<String> jsonNotes= prefs.getStringList('SavedNotes') ?? List<String>();
      notes= List<Note>();
      favNotes= List<Note>();
      for(int i=0; i<jsonNotes.length;i++){
        Note toReadNote=Note.fromJson(json.decode(jsonNotes[i]));
       notes.add(toReadNote);
      }
      for(int i=0;i<notes.length;i++){
        if(notes[i].fav==true)
          favNotes.add(notes[i]);
      }

      List<String> jsonNotesDeleted= prefs.getStringList('RecentlyDeleted') ?? List<String>();
      recentlyDeleted= List<Note>();
      for(int i=0; i<jsonNotesDeleted.length;i++){
        recentlyDeleted.add(Note.fromJson(json.decode(jsonNotesDeleted[i])));
      }
      darkmode= prefs.getBool('darkmode')?? false;
      setState(() {

      });
    }
   setData() async{

    // getting the data from the storage
    final prefs = await SharedPreferences.getInstance();

      try {

        List<String> jsonNotes= List<String>();
        for(int i=0;i<notes.length; i++) {
          jsonNotes.add(json.encode(notes[i].toJson()));
        }

        favNotes= List<Note>();
        for(int i=0;i<notes.length; i++) {
          if(notes[i].fav)
            favNotes.add(notes[i]);
        }


        prefs.setStringList("SavedNotes", jsonNotes);
        // recently deleted saved here
        List<String> jsonNotesDeleted= List<String>();
        for(int i=0;i<recentlyDeleted.length; i++) {
          jsonNotesDeleted.add(json.encode(recentlyDeleted[i].toJson()));
        }
        prefs.setStringList("RecentlyDeleted", jsonNotesDeleted);
        // saving darkmode
        prefs.setBool("darkmode", darkmode);
        print("Date saved!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

      } catch(Exception ){
        print(Exception);
      }


   }

   setDarkmode() async{
     final prefs = await SharedPreferences.getInstance();
     prefs.setBool("darkmode", darkmode);

   }


  Widget build(BuildContext context) {
    final kTabs= <Tab>[
      Tab(child: Icon(Icons.done_all),),
      Tab(child: Icon(Icons.favorite),),
      Tab(child: Icon(Icons.delete_outline),)

    ];

    final kTabPages= <Widget> [

      // Created notes page
      SafeArea(child: Container(
          margin: EdgeInsets.all(6),

          child: ListView.builder(
            itemCount: notes.reversed.toList().length,
            itemBuilder: (context, index){

              return Stack(children: <Widget>[
                noteWidget(index,notes.reversed.toList()[index]),                 // todo you may use a row and passing the paramater again to make work full with the darkmode
                Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                    child: IconButton(icon: Icon(Icons.delete, color: darkmode==true? Colors.white70: Colors.black,), onPressed: (){
                      setState(() {

                        toRemove= notes.reversed.toList()[index];
                        notes.remove(toRemove);
                        favNotes.removeWhere((element) => element==toRemove);
                        recentlyDeleted.add(toRemove);
                        setData();

                      });
                    }),

                ),

                ],
                overflow: Overflow.clip
                  ,)
              ],
              overflow: Overflow.clip
                ,);
            },

          )
      )),

      // fav page
      SafeArea(child: Container(
          margin: EdgeInsets.all(6),
          child: ListView.builder(
            itemCount: favNotes.reversed.toList().length,
            itemBuilder: (context, index){
              return Stack(children: <Widget>[
                noteWidget(index, favNotes.reversed.toList()[index]),
                Stack(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: IconButton(icon: Icon(Icons.delete,color: darkmode==true? Colors.white70: Colors.black), onPressed: (){
                          setState(() {
                            toRemove= favNotes.reversed.toList()[index];
                            favNotes.remove(toRemove);
                            notes.removeWhere((element) => element==toRemove);
                            recentlyDeleted.add(toRemove);
                            setData();
                          });
                        })
                    ),
                  ],
                  overflow: Overflow.clip,
                )
              ],
              overflow: Overflow.clip
                ,);
            },

          )
      )),


      // Recently Deleted Page
      SafeArea(child: Container(
          margin: EdgeInsets.all(6),
          child: ListView.builder(
            itemCount: recentlyDeleted.length,
            itemBuilder: (context, index){
              return Stack(children: <Widget>[
                noteWidget(index,recentlyDeleted[index]),
                Stack(children: <Widget>[
                  Container(
                    // remove button
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.fromLTRB(0, 0, 12, 0),
                      child: IconButton(icon: Icon(Icons.delete_forever,color: darkmode==true? Colors.white70: Colors.black), onPressed: (){
                        setState(() {
                          recentlyDeleted.removeAt(index);
                          setData();
                        });
                      })
                  ),
                  Container(
                    // restore button
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.fromLTRB(0, 0, 12, 0),

                    child: IconButton(icon: Icon(Icons.restore, color: Colors.white,), onPressed: (){
                      setState(() {

                        notes.add(recentlyDeleted[index]);
                        if(recentlyDeleted[index].fav==true)
                          favNotes.add(recentlyDeleted[index]);
                        recentlyDeleted.removeAt(index);
                        setData();
                      });
                    }),
                  ),
                ],
                overflow: Overflow.clip
                  ,)

              ],
                overflow: Overflow.clip,
              );
            },

          )
      )),
    ];


    Widget remove= page.compareTo("Recently deleted")==0? FloatingActionButton(
        child: Icon(Icons.restore_from_trash),
        backgroundColor: Color(0xff0077B6),
        onPressed: (){


        }): null ;

    // add button
    Widget add= FloatingActionButton(
      heroTag: "addNote",
        child: Icon(Icons.add),
        backgroundColor: darkmode==false? Color(0xff0077B6): Colors.blueGrey,
        onPressed: () async {
          // here transition NotePage()
          note = await Navigator.push(context, PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 200),
              transitionsBuilder: (context, Animation<double> animation, Animation<double> secAnimation, Widget child){
                animation= CurvedAnimation(parent: animation, curve: Curves.easeIn);
                return ScaleTransition(scale: animation,alignment: Alignment.center,child: child,);
              },
              pageBuilder: (context, Animation<double> animation, Animation<double> secAnimation){

                return NotePage();
              }));
          if(note != null) {
            notes.add(note);
            if (note.fav == true)
              favNotes.add(note);
            // here a transition HomePage()
            setState(() {
              setData();
            });
          }
        })?? null;

    return DefaultTabController(

      length: kTabPages.length,
      child: Scaffold(
        backgroundColor: darkmode==true? dark.canvasColor:light.canvasColor ,
        appBar: AppBar(
          backgroundColor: darkmode==true? dark.appBarTheme.color:light.appBarTheme.color,
          bottom: TabBar(tabs: kTabs,),
          title: Container(
            child: Row(
              children: <Widget>[
                Expanded(child: Text(page),
                  flex: 8,

                ),
                Expanded(child:PopupMenuButton(itemBuilder: (BuildContext context){
                  return ;
                }) )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),

          ) ,
        ),
        drawer: Drawer(
          child: SafeArea(

            child: Container(
              color: darkmode==true? dark.appBarTheme.color:light.canvasColor,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(child: Icon(Icons.account_circle, size: 64,color: darkmode==false? Colors.black:Colors.white,), flex: 2,),
                            Expanded(child: Text("Login",style: TextStyle(color: darkmode==false? Colors.black:Colors.white ),), flex: 1,),
                            Expanded(child: Container(child: Text("Dark mode",style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: darkmode==false? Colors.black:Colors.white),),), flex: 1,),
                            Switch(value: darkmode, onChanged: (value){
                              darkmode=!darkmode;
                              setDarkmode();

                              setState(() {
                                print("Restart to take effect");


                              });

                            })


                          ],

                        ),
                      ),


                      Row(
                        children: <Widget>[
                          // google drive sync page

                          Expanded(child: FlatButton(onPressed: (){

                            setState(() {

                              Navigator.pop(context);
                            });

                          }, child: Text("Support us",style: TextStyle(fontSize: 16, color: darkmode==false? Colors.black:Colors.white),))),


                        ],
                      ),


                    ],
                  ),
            ),
          ),
        ),

        body: TabBarView(children: kTabPages,),
        floatingActionButton:  add,

      ),
    );

  }

  Widget noteWidget(int index,Note noteR){
      // todo complete dark mode settings in class of note
        Note noteX;
        String date=noteR.dateString;
        bool favo=noteR.fav;

        return SafeArea(
          child: Center(
            child: FlatButton(
              onPressed: () async{
                var notePassed= Note(noteR.noteID, noteR.fav, noteR.text, noteR.textStyle, noteR.backgroundColor);
                // here is a transition
                noteX = await Navigator.push(context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 100),
                        transitionsBuilder: (context, Animation<double> animation, Animation<double> secAnimation, Widget child){
                          var begin = Offset(1, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(child: child,position: tween.animate(animation), );
                        },
                        pageBuilder: (context, Animation<double> animation, Animation<double> secAnimation){
                          return EditPage(passedNote: notePassed,);
                        }));

                if(noteX!= null) {
                  noteR.edit(noteX);
                  // updating the widget tree
                  setData();
                  setState(() {

                  });
                }



              },
              onLongPress: (){

              },
              child: Container(
                height: 100,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: darkmode==false?  noteR.backgroundColor: Colors.grey[850] ,

                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      child:

                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                noteR.text,
                                style: TextStyle(
                                  fontStyle: noteR.textStyle.fontStyle,
                                  fontWeight: noteR.textStyle.fontWeight,
                                  decoration: noteR.textStyle.decoration,
                                  fontSize: noteR.textStyle.fontSize,
                                  color: darkmode==false? Colors.black:Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,

                              ),

                            )


                          ],
                        )

                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text("$date",
                        style: TextStyle(
                            fontSize: 11,
                            color: darkmode==false? Colors.black:Colors.white
                        ),
                      ),
                    )

                  ],
                ),

              ),
            ),
          ),
        );
      }


    }



