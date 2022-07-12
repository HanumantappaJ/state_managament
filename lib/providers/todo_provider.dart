import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_state_management/models/modelState.dart';

 final todoProvider = StateNotifierProvider<TodoNotifier, List<ModelState>>((ref) =>TodoNotifier());

class TodoNotifier extends StateNotifier<List<ModelState>> {
  TodoNotifier(): super([]);

  void onSaveTodo(String text){
    // state.Desc = text;
    state = [...state,
      ModelState(Desc: text)];
    // print(state.length.toString());
    // notifyListeners();
  }
  void onRemoveTodo(String id){
    state = state.where((todo) => todo.id != id).toList();
    // print(state.length.toString());
    // notifyListeners();
  }

}
