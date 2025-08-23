import 'package:go_router/go_router.dart';

import '../../domain/domain.dart';
import '../../ui/ui.dart';

GoRouter buildRouter() => GoRouter(
  initialLocation: UserList.route,
  routes: [
    GoRoute(path: UserForm.route, builder: (_, GoRouterState state) {
      final user = state.extra as User?;

      return UserForm(user);
    }),
    GoRoute(path: UserList.route, builder: (_, __) => const UserList()),
  ],
);