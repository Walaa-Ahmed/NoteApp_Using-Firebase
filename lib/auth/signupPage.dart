import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late UserCredential userCredential;

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var myuserName,myemail,myphone,mypassword,confirmPassword;



  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  signUp() async{

    var formdata = formstate.currentState;
    if(formdata!.validate()){
print("vaild............");

formdata.save();
try {
  userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: myemail, password: mypassword);
  print("my email : $myemail");
  print("mypassword : $mypassword");
  return userCredential;
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    AwesomeDialog(context: context,title: "Error" ,body: Text("The password provided is too weak"))..show();
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    AwesomeDialog(context: context,title: "Error" ,body: Text("The account already exists for that email"))..show();
    print('The account already exists for that email.');
  }
} catch (e) {
  print("errrrrrrrrrrrrrrrror$e");
}

    }
    else{
      print("Not Valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
            children: [
              SizedBox(height: 100),
              Center(child: Image.asset("images/logo.png")), //logo image

              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formstate,
                    child:Column(
                      children: [

                        TextFormField(
                          onSaved: (val){
                            myuserName = val;
                          },
                          validator: (val){
                            if(val!.length>100){
                              return "userName can not be more than 100 letter";
                            }
                            if(val!.length<3){
                              return "userName can not be less than 3 letter";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1)
                              ),
                              hintText: "Username",
                              prefixIcon: Icon(Icons.person)
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          onSaved: (val){
                            myemail = val;
                          },
                          validator: (val){
                            if(val!.length>100){
                              return "Email can not be more than 100 letter";
                            }
                            if(val!.length<15){
                              return "Email can not be less than 15 letter";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1)
                              ),
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined)
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          onSaved: (val){
                            myphone = val;
                          },
                          validator: (val){
                            if(val!.length!=11){
                              return "phone must be 11 number";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1)
                              ),
                              hintText: "Phone",
                              prefixIcon: Icon(Icons.phone)
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          onSaved: (val){
                            mypassword = val;
                          },
                          validator: (val){
                            if(val!.length>20){
                              return "password can not be more than 20 letter";
                            }
                           /* if(val!.length<6){
                              return "password can not be less than 6 letter";
                            }*/
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1)
                            ),
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password),
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          onSaved: (val){
                            confirmPassword = val;
                          },
                          validator: (val){
                            if(val!.length>20){
                              return "password can not be more than 20 letter";
                            }
                            if(val!.length<6){
                              return "password can not be less than 6 letter";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1)
                            ),
                            hintText: "Confirm Password",
                            prefixIcon: Icon(Icons.password),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text("Already have Account "),
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).pushReplacementNamed("loginPage");
                                },
                                child: Text("Click here",style: TextStyle(color: Colors.red),),)
                            ],
                          ),
                        ),

                        Container(
                          child: ElevatedButton(
                            child: Text("Sign Up"),
                            onPressed: () async{
                            UserCredential response = await signUp();
                            print(response);
                            if(response !=null){

                              await FirebaseFirestore.instance.collection("Users").add({

                                "username" : myuserName,
                                "email"  : myemail,
                                "phone" : myphone

                              });


                              Navigator.of(context).pushReplacementNamed("homePage");
                            }
                            else{
                              AwesomeDialog(context: context,title: "Error" , body: Text("SignUp Filed Go To Login Page"),btnOkText: "Go To Login Page",btnOkOnPress: (){
                                Navigator.of(context).pushNamed("loginPage");
                              })..show();
                            }
                             // Navigator.of(context).pushReplacementNamed("homePage");
                            },
                            style: ElevatedButton.styleFrom(primary: Colors.blue[900],textStyle: TextStyle(color: Colors.white,fontSize: 20)),
                          ),
                        )


                      ],
                    )
                ),
              )
            ],
          ),


    );
  }
}
