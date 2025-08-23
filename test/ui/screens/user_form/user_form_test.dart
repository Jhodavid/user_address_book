import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_address/config/locale/app_localizations.dart';
import 'package:user_address/config/providers/models/app_scope.dart';
import 'package:user_address/config/providers/providers.dart';
import 'package:user_address/domain/domain.dart';
import 'package:user_address/ui/screens/user_form/user_form.dart';
import 'package:user_address/ui/screens/user_form/widgets/address_data_card.dart';
import 'package:user_address/ui/screens/user_form/widgets/address_form/address_form.dart';
import 'package:user_address/ui/screens/user_form/widgets/birthdate_picker.dart';

import '../../../mocks/user_data_mock.dart';

void main() {
  late MockUserGateway mockGateway;
  late User testUser;

  setUp(() {
    mockGateway = MockUserGateway();
    testUser = UserDataMock.userDataList.first;
  },);

  setUpAll(() {
    registerFallbackValue(UserFake());
  });

  Widget createTestWidget({
    List<Locale> supportedLocales = AppLocalizations.supportedLocales,
    User? user,
  }) {
    return ProviderScope(
      overrides: [
        appScopeProvider.overrideWith(
          (ref) => AppScope(
            userUseCases: UserUseCases(mockGateway)
          ),
        )
      ],
      child: MaterialApp(
        home: UserForm(user),
        supportedLocales: supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: ThemeData(useMaterial3: true)
      ),
    );
  }

  testWidgets(
    'test UserForm for create a new user',
    (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataEmptyList));

      await widgetTester.pumpWidget(createTestWidget());
      await widgetTester.pumpAndSettle();

      expect(find.byType(UserForm), findsOneWidget);
      expect(find.text('Create user'), findsWidgets);
      expect(find.text('Update user'), findsNothing);
    },
  );

  testWidgets(
    'test UserForm for update a exist user',
    (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataEmptyList));

      await widgetTester.pumpWidget(createTestWidget(user: testUser));
      await widgetTester.pumpAndSettle();

      expect(find.byType(UserForm), findsOneWidget);
      expect(find.text('Create user'), findsNothing);
      expect(find.text('Update user'), findsWidgets);
    },
  );

  testWidgets(
    'test UserForm create a new user flow',
    (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataEmptyList));
      when(() => mockGateway.createUser(any<User>())).thenAnswer(
        (_) async => (null, null));

      await widgetTester.pumpWidget(createTestWidget());
      await widgetTester.pumpAndSettle();

      expect(find.byType(UserForm), findsOneWidget);
      expect(find.text('Select a date'), findsOneWidget);

      final firstNameField = find.byKey(UserForm.firstNameFieldKey);
      expect(firstNameField, findsOneWidget);
      await widgetTester.enterText(firstNameField, 'First name test');
      expect(find.text('First name test'), findsWidgets);

      final lastNameField = find.byKey(UserForm.lastNameFieldKey);
      expect(lastNameField, findsOneWidget);
      await widgetTester.enterText(lastNameField, 'Last name test');
      expect(find.text('Last name test'), findsWidgets);

      final birthDateField = find.byKey(UserForm.birthDateFieldKey);
      expect(birthDateField, findsOneWidget);
      await widgetTester.tap(birthDateField);

      await widgetTester.pumpAndSettle();

      final datePicker = find.byKey(BirthdatePicker.doneButtonKey);
      expect(datePicker, findsOneWidget);
      await widgetTester.tap(datePicker);

      await widgetTester.pumpAndSettle();
      expect(find.text('Select a date'), findsNothing);

      final submitButton = find.byKey(UserForm.submitButtonKey);
      expect(submitButton, findsOneWidget);

      await widgetTester.ensureVisible(find.byKey(UserForm.submitButtonKey));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(submitButton);
    },
  );

  testWidgets(
    'test UserForm update a exist user flow',
        (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataEmptyList));
      when(() => mockGateway.updateUser(any<User>())).thenAnswer(
        (_) async => (null, null));

      await widgetTester.pumpWidget(createTestWidget(user: testUser));
      await widgetTester.pumpAndSettle();

      expect(find.text(testUser.firstName), findsWidgets);

      final firstNameField = find.byKey(UserForm.firstNameFieldKey);
      expect(firstNameField, findsOneWidget);
      await widgetTester.enterText(firstNameField, 'First name test');
      expect(find.text('First name test'), findsWidgets);

      await widgetTester.pumpAndSettle();

      final submitButton = find.byKey(UserForm.submitButtonKey);
      expect(submitButton, findsOneWidget);

      await widgetTester.ensureVisible(find.byKey(UserForm.submitButtonKey));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(submitButton);
    },
  );

  testWidgets(
    'test UserForm update a exist user flow with error on update',
        (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataEmptyList));
      when(() => mockGateway.updateUser(any<User>())).thenAnswer(
        (_) async => (UserDataMock.defaultError, null));

      await widgetTester.pumpWidget(createTestWidget(user: testUser));
      await widgetTester.pumpAndSettle();

      expect(find.text(testUser.firstName), findsWidgets);

      final firstNameField = find.byKey(UserForm.firstNameFieldKey);
      expect(firstNameField, findsOneWidget);
      await widgetTester.enterText(firstNameField, 'First name test');
      expect(find.text('First name test'), findsWidgets);

      await widgetTester.pumpAndSettle();

      final submitButton = find.byKey(UserForm.submitButtonKey);
      expect(submitButton, findsOneWidget);

      await widgetTester.ensureVisible(find.byKey(UserForm.submitButtonKey));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(submitButton);

      await widgetTester.pumpAndSettle(Duration(milliseconds: 1000));

      expect(find.byType(AlertDialog), findsOneWidget);
    },
  );

  testWidgets(
    'test UserForm create a new address flow',
    (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataEmptyList));

      await widgetTester.pumpWidget(createTestWidget());
      await widgetTester.pumpAndSettle();

      expect(find.byType(UserForm), findsOneWidget);
      expect(find.byType(AddressDataCard), findsNothing);

      final addAddressButton = find.byKey(UserForm.addAddressButtonKey);
      expect(addAddressButton, findsOneWidget);
      await widgetTester.tap(addAddressButton);

      await widgetTester.pumpAndSettle();

      final line1Field = find.byKey(AddressForm.lineFieldKey);
      expect(line1Field, findsOneWidget);
      await widgetTester.enterText(line1Field, 'Line 1 test');

      final cityField = find.byKey(AddressForm.cityFieldKey);
      expect(cityField, findsOneWidget);
      await widgetTester.enterText(cityField, 'City test');

      final regionField = find.byKey(AddressForm.regionFieldKey);
      expect(regionField, findsOneWidget);
      await widgetTester.enterText(regionField, 'Region test');

      final countryField = find.byKey(AddressForm.countryFieldKey);
      expect(countryField, findsOneWidget);
      await widgetTester.enterText(countryField, 'Country test');

      final zipField = find.byKey(AddressForm.zipFieldKey);
      expect(zipField, findsOneWidget);
      await widgetTester.enterText(zipField, '12345');

      final createButton = find.byKey(AddressForm.submitButtonKey);
      expect(createButton, findsOneWidget);
      await widgetTester.tap(createButton);

      await widgetTester.pumpAndSettle();

      expect(find.byType(AddressDataCard), findsWidgets);
    },
  );

  testWidgets(
    'remove a exist address',
    (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataEmptyList));

      await widgetTester.pumpWidget(createTestWidget(user: testUser));
      await widgetTester.pumpAndSettle(Duration(milliseconds: 1000));

      Finder addressCard = find.byType(AddressDataCard);
      int addressCardFount = widgetTester.widgetList(addressCard).length;
      expect(addressCardFount, 2);

      final removeButton = find.byKey(AddressDataCard.deleteAddressButtonKey);
      expect(removeButton, findsWidgets);

      await widgetTester.tap(removeButton.first);
      await widgetTester.pumpAndSettle();

      addressCard = find.byType(AddressDataCard);
      addressCardFount = widgetTester.widgetList(addressCard).length;
      expect(addressCardFount, 1);
    },
  );
}

class UserFake extends Fake implements User {}