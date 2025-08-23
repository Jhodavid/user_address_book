import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_address/config/providers/providers.dart';
import 'package:user_address/ui/common/constants/ui_constants.dart';
import 'package:user_address/ui/screens/user_form/user_form.dart';

import '../../../config/locale/app_localizations.dart';
import 'widgets/user_data_card.dart';

class UserList extends ConsumerWidget {
  static final route = '/list';

  const UserList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AppLocalizations.of(context);
    final userList = ref.watch(appScopeProvider).users;

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
                  TextButton( /// todo: widget
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        UiConstants.onPrimaryColor)
                    ),
                    onPressed: () => context.push(UserForm.route),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_add,
                          color: UiConstants.primaryColor,
                        ),
                        SizedBox(width: 6),
                        Text(
                          locale.list_create_button,
                          style: TextStyle(
                            color: UiConstants.primaryColor
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),

              Divider(color: Colors.grey, height: 20, thickness: 2,),

              if(userList.isEmpty) Center(
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
                    return UserDataCard(
                      userList[index],
                      onDelete: () {
                        /// todo
                      },
                      onViewDetails: () {
                        /// todo
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