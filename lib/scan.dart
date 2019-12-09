import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(new MaterialApp(
    home: new ScanP(),
  ));
}

class ScanP extends StatefulWidget {
  @override
  _ScanPageState createState() => new _ScanPageState();
}

class _ScanPageState extends State<ScanP> {
  
  List data;
  bool value = false;
  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final myString = prefs.getString('email') ?? '';
    String url = "https://iothinc.herokuapp.com/api/";  
    print(url);
    bool down = true;
     if (down == true){
      Fluttertoast.showToast(
        msg: "Loading!",
        textColor: Colors.black,
        timeInSecForIos: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
      );
     };   
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {
        "Accept": "application/json"
      }
    );
    this.setState(() {
      data = json.decode(response.body);
    });
    down = false;
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
          return new  GridView.count(
                    crossAxisCount: 2,
                    primary: false,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 4.0,
                    shrinkWrap: true,
                    children: <Widget>[
                      _buildCard(data[index]["reg"], data[index]["final_review"], true),
                       _buildCard(data[index]["reg"], data[index]["final_review"], true),
                     

            ],
          );
        },
      ),
    );
  }
  Widget _buildCard(String reg, String finalreview, bool selected){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      elevation: 7.0,
      child: Column(
        children: <Widget>[
          SizedBox(height: 15,),
          Text(reg, style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          Text(finalreview,style: TextStyle(color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),)

        ],
      ),
    );
  }
}