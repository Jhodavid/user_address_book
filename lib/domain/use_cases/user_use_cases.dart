import '../entities/address.dart';
import '../entities/user.dart';
import '../gateway/user_gateway.dart';
import '../models/typedef.dart';

class UserUseCases {
  final UserGateway gateway;

  const UserUseCases(this.gateway);

  Future<Result<void>> createUser(User user) =>
      gateway.createUser(user);

  Future<Result<void>> updateUser(User user) =>
      gateway.updateUser(user);

  Future<Result<User>> getUserById(String id) =>
      gateway.getUserById(id);

  Future<Result<List<User>>> listUsers() =>
      gateway.getListUsers();

  Future<Result<void>> deleteUser(String id) =>
      gateway.deleteUser(id);

  Future<Result<void>> addAddress(String userId, Address address) =>
      gateway.addAddress(userId, address);

  Future<Result<void>> deleteAddress(String userId, String addressId) =>
      gateway.deleteAddress(userId, addressId);
}