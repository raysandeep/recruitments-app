import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'form.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codechef',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(
      seconds: 5
      ),()async{
        final prefs = await SharedPreferences.getInstance();
        final myString = prefs.getString('token') ?? '';
        if(myString==''){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> Login(),),);
        }
        else{
        Navigator.push(context,MaterialPageRoute(builder: (context)=> Routes(),),);

        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Center(
            child: Image.asset("assets/gif/splash1.gif",),
            
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0XFF000000),
        )
        
      ),
    );
  }
}
