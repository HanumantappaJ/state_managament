import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_state_management/providers/todo_provider.dart';

class Dashboard extends ConsumerStatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var todoWatcher = ref.watch(todoProvider.notifier);
    var todoList = ref.watch(todoProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("State Management"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: textController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter some text";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              todoWatcher.onSaveTodo(textController.text);
                              formKey.currentState!.save();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Todo Added to List"),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          child: const Text("Submit")),
                    )
                  ],
                )),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var model = todoList[index];
                    return Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              // todoList[index].Desc ?? '',
                              model.Desc ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              final editTextController =
                                  TextEditingController(text: model.Desc);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.all(20),
                                      child: AlertDialog(
                                        content: TextField(
                                          controller: editTextController,
                                        ),
                                        actions: [
                                          Container(
                                            child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text("Cancel")),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  todoWatcher.updateDesc(index,
                                                      editTextController.text, model.favColor);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  "Save",
                                                )),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              todoWatcher
                                  .onRemoveTodo(todoList[index].id ?? '');
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
