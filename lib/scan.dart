import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() => runApp(new ScanP());

class ScanP extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var formPage = new ScanPage();
        return new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: formPage,
    );
  }
}


class ScanPage extends StatefulWidget {
  
  @override
  _ScanPage createState() => new _ScanPage();
}

class _ScanPage extends State<ScanPage> {
  String _counter,_val = "";
  Future _Scanner() async{
    _counter = await FlutterBarcodeScanner.scanBarcode("#004297","Cancel",true);
    setState(() {
      _val=_counter;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          color: Colors.red
        ),
      ) ,
        );
  }
}

  