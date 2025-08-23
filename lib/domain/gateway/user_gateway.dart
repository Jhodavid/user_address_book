import '../entities/user.dart';
import '../models/typedef.dart';


abstract class UserGateway {
  Future<Result<void>> createUser(User user);
  Future<Result<void>> updateUser(User user);
  Future<Result<List<User>>> getListUsers();
  Future<Result<void>> deleteUser(String id);
}