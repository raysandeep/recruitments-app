import 'package:codechef/form.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'routes.dart';


void main() => runApp(new Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  String _email;
  String _password;
  String _valer;

   
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Colors.black,
          child: Column(
             
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
               
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text('Hello',
                          style: TextStyle(
                              fontSize: 60.0,color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                      child: Text('Login',
                          style: TextStyle(
                              fontSize: 60.0,color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(180.0, 175.0, 0.0, 0.0),
                      child: Text('.',
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    )
                  ],
                ),
              ),
              Container(
                  
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                            labelText: 'EMAIL',

                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                                onChanged: (value) => _email = value,
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                            
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                            
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        obscureText: true,
                        onChanged: (value) => _password = value,

                      ),
                      SizedBox(height: 5.0),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        padding: EdgeInsets.only(top: 15.0, left: 20.0),
                        child: InkWell(
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: Toast,
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
                                    'DIVE IN',
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

                      SizedBox(height: 100.0),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 200,
                            child: Image.asset("assets/gif/iot.gif",),),
                            SizedBox(width: 150,)
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
void Toast(){
     setState(() async{
        String url = 'http://iothinc.herokuapp.com/token/';
        Map<String, String> headers = {"Content-type": "application/json"};
        String json = '{"username":"$_email", "password": "$_password"}';
        bool down = true;
        if (down == true){
          Fluttertoast.showToast(
            msg: "Logging In!",
            textColor: Colors.black,
            timeInSecForIos: 1,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
      );
        };   
        Response response = await post(url, headers: headers, body: json);
        int statusCode = response.statusCode;
        String body = response.body;
        print(statusCode);
        print(body.split('":"')[1].split("\"}")[0]);
        down = false;
        
         if (statusCode==200){
           final prefs = await SharedPreferences.getInstance();
           prefs.setString('email', _email);
           prefs.setString('pass', _password);
           prefs.setString('token', body.split('":"')[1].split("\"}")[0]);

           Fluttertoast.showToast(
            msg: "Sign in Succesful!",
            textColor: Colors.black,
            timeInSecForIos: 1,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
      );
           Navigator.push(context,MaterialPageRoute(builder: (context)=> Routes(),),);
    }
      else{
       Fluttertoast.showToast(
            msg: "Sign in Unsuccesful!",
            textColor: Colors.black,
            timeInSecForIos: 1,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
      );

      }
       

     });
  
   }

  saveData(String email, String password) async{
   
  }
}
