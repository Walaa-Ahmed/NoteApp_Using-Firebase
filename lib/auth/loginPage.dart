import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app_with_auth/components/alert.dart';


late UserCredential userCredential;

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
var myEmail,myPassword;

GlobalKey<FormState> formstate = new GlobalKey<FormState>();

signIn() async{
  var formdata = formstate.currentState;
  if(formdata!.validate()){
formdata.save();
    try {
      showLoading(context);
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: myEmail , password: myPassword);
      return userCredential;
     // print("results ======${userCredential.user!.email}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            title: "error",
            body: Text("No user found for that email"),
            dialogType: DialogType.ERROR )..show();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            title: "error",
            body: Text("Wrong password provided for that user"),
            dialogType: DialogType.ERROR )..show();
        print('Wrong password provided for that user.');
      }
    }


  }
  else{
    print("Not Valid");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Image.asset("images/logo.png")), //logo image

        Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formstate,
              child: Column(
            children: [
              TextFormField(
                onSaved: (val){
                  myEmail = val;
                },
                validator: (val){
                  if(val!.length>50){
                    return "email can not be more than 20 letter";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onSaved: (val){
                  myPassword = val;
                },
                validator: (val){
                  if(val!.length<6){
                    return "password can not be less than 6 number";
                  }
                  if(val!.length>20){
                    return "password can not be more than 20 number";
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text("if you have not account "),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed("signUpPage");
                      },
                      child: Text(
                        "Click here",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text("Loginn"),
                  onPressed: () async {

var user = await signIn();
if(user != null){
  Navigator.of(context).pushReplacementNamed("homePage");
}
print("===============================");
print(user);
print("===================================");
                    // Navigator.of(context).pushReplacementNamed("homePage");
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      textStyle: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              )
            ],
          )),
        )
      ],
    ));
  }
}

/*signUp() async {
  try {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "walaaahmed4442@gmail.com", password: "walaa+123456");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
*/



/*

/*signIn() async {
  try {
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "walaaahmed4442@gmail.com", password: "walaa+123456");
    print("results ======${userCredential.user!.email}");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }

  print(userCredential.user!.emailVerified);

  /*if(userCredential.user!.emailVerified == false){
   User? user = FirebaseAuth.instance.currentUser;
   await user!.sendEmailVerification();
   print("email sent");
  }*/

  User? user = FirebaseAuth.instance.currentUser;

  if (user!= null && !user.emailVerified) {
    await user.sendEmailVerification();
    print("email sentttttt");
  }
}


signGoogle(){
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


 */

 */