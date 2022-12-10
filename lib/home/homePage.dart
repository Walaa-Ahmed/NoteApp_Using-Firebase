import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app_with_auth/viewNotes/viewNote.dart';
import '../editNotes/editNote.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CollectionReference noteRef = FirebaseFirestore.instance.collection("Notes");

 /* List notes = [
    {"note": "this is note 1 this is note 1 this is note 1 this is note 1", "image": "images/logo.png"},
    {"note": "this is note 2 this is note 2 this is note 2 this is note 2", "image": "images/logo.png"},
    {"note": "this is note 3 this is note 3 this is note 3 this is note 3", "image": "images/logo.png"},
    {"note": "this is note 4 this is note 4 this is note 4 this is note 4", "image": "images/logo.png"},
    {"note": "this is note 5 this is note 5 this is note 5 this is note 5", "image": "images/logo.png"},
    {"note": "this is note 6 this is note 6 this is note 6this is note 6", "image": "images/logo.png"},
  ];
*/
  getUser(){
    var user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Home Page"),
            actions: [
              IconButton(onPressed: ()async{
                AwesomeDialog(context: context,dialogType: DialogType.question,title: "Confirm",body: Text("Do you want to SignOut ?"),btnCancelText: "No",btnCancelOnPress: (){
                },btnOkText: "Yes",btnOkOnPress: ()async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed("loginPage");
                })..show();

              }, icon: Icon(Icons.exit_to_app) )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).pushNamed("addNotes");
              print("new note");
            },
            child: Icon(Icons.add),
          ),
          body: Container(
              child: FutureBuilder(
                  future: noteRef.where("userId" , isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                     return ListView.builder(
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (context, index) {
                       return Dismissible(
                         onDismissed: (direction) async{
                          await noteRef.doc(snapshot.data!.docs[index].id).delete();
                          await FirebaseStorage.instance.refFromURL(snapshot.data!.docs[index]["imageUrl"]).delete();

                          print("===========================================");
                          print("Delete");
                          print("============================================");
                         },
                           key: Key("$index"),
                           child: InkWell(
                             onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                 return ViewNote(listOfNote: snapshot.data!.docs[index]);
                               }));
                             },
                             child: Card(
                               child: ListTile(
                                 title: Text("${snapshot.data!.docs[index]["title"]}"),
                                 subtitle: Text("${snapshot.data!.docs[index]["note"]}"),
                                 leading: Image.network("${snapshot.data!.docs[index]["imageUrl"]}"),
                                 trailing: IconButton(
                                   icon: Icon(Icons.edit),
                                   onPressed: (){
                                     var id = "${snapshot.data!.docs[index].id}";
                                     print(id);
                                     Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                       return EditNote(docId: id,list: snapshot.data!.docs[index]);
                                     }));
                                   },
                                 ),
                               ),
                             ),
                           ));
                     });
                    }
                   return CircularProgressIndicator();
              })

            ),
          ),
    );
  }
}


/*
return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context , i){
                       return Text("${snapshot.data!.docs[i].data()["title"]}");
                      });
 */


/*
ListView.builder(itemCount: notes.length, itemBuilder: (context, index) {
                    return Dismissible(
                        key: Key("$index"),
                        child: Card(
                        child: ListTile(
                        title: Text("${notes[index]["note"]}"),
                        leading: Image.asset("${notes[index]["image"]}"),
                        trailing: Icon(Icons.edit),
                      ),
                       ));
                  }),
 */