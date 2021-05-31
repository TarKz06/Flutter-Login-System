import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formkey = GlobalKey<FormState>();
  Profile profile = Profile();

  @override
  Widget build(BuildContext context) {
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
                      RequiredValidator(errorText: "pls fill your email"),
                      EmailValidator(errorText: "Your email not correct")
                    ]),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String email) {
                      profile.email = email;
                    },
                  ),
                  TextField(),
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
                      onPressed: () {
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                          print(
                              "email = ${profile.email} password = ${profile.password}");
                          formkey.currentState.reset();
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
}
