
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:user_address/domain/domain.dart';

import '../../infrastructure/datasources/user_local_ds.dart';
import '../../infrastructure/driven_adapters/hive_user_adapter.dart';
import '../constants/constants.dart';
import 'models/app_scope.dart';

final appScopeProvider = ChangeNotifierProvider<AppScope>((ref) {
  final usersBox = Hive.box<Map>(Constants.usersBoxName);
  final ds = UserLocalDS(usersBox);

  final UserGateway gateway = HiveUserAdapter(ds);
  final useCases = UserUseCases(gateway);

  return AppScope(userUseCases: useCases);
});