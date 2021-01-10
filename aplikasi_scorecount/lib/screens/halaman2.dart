import "package:flutter/material.dart";
import 'package:aplikasi_flutter1/models/team.dart';

class Game extends StatelessWidget {
  Game({this.teams, Function changeTeamScore})
      : this._changeTeamScore = changeTeamScore;
  final List<Team> teams;
  final Function _changeTeamScore;

  void _incrementTeamScore(Team t) {
    _changeTeamScore(t, t.score + 1);
  }

  void _decrementTeamScore(Team t) {
    if (t.score > 0) _changeTeamScore(t, t.score - 1);
  }

  Widget _buildTeamScore(Team t) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(children: <Widget>[
          Text("${t.score}", style: TextStyle(fontSize: 100.0)),
          Text("${t.name}", style: TextStyle(fontSize: 20.0)),
          IconButton(
            icon: Icon(Icons.remove,
                size: 50, color: t.score == 0 ? Colors.grey : Colors.red),
            onPressed: () => _decrementTeamScore(t),
            padding: EdgeInsets.all(0),
          ),
          IconButton(
              icon: Icon(Icons.add, size: 50, color: Colors.green),
              onPressed: () => _incrementTeamScore(t),
              padding: EdgeInsets.all(0))
        ]),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _teamsWidgets =
        teams.map((Team t) => _buildTeamScore(t)).toList();
    Text _barTitle = Text("scorecount");

    return Scaffold(
        appBar: AppBar(title: _barTitle),
        body: FractionallySizedBox(
            child: Container(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _teamsWidgets))));
  }
}
