import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(new MaterialApp(
    home: new ListPage(),
  ));
}

class ListPage extends StatefulWidget {
  @override
  ListPageState createState() => new ListPageState();
}

class ListPageState extends State<ListPage> {
  
  List data;
  bool value = false;
  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final myString = prefs.getString('email') ?? '';
    String url = "https://rec-cc.herokuapp.com/filter/?username=$myString";  
    print(url);
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );
    this.setState(() {
      data = json.decode(response.body);
    });
    print(data[1]["title"]);
    
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: Container(
              child: Column(
                children: <Widget>[
                  
                  new Text(data[index]["reg"]),
                  new Text(data[index]["final_review"]),
                ],
              )),
          );
        },
      ),
    );
  }
}