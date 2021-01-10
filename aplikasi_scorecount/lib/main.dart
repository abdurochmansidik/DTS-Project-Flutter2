import 'package:flutter/material.dart';
import 'package:aplikasi_flutter1/screens/halaman1.dart';
import 'package:aplikasi_flutter1/screens/halaman2.dart';
import 'package:aplikasi_flutter1/models/team.dart';

void main() => runApp(GameScoreApp());

class _GameScoreAppState extends State<GameScoreApp> {
  List<Team> _teams = [
    Team(name: "Input your team name"),
    Team(name: "Input your team name")
  ];

  void _setTeamName(Team t, String name) {
    setState(() {
      t.name = name;
    });
  }

  void _changeTeamScore(Team t, int newScore) {
    setState(() {
      t.score = newScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: "/", routes: {
      "/": (context) => GameSetup(
            teams: _teams,
            setTeamName: _setTeamName,
          ),
      "/game": (context) =>
          Game(teams: _teams, changeTeamScore: _changeTeamScore)
    });
  }
}

class GameScoreApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameScoreAppState();
  }
}
