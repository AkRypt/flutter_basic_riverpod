import 'package:flutter_application_2/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'users_provider.g.dart';

final dio = Dio();

@riverpod
Future<List<UserModel>> fetchUsers(FetchUsersRef ref) async {
  var response = await dio.get('https://api.github.com/users');
  List<UserModel> users = [...response.data.map((e) => UserModel.fromJson(e))];
  return users;
}
