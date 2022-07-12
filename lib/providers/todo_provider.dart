import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_state_management/models/modelState.dart';

 final todoProvider = StateNotifierProvider<TodoNotifier, List<ModelState>>((ref) =>TodoNotifier());

class TodoNotifier extends StateNotifier<List<ModelState>> {
  TodoNotifier(): super([]);

  void onSaveTodo(String text){
    state = [...state,
      ModelState(Desc: text, isInFavorite: false)];
    // print(state.length.toString());
    // notifyListeners();
  }

  void onRemoveTodo(String id){
    state = state.where((todo) => todo.id != id).toList();
    // print(state.length.toString());
    // notifyListeners();
  }

  void updateDesc(int index, String text, Color? favColor) {
    state = [
      for (final todo in state)
        if(todo.id == state[index].id)
          ModelState(
              isInFavorite: state[index].isInFavorite,
              Desc:text,
            favColor: favColor,
          )
      else
        todo
    ];
  }


}
