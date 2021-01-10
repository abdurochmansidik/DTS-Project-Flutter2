import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basic',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        RaisedButton(
          child: Text('Button 1'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SecondRoute(recievedData: "Button 1")));
          },
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
        ),
        RaisedButton(
          child: Text('Button 2'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SecondRoute(recievedData: "Button 2")));
          },
        )
      ])),
    );
  }
}

class SecondRoute extends StatelessWidget {
  SecondRoute({this.recievedData});
  final String recievedData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Second Route')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Text("$recievedData is pressed"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go Back!'),
              ),
            ],
          ),
        ));
  }
}
