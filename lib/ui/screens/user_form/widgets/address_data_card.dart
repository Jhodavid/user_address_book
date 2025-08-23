
import 'package:flutter/material.dart';
import 'package:user_address/domain/domain.dart';

import '../../../../config/locale/app_localizations.dart';

class AddressDataCard extends StatelessWidget {
  static final deleteAddressButtonKey = Key('address-data-card-delete_address_button');

  final Address address;
  final VoidCallback onDelete;

  const AddressDataCard(this.address, {super.key, required this.onDelete});

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
                child: Icon(Icons.home_rounded, color: Color(0xff5f72ea)),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: locale.address_card_title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: '${address.line}, ${address.zip.isNotEmpty ? ' (${address.zip})' : ''}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                        text: locale.address_card_location_title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: '${address.city}, ${address.country}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 50,
              child: IconButton(
                key: deleteAddressButtonKey,
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
