import 'package:flutter/material.dart';
import 'package:user_address/ui/common/helpers/ui_helpers.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../domain/domain.dart';

class UserDataCard extends StatelessWidget {
  static final deleteButtonKey = Key('user-data-card-delete_button');
  static final viewDetailsButtonKey = Key('user-data-card-view_details_button');

  final User user;
  final VoidCallback onDelete;
  final VoidCallback onViewDetails;

  const UserDataCard(
    this.user, {
    required this.onDelete,
    required this.onViewDetails,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: Color(0xffdce6fa),
                child: Icon(Icons.person, color: Color(0xff5f72ea)),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${user.firstName} ${user.lastName}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: RichText(
                      text: TextSpan(
                        text: locale.list_birthdate,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: UiHelpers.getBirthDateText(user.birthDate),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    key: UserDataCard.deleteButtonKey,
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: onDelete,
                  ),
                  IconButton(
                    key: UserDataCard.viewDetailsButtonKey,
                    icon: Icon(Icons.read_more_outlined, color: Color(0xff5f72ea)),
                    onPressed: onViewDetails,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
