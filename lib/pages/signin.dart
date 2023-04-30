import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vqa/pages/homepage.dart';
import 'package:vqa/pages/signup.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  final userText = TextEditingController();
  final passText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 90, 0, 40),
              height: 300,
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/result.jpg',
                ),
              ),
            ),
          ),
          Center(
              child: Container(
            margin: EdgeInsets.all(30),
            child: Text(
              'Sign In',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        hintText: 'Email Id',
                      ),
                      controller: userText,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                      controller: passText,
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            fixedSize: MaterialStatePropertyAll(Size(200, 60))),
                        onPressed: () {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: userText.text, password: passText.text)
                              .then((value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homePage()),
                                ModalRoute.withName("/Home"));
                          }).onError((error, stackTrace) {
                            final snackBar = SnackBar(
                              content:
                                  const Text('Email or Password Incorrect'),
                              action: SnackBarAction(
                                label: 'Retry',
                                textColor: Colors.black,
                                onPressed: () {
                                  userText.clear();
                                  passText.clear();
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
                        child: Text('Sign In'),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: TextButton(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => signUp()),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
