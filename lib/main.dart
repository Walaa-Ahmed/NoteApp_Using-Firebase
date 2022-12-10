import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app_with_auth/addNote/addNotes.dart';
import 'package:note_app_with_auth/auth/login.dart';
import 'package:note_app_with_auth/auth/loginPage.dart';
import 'package:note_app_with_auth/auth/signupPage.dart';
import 'package:note_app_with_auth/home/homePage.dart';
import 'package:note_app_with_auth/test.dart';

bool isLogin = false;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if(user == null){
    isLogin = false;
  }
  else{
    isLogin = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Demo',
      routes: {
        "loginPage" : (context) => LoginPage(),
        "signUpPage" : (context) => SignUpPage(),
        "homePage" : (context) => HomePage(),
        "addNotes" : (context) => AddNotes()
      },
      //home: Test(),
      home: isLogin == false ? LoginPage() : HomePage()
    );
  }
}

