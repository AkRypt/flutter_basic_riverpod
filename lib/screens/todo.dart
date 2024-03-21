import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/todo_model.dart';
import 'package:flutter_application_2/providers/todos_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo extends ConsumerWidget {
  Todo({super.key});

  final TextEditingController inputController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: inputController,
              decoration: InputDecoration(
                hintText: 'Todo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onFieldSubmitted: (value) => {
                ref.read(todosProvider.notifier).addTodo(TodoModel(
                    id: Random().nextInt(9999),
                    description: value,
                    completed: false)),
                showSnackBar(context),
                inputController.clear(),
              },
            ),
            const SizedBox(height: 20),
            Consumer(builder: (context, WidgetRef ref, child) {
              final todos = ref.watch(todosProvider);
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(todos[index].description),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      Checkbox(
                        value: todos[index].completed,
                        onChanged: (value) => ref
                            .read(todosProvider.notifier)
                            .toggleTodo(todos[index].id, value!),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () => {
                          ref
                              .read(todosProvider.notifier)
                              .deleteTodo(todos[index].id)
                        },
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

showSnackBar(BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

const snackBar = SnackBar(content: Text('Todo'));
