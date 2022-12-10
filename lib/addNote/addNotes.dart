import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/alert.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);
  @override
  _AddNotesState createState() => _AddNotesState();
}

  File? file ;
class _AddNotesState extends State<AddNotes> {
  //late File file;
  late Reference ref;
  var title, note, imageUrl;

  CollectionReference noteRef = FirebaseFirestore.instance.collection("Notes");

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  addNotes(context) async{
    if(file == null)
      return AwesomeDialog(context: context,
          title: "Error",
          body: Text("You must add image"),
          dialogType: DialogType.ERROR)
        ..show();


    var formdata = formstate.currentState;
    if(formdata!.validate()){
      showLoading(context);
     formdata.save();

     await ref.putFile(file!);
     imageUrl = await ref.getDownloadURL();

     await noteRef.add({
       "title" : title,
       "note" : note,
       "imageUrl" : imageUrl,
       "userId" : FirebaseAuth.instance.currentUser!.uid

     }).then((value){
       Navigator.of(context).pushReplacementNamed("homePage");
     }).catchError((e){
       print("$e");
     });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Note"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val){
                          if(val!.length > 30){
                            return "Title must be less than 30";
                          }
                          if(val!.length < 1){
                            return "Title must be more than 1";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          title = val;
                        },
                        maxLength: 30,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1)),
                            hintText: "Title",
                            prefixIcon: Icon(Icons.note)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val){
                          if(val!.length > 200){
                            return "Note must be less than 200 letter";
                          }
                          if(val!.length < 5){
                            return "Note must be more than 5 letter";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          note = val;
                        },
                        maxLength: 200,
                        maxLines: 2,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                          hintText: "Note",
                          prefixIcon: Icon(Icons.notes),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 70, right: 70),
                        child: ElevatedButton(
                          child: Row(
                            children: [
                              Icon(Icons.image),
                              SizedBox(
                                width: 20,
                              ),
                              Text("Add Image"),
                            ],
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Choose Photo From :",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            var picked = await ImagePicker()
                                                .getImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (picked != null) {
                                              file = File(picked.path);
                                              var randomNumber =
                                                  Random().nextInt(100000000);
                                              var imageName = "$randomNumber" +
                                                  basename(picked.path);
                                               ref = FirebaseStorage.instance
                                                  .ref("images")
                                                  .child(imageName);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Icon(Icons.photo),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "Gallary",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            var picked = await ImagePicker()
                                                .getImage(
                                                    source: ImageSource.camera);
                                            if (picked != null) {
                                              file = File(picked.path);
                                              var randomNumber =
                                                  Random().nextInt(100000000);
                                              var imageName = "$randomNumber" +
                                                  basename(picked.path);
                                               ref = FirebaseStorage.instance
                                                  .ref("images")
                                                  .child(imageName);
                                               Navigator.of(context).pop();
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Icon(Icons.camera),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "Camera",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    height: 170,
                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: ElevatedButton(
                          child: Text("Add Note"),
                          onPressed: () async{
                            print("object");
                          await addNotes(context);
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 10),
                              primary: Colors.blue,
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ));
  }
}
/*
  await ref.putFile(file);
  imageUrl = await ref.getDownloadURL();
 */