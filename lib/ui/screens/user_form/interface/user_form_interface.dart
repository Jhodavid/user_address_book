import '../../../../domain/domain.dart';

abstract class UserFormInterface {
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String userId);
}