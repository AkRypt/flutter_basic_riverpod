import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/counter_provider.dart';
import 'package:flutter_application_2/screens/todo.dart';
import 'package:flutter_application_2/screens/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Button click count:"),
            Consumer(builder: (context, WidgetRef ref, Widget? child) {
              final counter = ref.watch(counterProvider);
              return Text(
                counter.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            })
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'list',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Todo();
              }));
            },
            child: const Icon(Icons.list),
          ),
          FloatingActionButton(
            heroTag: 'user',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return User();
              }));
            },
            child: const Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
