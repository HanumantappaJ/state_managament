import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();

class ModelState {
  final String? id;
  final String? Desc;
  final Color? favColor;
  bool isInFavorite = false;

  ModelState( {this.Desc, this.favColor, required this.isInFavorite ,  String? id}): id = id ?? uuid.v4();
}