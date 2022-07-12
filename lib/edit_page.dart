import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_state_management/models/modelState.dart';
import 'package:new_state_management/providers/todo_provider.dart';

class EditPage extends ConsumerStatefulWidget {
  ModelState modelState;

  EditPage({
    Key? key,
    required this.modelState,
  }) : super(key: key);

  @override
  ConsumerState<EditPage> createState() => _EditPageState();
}

class _EditPageState extends ConsumerState<EditPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final editTextController =
        TextEditingController(text: widget.modelState.Desc);
    var todoWatcher = ref.watch(todoProvider.notifier);
    var todoList = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("State Management"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: editTextController,
            ),
          ),
          // Container(
          //   child: GestureDetector(
          //       onTap: () {},
          //       // => Navigator.of(context).pop(),
          //       child: const Text("Cancel")),
          // ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  todoWatcher.updateDesc1(widget.modelState,
                      editTextController.text, widget.modelState.favColor);
                  // Navigator.of(context).pop();
                },
                child: const Text(
                  "Update",
                )),
          ),
        ],
      ),
    );
  }
}
