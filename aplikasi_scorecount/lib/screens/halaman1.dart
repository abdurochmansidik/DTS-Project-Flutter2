import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aplikasi_flutter1/models/team.dart';

class _TeamTileState extends State<_TeamTile> {
  bool _editing = false;
  TextEditingController _textFieldController;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController.fromValue(
        TextEditingValue(text: widget.team.name));
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _toggleEditing();
        widget.setTeamName(_textFieldController.text);
      }
    });
  }

  void _focusOnNode() {
    Timer(const Duration(milliseconds: 100),
        () => FocusScope.of(context).requestFocus(_focusNode));
  }

  Widget _buildShowTile() {
    return GestureDetector(
        onTap: () {
          _toggleEditing();
          _focusOnNode();
        },
        child: Text(widget.team.name));
  }

  Widget _buildEditTile() {
    return TextField(controller: _textFieldController, focusNode: _focusNode);
  }

  void _toggleEditing() {
    setState(() {
      _editing = !_editing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(title: _editing ? _buildEditTile() : _buildShowTile()),
      Divider()
    ]);
  }
}

class _TeamTile extends StatefulWidget {
  _TeamTile({@required this.team, @required Function setTeamName})
      : this._setTeamName = setTeamName;

  final Function _setTeamName;
  final Team team;

  @override
  State<StatefulWidget> createState() {
    return _TeamTileState();
  }

  void setTeamName(String name) {
    _setTeamName(team, name);
  }
}

class GameSetup extends StatelessWidget {
  GameSetup({this.teams, this.setTeamName});

  final List<Team> teams;
  final Function setTeamName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("scorecount")),
        body: ListView.builder(
            itemCount: 3,
            itemBuilder: (builderContext, i) {
              if (i < 2) {
                return _TeamTile(team: teams[i], setTeamName: setTeamName);
              } else {
                return ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed("/game");
                    },
                    title: Center(
                        child: Text("Start",
                            style: TextStyle(color: Colors.green))));
              }
            }));
  }
}
