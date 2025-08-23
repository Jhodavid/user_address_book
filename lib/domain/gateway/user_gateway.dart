import '../entities/user.dart';
import '../entities/address.dart';
import '../models/typedef.dart';


abstract class UserGateway {
  Future<Result<void>> createUser(User user);
  Future<Result<void>> updateUser(User user);
  Future<Result<User>> getUserById(String id);
  Future<Result<List<User>>> getListUsers();
  Future<Result<void>> deleteUser(String id);
  Future<Result<void>> addAddress(String userId, Address address);
  Future<Result<void>> deleteAddress(String userId, String addressId);
}