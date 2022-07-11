import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoNotifier extends ChangeNotifier {
  List todoList = [];
  void onSaveTodo(String todoDesc){
    todoList.add(todoDesc);
    notifyListeners();
  }
  void onRemoveTodo(int index){
    todoList.removeAt(index);
    notifyListeners();
  }
  // void setModelColor(list, MaterialColor red, ) {
  //   final id = list.id;
  //   todoList.id =
  //   state = state.map((model) {
  //     return model.id == id ? Model(id, color) : model;
  //   }).toList();
  // }

}
final todoProvider = ChangeNotifierProvider<TodoNotifier>((ref) {
  return TodoNotifier();
});