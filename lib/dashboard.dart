import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_state_management/providers/todo_provider.dart';

class Dashboard extends ConsumerWidget {
  Dashboard({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  // final textController = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final todoWatcher= ref.watch(todoProvider);
    final textController = TextEditingController();
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
                            if(formKey.currentState!.validate()){
                              todoWatcher.onSaveTodo(textController.text);
                              formKey.currentState!.save();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Todo Added to List"),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.green,),
                              );
                            }
                          }, child: const Text("Submit")),
                    )
                  ],
                )),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: todoWatcher.todoList.length,
                  itemBuilder: (BuildContext context, int index){
                   return Card(
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Expanded(
                            child:
                            Text(
                              todoWatcher.todoList[index].toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          // IconButton(
                          //   onPressed: () {
                          //     // todoWatcher.setModelColor(todoWatcher.todoList[index], Colors.red);
                          //   },
                          //   icon: const Icon(Icons.favorite, color: Colors.blueAccent,),
                          // ),
                          IconButton(
                            onPressed: () {
                              todoWatcher.onRemoveTodo(index);
                            },
                            icon: const Icon(Icons.delete,color: Colors.red,),
                          ),
                        ],
                      ),
                    );
                  }
              )),
        ],
      ),
    );
  }
}

