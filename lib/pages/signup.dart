import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vqa/pages/signin.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final user2Text = TextEditingController();
  final pass2Text = TextEditingController();
  final pass3Text = TextEditingController();

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
            margin: EdgeInsets.all(20),
            child: Text(
              'Sign Up',
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
                      controller: user2Text,
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
                      controller: pass2Text,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        icon: Icon(Icons.verified_user),
                        border: OutlineInputBorder(),
                        hintText: 'Confirm Password',
                      ),
                      controller: pass3Text,
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
                          if (pass2Text.text == pass3Text.text) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: user2Text.text,
                                    password: pass2Text.text)
                                .then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const signIn()),
                              );
                            }).onError((error, stackTrace) {
                              final snackBar = SnackBar(
                                content: const Text('Invalid Email'),
                                action: SnackBarAction(
                                  label: 'Retry',
                                  textColor: Colors.black,
                                  onPressed: () {
                                    user2Text.clear();
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          } else {
                            var snackBar2 = SnackBar(
                              content: Text('Password does not Match'),
                              action: SnackBarAction(
                                label: 'Retry',
                                textColor: Colors.black,
                                onPressed: () {
                                  pass2Text.clear();
                                  pass3Text.clear();
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar2);
                          }
                        },
                        child: Text('Sign Up'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
