import 'package:flutter/material.dart';

class teamsModel{
  teamsModel({
    required this.idTeam,
    required this.strTeam	,
    required this.strTeamShort,
    required this.strDescriptionEN,
    required this.strBadge
  });

  int idTeam;
  String strTeam	;
  String strTeamShort;
  String strDescriptionEN;
  String strBadge;

  Map<String, dynamic> toMap(){
    return{
      'idTeam' : idTeam,
      'strTeam' : strTeam,
      'strTeamShort' : strTeamShort,
      'strDescriptionEN' : strDescriptionEN,
      'strBadge' : strBadge
    };
  }


  factory teamsModel.fromMap(Map<String, dynamic> map){
    return teamsModel(
      idTeam: map['idTeam'] is int ? map['idTeam'] : int.parse(map['idTeam']),
      strTeam	: map['strTeam'],
      strTeamShort	: map['strTeamShort'],
      strDescriptionEN: map['strDescriptionEN'],
      strBadge: map['strBadge']
    );
  }
}