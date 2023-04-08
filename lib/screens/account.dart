import 'package:flutter/material.dart';
import 'package:notes/helper/auth_helper.dart';
import 'package:notes/screens/home_screen.dart';

import 'auth/login_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Account'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  AuthHelper.instance.logout();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Logged Out')));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: AuthHelper.account.get(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data ;
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            snapshot.data!.name,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            snapshot.data!.email,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
