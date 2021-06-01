import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Register"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "pls fill your email"),
                              EmailValidator(
                                  errorText: "Your email not correct")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String email) {
                              profile.email = email;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Password", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: ("Pls fill your Password")),
                            obscureText: true,
                            onSaved: (String password) {
                              profile.password = password;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                "Register",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () async {
                                if (formkey.currentState.validate()) {
                                  formkey.currentState.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value) {
                                      formkey.currentState.reset();
                                      Fluttertoast.showToast(
                                          msg: "Finish",
                                          gravity: ToastGravity.TOP);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomeScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    print(e.code);
                                    // print(e.message);
                                    String message;
                                    if (e.code == 'email-already-in-use') {
                                      message = "ใช้เมลอื่นนนนนน";
                                    } else if (e.code == 'weak-password') {
                                      message = "เลขไม่ครบ";
                                    } else {
                                      message = e.message;
                                    }
                                    Fluttertoast.showToast(
                                        msg: message,
                                        gravity: ToastGravity.TOP);
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    //
  }
}
