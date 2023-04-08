import 'package:flutter/material.dart';
import 'package:notes/helper/auth_helper.dart';
import 'package:notes/screens/home_screen.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  String title = "";
  String description = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Add Todo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              onChanged: (val) {
                setState(() {
                  title = val;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Description"),
              onChanged: (val) {
                setState(() {
                  description = val;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthHelper.instance
                    .createTodo(title: title, description: description)
                    .then((value) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                });
              },
              child: Text("Create Todo"),
            ),
          ],
        ),
      ),
    );
  }
}
