import 'package:flutter/material.dart';
import 'package:flutter_fire_auth/utils/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100.0),
              Text(
                "Signup",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Continue with Google"),
                onPressed: () async {
                  bool res = await AuthProvider().loginWithGoogle();
                  if (!res) print("error logging in with google");
                },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Enter email"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              const SizedBox(height: 10.0),
              RaisedButton(
                child: Text("Create Account"),
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  bool res = await AuthProvider().signupWithEmail(
                      _emailController.text, _passwordController.text);
                  if(res) {
                    _emailController.clear();
                    _passwordController.clear();
                    Navigator.pop(context);
                  }
                  if (!res) {
                    print("Account creation failed");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
