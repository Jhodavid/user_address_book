import 'package:flutter/material.dart';

import '../../../domain/domain.dart';

class AppScope extends ChangeNotifier {
  final UserUseCases _userUseCases;

  AppScope({required UserUseCases userUseCases}) : _userUseCases = userUseCases {
    _refreshUsers();
  }

  List<User> _users = [];
  List<User> get users => _users;

  void _setUsers(List<User> list) {
    _users = list;
    notifyListeners();
  }

  Future<Result<void>> _refreshUsers() async {
    final (error, data) = await _userUseCases.listUsers();
    if (error != null) return (error, null);

    _setUsers(data);

    return (null, null);
  }

  Future<Result<void>> createUser(User user) async {
    final (error, _) = await _userUseCases.createUser(user);

    if (error != null) return (error, null);
    await _refreshUsers();

    return (null, null);
  }

  Future<Result<void>> updateUser(User user) async {
    final (error, _) = await _userUseCases.updateUser(user);

    if (error != null) return (error, null);
    await _refreshUsers();

    return (null, null);
  }

  Future<Result<void>> deleteUser(String id) async {
    final (error, _) = await _userUseCases.deleteUser(id);

    if (error != null) return (error, null);
    await _refreshUsers();

    return (null, null);
  }
}