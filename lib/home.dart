import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';
import 'package:hive_task/models/user.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageScreen();
}

class _MyHomePageScreen extends State<MyHomePage> {
  final usersbox = Hive.box<UserModel>('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Users",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: usersbox.listenable(),
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: usersbox.length,
            itemBuilder: (context, index) {
              var user = usersbox.getAt(index);
              return ListTile(
                leading: Text(user!.id.toString()),
                title: Text(user!.name),
                subtitle: Text(user!.email),
                trailing: IconButton(
                  onPressed: () {
                    usersbox.deleteAt(index);
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          usersbox.add(
            UserModel(
              id: usersbox.length + 1,
              name: "Hady",
              email: "hady@gmail.com",
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
