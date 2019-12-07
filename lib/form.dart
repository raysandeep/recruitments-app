import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';




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

class FormPage extends StatefulWidget {
  
  @override
  _FormPageState createState() => new _FormPageState();
}


class _FormPageState extends State<FormPage> {
  bool _management =false;
  bool _technical=false;
  bool _design=false;
  double _skillLevel = 1;
  double _capabilityLevel = 1;
  double _depthLevel=1;
  int _res = 0;
  String _resp = "";
 String _counter,_val = "";
  int _page = 1;
  
  String review="";
  GlobalKey _bottomNavigationKey = GlobalKey();
  final myController = TextEditingController();

  Future _MakePostRequest() async {
    
    String url = 'http://iothinc.herokuapp.com/api/';
    Map<String, String> headers = {"Content-type": "application/json"};
    final prefs = await SharedPreferences.getInstance();
    final myString = prefs.getString('email') ?? '';
    print(myString);
    review=myController.text;
    String json = '{"reg": "$_val", "skills": "$_skillLevel", "capability": "$_capabilityLevel","depth":"$_depthLevel","tech":"$_technical","management":"$_management","design":"$_design","final_bool":"true","final_review":"$review","username":"$myString"}';

    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    String body = response.body;
    print(statusCode);
    print(body);
    if(statusCode == 201){
      _technical=false;
      _design = false;
      _management=false;
      _skillLevel=1;
      _capabilityLevel=1;
      _depthLevel=1;
      _res=0;
      _val="";
      _counter="";
      _resp="";
      Fluttertoast.showToast(
        msg: "Submitted Succesfully!",
        textColor: Colors.black,
        timeInSecForIos: 1,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
  );
    }

  }
  Future _Scanner() async{
    _counter = await FlutterBarcodeScanner.scanBarcode("#004297","Cancel",true);
    setState(() {
      _val=_counter;
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Colors.black,
          child: ListView(
            
            children: <Widget>[
              Container(
                
                child: Stack(
                  children: <Widget>[
                    Container(
                      
                      padding: EdgeInsets.fromLTRB(15.0, 60.0, 0.0, 0.0),
                      child: Text('IoThinC',
                          style: TextStyle(
                              fontSize: 45.0, color:Colors.white,fontWeight: FontWeight.bold)),
                                    ),
                                    
                                  ],
                                ),
                              ),
                        Container(
                            padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  
                          '$_val',
                          style: TextStyle(fontFamily: 'Montserrat',fontSize: 60,color: Colors.white,fontWeight: FontWeight.bold),
                          
                        ),
                        SizedBox(height:50),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: GestureDetector(
                            child: Text("Scan" , style:TextStyle(color: Colors.black,fontSize: 20)),
                            onTap: _Scanner,
                          ),

                        ),
                        SizedBox(height: 20,),
                        Slider.adaptive(
                        value: _skillLevel.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            _skillLevel = newValue;
                          });
                        },
                        activeColor: Colors.blue,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: _skillLevel.toString(),
                    ),
                    
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Text(
                            'Skills',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        
                      ),
                      SizedBox(height: 20.0),
                      Slider.adaptive(
                        value: _capabilityLevel.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            _capabilityLevel = newValue;
                          });
                        },
                        activeColor: Colors.blue,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: _capabilityLevel.toString(),
                    ),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Text(
                            'Capability',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        
                      ),
                      SizedBox(height: 20.0),
                      Slider.adaptive(
                        value: _depthLevel.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            _depthLevel = newValue;
                          });
                        },
                        activeColor: Colors.blue,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: _depthLevel.toString(),
                    ),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top: 15.0, left: 20.0),
                          child: Text(
                            'Knowledge Depth',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'),
                          ),
                        
                      ),
                      Container(
                      padding: EdgeInsets.fromLTRB(16.0, 30.0, 0.0, 0.0),
                      child: Text('Domain',
                          style: TextStyle(
                              fontSize: 25.0,color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                      SizedBox(height: 5.0),
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.blue),
                        child: CheckboxListTile(
                          value: _management,
                          activeColor: Colors.green,
                          checkColor: Colors.green,
                          title:Text('Management',style: TextStyle(color: Colors.white)),
                          onChanged: (bool value){
                            setState(() {
                              _management = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.blue),
                        child: CheckboxListTile(
                          value: _technical,
                          title:Text('Technical',style: TextStyle(color: Colors.white),),
                          
                          activeColor: Colors.green,
                          checkColor: Colors.green,
                          onChanged: (bool value){
                            setState(() {
                              _technical = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.blue),
                        child: CheckboxListTile(
                          value: _design,
                          title:Text('Design',style: TextStyle(color: Colors.white)),
                          activeColor: Colors.green,
                          checkColor: Colors.green,
                          onChanged: (bool value){
                            setState(() {
                              _design = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 40.0),
                     Theme(
                        data: new ThemeData(
                          primaryColor: Colors.green,
                          primaryColorDark: Colors.green,
                          cardColor: Colors.white
                        ),
                        child: new TextFormField(
                          controller: myController,
                          style:TextStyle(color: Colors.white),
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.green)),
                              hintText: 'Keep it short.',
                              labelText: 'Final Review',
                              labelStyle: TextStyle(color: Colors.white),
                              
                              
                        ),
                      )),
                      SizedBox(height: 20,),
                      GestureDetector(
                          onTap: _MakePostRequest,
                          child:Container(
                              height: 50.0,
                              width: 150,
                              child: Material(
                                borderRadius: BorderRadius.circular(30.0),
                                shadowColor: Colors.green,
                                color: Colors.yellow,
                                elevation: 7.0,
                                child: Center(
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(
                                        fontSize: 21,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                              ),
                            ),
                          
                        ),
                      SizedBox(height: 20.0),
                    ],
                  )),
              SizedBox(height: 15.0),
            ],
          ),
        ),
        
        );
  }
}
