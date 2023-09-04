import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = "https://swapi.dev/api/people";

  //final String url = "http://swapi.co/api/people";
  late List data = [];

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<void> getJsonData() async {
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"}, // Corrected header name
    );

    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        var convertDataToJson = jsonDecode(response.body);
        data = convertDataToJson['results'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Json via Http Get'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(data[index]['name']),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
