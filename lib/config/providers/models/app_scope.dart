
import 'package:flutter/material.dart';

import '../../../domain/domain.dart';

class AppScope extends ChangeNotifier {
  final UserUseCases userUseCases;

  AppScope({required this.userUseCases});

  List<User> _users = [];
  List<User> get users => _users;

  void _setUsers(List<User> list) {
    _users = list;
    notifyListeners();
  }

  Future<Result<void>> _refreshUsers() async {
    final (error, data) = await userUseCases.listUsers();
    if (error != null) return (error, null);

    _setUsers(data);

    return (null, null);
  }

  Future<Result<void>> createUser(User user) async {
    final (error, _) = await userUseCases.createUser(user);

    if (error != null) return (error, null);
    await _refreshUsers();

    return (null, null);
  }

  Future<Result<void>> updateUser(User user) async {
    final (error, _) = await userUseCases.updateUser(user);

    if (error != null) return (error, null);
    await _refreshUsers();

    return (null, null);
  }

  Future<Result<void>> addAddress(String userId, Address address) async {
    final (error, _) = await userUseCases.addAddress(userId, address);

    if (error != null) return (error, null);
    await _refreshUsers();

    return (null, null);
  }

  Future<Result<void>> deleteAddress(String userId, String addressId) async {
    final (error, _) = await userUseCases.deleteAddress(userId, addressId);
    if (error != null) return (error, null);
    await _refreshUsers();
    return (null, null);
  }

  Future<Result<void>> deleteUser(String id) async {
    final (error, _) = await userUseCases.deleteUser(id);

    if (error != null) return (error, null);
    await _refreshUsers();

    return (null, null);
  }

  Future<Result<User>> getUserById(String id) async {
    final userCached = _users.firstWhere(
      (e) => e.id == id,
      orElse: () => User.empty(),
    );
    if (userCached.id.isNotEmpty) return (null, userCached);

    final (error, data) = await userUseCases.getUserById(id);
    if (error != null) return (error, data);

    return (null, data);
  }
}