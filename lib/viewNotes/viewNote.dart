import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget{
  final listOfNote;
  ViewNote({Key? key,this.listOfNote})  : super(key: key);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote>{
  @override
   Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("View Notes"),
      ),
      body: Container(
        child: Column(children: [
            Container(
              child: Image.network("${widget.listOfNote["imageUrl"]}" ,
                width: double.infinity, height: 300, fit: BoxFit.fill,),
            ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text("${widget.listOfNote["title"]}",
              style: TextStyle(fontWeight:FontWeight.bold,fontSize: 30,color: Colors.red),),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text("${widget.listOfNote["note"]}",
              style: TextStyle(fontSize: 20),),
          )

        ],),
      ),
    );

  }
}