import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home.dart';

class WelcomeScreen extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                auth.currentUser.email,
                style: TextStyle(fontSize: 25),
              ),
              ElevatedButton(
                child: Text("Log out"),
                onPressed: () {
                  auth.signOut().then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  });
                },
              )
            ])),
      ),
    );
  }
}
