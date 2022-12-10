import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("images/logo.png"),
        Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            cursorColor: Colors.blue[900],
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(100, 13, 71, 161)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(100, 13, 71, 161)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(100, 13, 71, 161)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                hintText: "Username",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.blue[900],
                ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextFormField(
            cursorColor: Colors.blue[900],
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(100, 13, 71, 161)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(100, 13, 71, 161)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(100, 13, 71, 161)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                hintText: "Password",
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.blue[900],
                ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Row(
            children: [
              Text("if you have not account "),
              Text(
                "Click here",
                style: TextStyle(color: Colors.blue[900]),
              )
            ],
          ),
        ),
        Container(
            child: ElevatedButton(
          onPressed: () {},
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
        ))
      ],
    )));
  }
}
