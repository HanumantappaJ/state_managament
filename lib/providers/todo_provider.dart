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
    state = state.map((model) {
      return model.id == state[index].id ? ModelState(favColor:  favColor, Desc: text, isInFavorite:state[index].isInFavorite, ) : model;
    }).toList();
  }

  void updateDesc1(ModelState modelState, String tesfxt, Color? favColor) {
    state = state.map((model) {
      return model.id == modelState.id ? ModelState(favColor:  favColor, Desc: text, isInFavorite:modelState.isInFavorite, ) : model;
    }).toList();
  }

}
