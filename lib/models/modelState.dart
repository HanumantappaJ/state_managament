import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();

class ModelState {
  final String? id;
  final String? Desc;

  ModelState( {this.Desc, String? id}): id = id ?? uuid.v4();
}