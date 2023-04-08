import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/todo.dart';
import 'package:notes/screens/account.dart';
import 'package:notes/screens/add_todo_screen.dart';
import 'package:notes/screens/completed_task.dart';
import 'package:notes/screens/unfinished_task.dart';

import '../helper/auth_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoModel> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.adjust_outlined, color: Colors.deepOrangeAccent,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Unfinished Tasks")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.done, color: Colors.green,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Completed Tasks")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: const [
                    Icon(Icons.person_outline, color: Colors.deepPurple,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Profile")
                  ],
                ),
              ),
              // PopupMenuItem 2
              PopupMenuItem(
                value: 4,
                // row with two children
                child: Row(
                  children: const [
                    Icon(Icons.delete_outline, color: Colors.redAccent,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Delete All Task")
                  ],
                ),
              ),
            ],
            offset: Offset(0, 60),
            elevation: 2,
            onSelected: (value) async{
              // if else if ladder
              if (value == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UnfinishedTask(),
                  ),
                );
              } else if (value == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompletedTask(),
                  ),
                );
              } else if (value == 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountPage(),
                  ),
                );
              } else if (value == 4) {
                await AuthHelper.instance.deleteAllTodo(data);
                setState(() {
                  data  = [];
                });
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: AuthHelper.instance.getTodos(),
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
              data = snapshot.data as List<TodoModel>;
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Checkbox(
                        value: data[index].isDone ?? false,
                        onChanged: (bool? value) {
                          setState(() {
                            data[index].isDone = value;
                          });
                          AuthHelper.instance.updateTodo(data[index]);
                        },
                      ),
                      title: Text(
                        data[index].title!,
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      subtitle: Text(
                        data[index].description!,
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          TodoModel deleteModel = data[index];
                          setState(() {
                            data.remove(deleteModel);
                          });
                          AuthHelper.instance.deleteTodo(deleteModel);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red[400],
                        ),
                      ),
                    );
                  });
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddToDo()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
