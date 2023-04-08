import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:notes/screens/splash_screen.dart';


Client client = Client();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  /// Use http://10.0.2.2/v1 for if running on emulator
  client.setEndpoint('http://10.0.2.2/v1').setProject('6422acc2d3b6a95a0b0c').setSelfSigned(status: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


