import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class Result extends StatefulWidget{
  @override
  _Result createState() => _Result();
}

class _Result extends State<Result> {
  String email;
  String token;
  _Result(){
    this.email = getStringValuesSF("email").toString();
    this.token = getStringValuesSF("token").toString();
  }

  Future<Null> getStringValuesSF(String keyword) async {
    Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _sprefs;
    String sf = prefs.getString(keyword);
    this.setState(() {
      keyword=='email'? email = sf: token = sf;
    });
  }
  @override
  Widget build(BuildContext context) {
    //addStringToSF("email",model.email.toString());
    return (Scaffold(
      appBar: AppBar(title: Text('Berhasil')),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Email:" + email + "\nToken:" + token, style: TextStyle(fontSize: 22))
          ],
        ),
      ),
    ));
  }

  
}