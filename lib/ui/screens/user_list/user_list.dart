import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_address/config/providers/providers.dart';
import 'package:user_address/ui/common/widgets/full_screen_loader.dart';
import 'package:user_address/ui/screens/user_form/user_form.dart';

import '../../../config/locale/app_localizations.dart';
import '../../common/widgets/add_text_button.dart';
import 'widgets/user_data_card.dart';

class UserList extends ConsumerWidget {
  static final errorDataMessageKey = Key('error-data-message-key');
  static final emptyDataMessageKey = Key('empty-data-message-key');

  static final route = '/list';

  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context);
    final userList = ref.watch(appScopeProvider).users;
    final error = ref.watch(appScopeProvider).usersGetError;
    final appScope = ref.read(appScopeProvider.notifier);

    void deleteUser(String id) async {
      FullScreenLoader.show(context);
      await appScope.deleteUser(id);
      FullScreenLoader.hide();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7f6f9),
        title: Text(
          locale.app_name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                locale.list_title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                locale.list_description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: Text(
                      locale.list_list_title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AddTextButton(
                    icon: Icons.person_add,
                    label: locale.list_create_button,
                    onPressed: () => context.push(UserForm.route)
                  ),
                ],
              ),

              Divider(color: Colors.grey, height: 20, thickness: 2,),

              if(error != null) Center(
                key: errorDataMessageKey,
                child: Text(
                  locale.list_error_fetching_users,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ),

              if(error == null && userList.isEmpty) Center(
                key: emptyDataMessageKey,
                child: Text(
                  locale.list_empty_list,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (_, index) {
                    final user = userList[index];

                    return UserDataCard(
                      user,
                      onDelete: () => deleteUser(user.id),
                      onViewDetails: () {
                        context.push(
                          UserForm.route,
                          extra: user
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}