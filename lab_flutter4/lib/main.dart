import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyStatefulWidget(),
    );
  }
}

// Define a custom Form widget.
class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = "Initial Text";
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String value = '';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextField Tutorial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Inputted Text:'),
            Text(_controller.text),
            TextField(
              controller: _controller,
              onSubmitted: (text) {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
