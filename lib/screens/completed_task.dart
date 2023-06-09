import 'package:flutter/material.dart';

import '../helper/auth_helper.dart';
import '../models/todo.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Tasks"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: AuthHelper.instance.getCompletedTodos(),
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
              final data = snapshot.data as List<TodoModel>;

              if(data.isEmpty) {
                return const Center(
                  child: Text("Nothing to show", style: TextStyle(color: Colors.black, fontSize: 17),),
                );
              } else {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.done, color: Colors.green,),
                        title: Text(
                          data[index].title!,
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        subtitle: Text(
                          data[index].description!,
                          style: TextStyle(color: Colors.black54, fontSize: 15),
                        ),
                      );
                    });
              }
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
