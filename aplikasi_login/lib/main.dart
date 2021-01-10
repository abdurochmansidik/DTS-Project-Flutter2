import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;
import 'model.dart';
import 'result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form Demo'),
        ),
        body: TestForm(),
      ),
    );
  }
}

class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  String email;
  final _formKey = GlobalKey<FormState>();
  Model model = Model();

  addStringToSF(String keyword, String data) async {
    Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _sprefs;
    prefs.setString(keyword, data);
  }

  Future<http.Response> login(String username, String password) async {
    debugPrint("Username: " + username);
    debugPrint("Password: " + password);
    final http.Response response = await http.post(
      '',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    addStringToSF("token", json['access_token']);
    debugPrint("Response: " + json['access_token']);
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MyTextFormField(
            hintText: 'Email',
            isEmail: true,
            validator: (String value) {
              if (!validator.isEmail(value)) {
                return 'Masukan Email yang benar';
              }
              return null;
            },
            onSaved: (String value) {
              model.email = value;
            },
          ),
          MyTextFormField(
            hintText: 'Password',
            isPassword: true,
            validator: (String value) {
              if (value.length < 6) {
                return 'Password Harus 7 Karakter';
              }
              _formKey.currentState.save();
              return null;
            },
            onSaved: (String value) {
              model.password = value;
            },
          ),
          RaisedButton(
            color: Colors.blueAccent,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                this.email = this.model.email;
                addStringToSF("email", email);
                login(this.model.email, this.model.password);
                debugPrint("klik");
                _formKey.currentState.save();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Result()));
              }
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          RaisedButton(
            color: Colors.greenAccent,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Result()));
            },
            child: Text(
              'Lihat Data',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.isPassword = false,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}
