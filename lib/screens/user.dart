import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_2/providers/users_provider.dart';

class User extends ConsumerWidget {
  const User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(fetchUsersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: switch (users) {
          AsyncData(:final value) => ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: value.length,
              itemBuilder: (context, index) => ListTile(
                leading: value[index].avatar_url != null
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(value[index].avatar_url!),
                      )
                    : const Icon(Icons.person),
                title: Text(value[index].login),
              ),
            ),
          AsyncError(:final error) => Text(error.toString()),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}
