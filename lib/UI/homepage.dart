import 'dart:convert';
import 'package:api2/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PRODUCTS"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final id = users[index];
            final name = id.name;
            final price = id.price;


            return ListTile(
              title: Text(name),
              subtitle: Text("$price"),
              leading: Image.network(id.image),

            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: FetchData,
      ),
    );
  }

  void FetchData() async {
    print("hello data");
    const url = 'https://dummyapi.online/api/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    final res=json ['User'] as List<dynamic>;
    final data=res.map((e) {
      return User(
        id:e['id'],
        name:e['name'],
        price:e['price'],
        image:e['image'],
        description:e['description'],
      );

    }).toList();

    setState(() {
      users = data;
    });
   print("END");
  }
}