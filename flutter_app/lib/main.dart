import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    TextStyle style=TextStyle(fontSize: 100.0);
    return MaterialApp(
      routes: <String,WidgetBuilder>{
        '/':(BuildContext context)=>new Screen1(),
      },

        );
  }
}

class Screen1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Screen1"),),
        body: Column(children:<Widget>[
          RaisedButton(onPressed:() {
             callMockableEndpoint().then((data)=>print(data.msg));
            },
          child: Text("https get"),)
        ])

    );
  }

 Future<Data>  callMockableEndpoint() async {
   final respond= await http.get("https://demo0968040.mockable.io/aaa");
   if (respond.statusCode==200){
     return Data.fromJson(json.decode(respond.body));
   }
   else{
     throw Exception("Failed");
   }
  }
}

class Data {
  String msg;
  Data(this.msg);

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(json["msg"]);
  }

}