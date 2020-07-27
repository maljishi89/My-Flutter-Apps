import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Note {
  int noteID;
  bool fav;
  String text;
  TextStyle textStyle;
  Color backgroundColor;
  DateTime date;
  String dateString;


  bool bold;
  bool italic;
  bool underline;
  int backColor;


  Note(this.noteID, this.fav, this.text, this.textStyle, this.backgroundColor){
    if(textStyle.fontWeight== FontWeight.bold)
      bold=true;
    else
      bold=false;
    if(textStyle.fontStyle== FontStyle.italic)
      italic=true;
    else italic=false;
    if(textStyle.decoration== TextDecoration.underline)
      underline=true;
    else underline=false;
    backColor= backgroundColor.value;
    date= DateTime.now();
    dateString= date.toString().substring(0,16);

  }

  void setDarkmode(){
    backgroundColor=Colors.grey[800];
    textStyle= TextStyle(
        fontWeight: bold==true ? FontWeight.bold: FontWeight.normal,
        fontStyle: italic==true? FontStyle.italic: FontStyle.normal,
        decoration: underline== true? TextDecoration.underline: TextDecoration.none,
        fontSize: 20,
        color: Colors.white70);



  }


  Map<String, dynamic> toJson() => {
    'noteID': noteID,
    'fav': fav,
    'text': text,
    'bold': bold,
    'italic': italic,
    'underline': underline,
    'backColor': backColor,
    'dateString': dateString
  };

  Note.fromJson(Map<String, dynamic> json) {
    noteID = json['noteID'];
    fav= json['fav'];
    text = json['text'];
    dateString=json['dateString'];
    if(json['bold'])
      bold=true;
    else
      bold=false;
    if(json['italic'])
      italic=true;
    else italic=false;
    if(json['underline'])
      underline=true;
    else underline=false;
    backColor= json['backColor'];
    backgroundColor= Color(backColor);
    textStyle= TextStyle(
      fontWeight: bold==true ? FontWeight.bold: FontWeight.normal,
      fontStyle: italic==true? FontStyle.italic: FontStyle.normal,
      decoration: underline== true? TextDecoration.underline: TextDecoration.none,
      fontSize: 20
    );



  }
  void edit(Note editedNote){
    text= editedNote.text;
    fav=editedNote.fav;
    textStyle= editedNote.textStyle;
    backgroundColor=editedNote.backgroundColor;
    if(textStyle.fontWeight== FontWeight.bold)
      bold=true;
    else
      bold=false;
    if(textStyle.fontStyle== FontStyle.italic)
      italic=true;
    else italic=false;
    if(textStyle.decoration== TextDecoration.underline)
      underline=true;
    else underline=false;
    backColor= backgroundColor.value;
  }

}

