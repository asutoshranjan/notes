import 'package:flutter/material.dart';

import '../helper/auth_helper.dart';
import '../models/todo.dart';

class UnfinishedTask extends StatefulWidget {
  const UnfinishedTask({Key? key}) : super(key: key);

  @override
  State<UnfinishedTask> createState() => _UnfinishedTaskState();
}

class _UnfinishedTaskState extends State<UnfinishedTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unfinished Tasks"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: AuthHelper.instance.getUnfinishedTodos(),
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
                        leading: const Icon(Icons.adjust_outlined, color: Colors.deepOrangeAccent,),
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