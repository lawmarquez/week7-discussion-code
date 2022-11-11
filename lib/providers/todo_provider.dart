/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample todo app with networking
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:week7_networking_discussion/api/todo_api.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';
import 'package:week7_networking_discussion/api/firebase_todo_api.dart';

class TodoListProvider with ChangeNotifier {
  late FirebaseTodoAPI firebaseService;
  late Stream<QuerySnapshot> _todosStream;
  Todo? _selectedTodo;

  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  Stream<QuerySnapshot> get todos => _todosStream;

  fetchTodos() {
    _todosStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  Todo get selected => _selectedTodo!;

  changeSelectedTodo(Todo item) {
    _selectedTodo = item;
  }

  void addTodo(Todo item) async {
    String message = await firebaseService.addTodo(item.toJson(item));
    print(message);
    notifyListeners();
  }

  void editTodo(int index, String newTitle) {
    // _todoList[index].title = newTitle;
    notifyListeners();
  }

  void deleteTodo() async {
    String message = await firebaseService.deleteTodo(_selectedTodo!.id);
    print(message);
    notifyListeners();
  }

  void toggleStatus(int index, bool status) {
    // _todoList[index].completed = status;
    // notifyListeners();
  }
}
