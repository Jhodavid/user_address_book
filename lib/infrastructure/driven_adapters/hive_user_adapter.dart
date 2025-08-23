import 'package:user_address/infrastructure/constants/infra_constants.dart';
import 'package:user_address/infrastructure/mappers/user_mapper.dart';

import '../../domain/domain.dart';
import '../datasources/user_local_ds.dart';

class HiveUserAdapter implements UserGateway {
  final UserLocalDS _userLocalDS;

  HiveUserAdapter(this._userLocalDS);

  ErrorItem _wrap(Object e) => ErrorItem(InfraConstants.hiveAdapterError, e.toString());
  ErrorItem _notFound([String? id]) => ErrorItem(InfraConstants.hiveAdapterNotFound, 'User not found${id != null ? " ($id)" : ""}');

  final userMapper = UserMapper();

  @override
  Future<Result<void>> createUser(User user) async {
    final userMap = userMapper.toMap(user);

    final (error, _) = await _userLocalDS.putUser(user.id, userMap);
    if (error != null) return (_wrap(error), null);

    return (null, null);
  }

  @override
  Future<Result<void>> updateUser(User user) async {
    final (error, raw) = await _userLocalDS.getUser(user.id);

    if (error != null) return (_wrap(error), null);
    if (raw == null) return (_notFound(user.id), null);

    final userMap = userMapper.toMap(user);

    final (updateError, _) = await _userLocalDS.putUser(user.id, userMap);
    if (updateError != null) return (_wrap(updateError), null);

    return (null, user);
  }

  @override
  Future<Result<List<User>>> getListUsers() async {
    final (e, listRaw) = await _userLocalDS.getAll();

    if (e != null) return (_wrap(e), <User>[]);

    final users = listRaw!.map(userMapper.fromMap).toList();

    return (null, users);
  }

  @override
  Future<Result<void>> deleteUser(String id) async {
    final (error, raw) = await _userLocalDS.getUser(id);

    if (error != null) return (_wrap(error), null);
    if (raw == null) return (_notFound(id), null);

    final (deleteError, _) = await _userLocalDS.deleteUser(id);
    if (deleteError != null) return (_wrap(deleteError), null);

    return (null, null);
  }
}