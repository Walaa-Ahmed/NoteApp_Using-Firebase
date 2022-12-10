import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

 /*   List usersData = [];

    CollectionReference userRef = FirebaseFirestore.instance.collection("users");


  getData()async{

    var responce =  await userRef.get();
    responce.docs.forEach((element) {
      setState(() {
        usersData.add(element.data());
      });
      print(usersData);
    });

    //RealTime DataBase..........
   /* FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      event.docs.forEach((element) {
        print("======================================================");
        print("username  :  ${element.data()["username"]}");
        print("age  :  ${element.data()["age"]}");
        print("email  :  ${element.data()["email"]}");
        print("======================================================");
      });
    });*/


  //  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

    //Adding Data......
   /* userRef.add({
      "username" : "ali",
      "age" : 22,
      "email" : "ali@gmail.com"
    });*/

   /* userRef.doc("123456").set({
      "username" : "ali",
      "age" : 22,
      "email" : "ali@gmail.com"
    });*/


    //Update Data........
   /* userRef.doc("123456789").set({
      "age" : 44,
    },SetOptions(merge: true)
    );

    userRef.doc("1234567").update({
      "age" : 46,
    });
*/
    //Catch && Then && Delete

   /* userRef.doc("123456").delete().then((value) {
      print("Delete Success");
    }).catchError((e){
      print("Error : $e");
    });
*/

//Nested Collection
  /*
    CollectionReference userRef = FirebaseFirestore.instance.collection("users").doc("7DqFgqFCnVJUjCzXFPEi").collection("address");
    userRef.add({
      "city" : "alex",
      "country" : "egypt"
    });*/

//Firebase FireStore...............
  /*  FirebaseFirestore.instance.collection("users").get().then((value){
      value.docs.forEach((element) {
        print("======================================================");
        print("username  :  ${element.data()["username"]}");
        print("age  :  ${element.data()["age"]}");
        print("email  :  ${element.data()["email"]}");
        print("======================================================");
      });
    });
*/

  /*  var docs =FirebaseFirestore.instance.collection("users").doc("7DqFgqFCnVJUjCzXFPEi");
    await docs.get().then((value){
      print(value.data());
    });*/
  }

  // transaction..................
/*  DocumentReference userdoc = FirebaseFirestore.instance.collection("users").doc("7DqFgqFCnVJUjCzXFPEi");

  trans() async{
    FirebaseFirestore.instance.runTransaction((transaction) async {

      DocumentSnapshot documentSnapshot = await transaction.get(userdoc);

      if(documentSnapshot.exists){
       transaction.update(userdoc, {
         "phone" : "88888888888"
       });
      }
      else{
        print("user not exist");
      }

    });
  }
*/


  // Batch write........
 /* DocumentReference userdoc1 = FirebaseFirestore.instance.collection("users").doc("7DqFgqFCnVJUjCzXFPEi");

  DocumentReference userdoc2 = FirebaseFirestore.instance.collection("users").doc("mQPkT7J5lJyQrvkPnEP6");

    batchWrite() async{

      WriteBatch batch = FirebaseFirestore.instance.batch();

      batch.delete(userdoc2);
      batch.update(userdoc1, {
        "phone" : "5555555"
      });

      batch.commit();
  }
*/

  */


  // FireStorage..............

  late File file;

  var imgPicker = ImagePicker();

  uploadImage() async{
    var img = await imgPicker.getImage(source: ImageSource.camera);
    if(img != null){
      file = File(img.path);
      var imgName = basename(img.path);
     /* print("===========================================");
      print(img.path);
      print("===========================================");
      print(imgName);*/

      //Start Upload......

      var randam = Random().nextInt(100000000);

      imgName = "$randam$imgName";

      print("====================imgName=========================");
      print(imgName);
      print("======================imgName=======================");


      var ref = FirebaseStorage.instance.ref("$imgName");

      await ref.putFile(file);

      var url = await ref.getDownloadURL();

      print("===========================================");
      print("Url : $url");
      print("===========================================");

      //End Upload........

    }
    else{
      print("Please Choose Image");
    }
  }

getImages() async{
    var ref = await FirebaseStorage.instance.ref().listAll();

  /*  ref.items.forEach((element) {
      print("===========================================");
      print(element.fullPath);
      print("===========================================");
    });*/

    ref.prefixes.forEach((element) {
      print("===========================================");
      print(element.name);
      print("===========================================");
    });
}



  @override
  void initState() {
    // TODO: implement initState
    getImages();
    //getData();
    //trans();
   // batchWrite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Test Page"),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: () async{
               await uploadImage();

            }, child: Text("Upload Image"))
          ],
        )
    );
  }
}
