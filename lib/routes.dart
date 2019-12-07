
import 'package:flutter/material.dart';
import 'main.dart';
import 'scan.dart';
import 'form.dart';
import 'list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


void main() => runApp(new Forma());

class Forma extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formPage = new FormPage();
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: formPage,
    );
  }
}

class Routes extends StatefulWidget {
  
  @override
  _RoutesPage createState() => new _RoutesPage();
}


class _RoutesPage extends State<Routes> {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  Widget callPage(int _currentIndex){
    switch (_currentIndex) {
      case 0: return ListPage();
      case 1: return FormPage();
      case 2:return ScanPage();
        
        break;
      default: return FormPage();
    }

  }
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     bottomNavigationBar: CurvedNavigationBar(
       //key: _currentIndex,
       onTap: (value){
         _currentIndex = value;
         setState(() {
           
         });
       },
       items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),

       ],
     ),
     body: callPage(_currentIndex),
   );
 }
}