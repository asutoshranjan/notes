import 'package:flutter/material.dart';
import 'package:notes/helper/auth_helper.dart';
import 'package:notes/models/users.dart';
import 'package:notes/screens/auth/signup_screen.dart';

import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User myUser = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                  myUser.email = val;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Password"),
              onChanged: (val) {
                setState(() {
                  myUser.password = val;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logging in...')));
                try {
                  await AuthHelper.instance.loginEmailPassword(
                    myUser.email!,
                    myUser.password!,
                  ).then((result) {
                    if(result) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logged in')));
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
              child: Text("Login"),
            ),
            InkWell(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignUpScreen(),
                  ),
                );
              },
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
