import 'dart:ffi';

import 'Team.dart';

class Participant {
  final Team? team;
  final int? points;
  final Bool? isEliminated;

  Participant(this.team,this.points, this.isEliminated);

  Map<String, dynamic> toMap() {
    return {
      'team': team,
      'points': points,
      'isEliminated': isEliminated
    };
  }
  factory Participant.fromJson(dynamic json) {
    return Participant(json['team'] as Team?, json['points'] as int?,json['isEliminated'] as Bool?);
  }

}