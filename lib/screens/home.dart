import 'dart:convert';

import 'package:apicalls/model/user.dart';
import 'package:apicalls/model/user_name.dart';
import 'package:apicalls/services/user_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Code toh koi bhi bana leta ussko implement har koi nhi kr pata"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            //final name = user['name'];

            final email = user.email;
            final color = user.gender == 'male' ? Colors.blue : Colors.red;

            return ListTile(
              //child: Text('${index + 1}')),
              //title: Text(name.toString()),
              //title: Text(user.fullName),
              //subtitle: Text(user.phone),
              title: Text(user.location.country),
              subtitle: Text(user.location.state),
              //country,postcode
              tileColor: color,
            );
          }),
    );
  }

  Future<void> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    setState(() {
      users = response;
    });
  }
}
