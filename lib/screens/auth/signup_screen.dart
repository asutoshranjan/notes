import 'package:flutter/material.dart';
import 'package:notes/screens/auth/login_screen.dart';

import '../../helper/auth_helper.dart';
import '../home_screen.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String? name;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Email"),
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Name"),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signing you up...')));
                try {
                  await AuthHelper.instance.signUpEmailPassword(
                    email!,
                    password!,
                    name!,
                  ).then((result) {
                    if(result) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('New Account Created..')));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                      );
                    }
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.toString())));
                }
              },
              child: Text("Sign Up"),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}

