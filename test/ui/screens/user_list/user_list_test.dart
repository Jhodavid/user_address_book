import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:user_address/config/locale/app_localizations.dart';
import 'package:user_address/config/providers/models/app_scope.dart';
import 'package:user_address/config/providers/providers.dart';
import 'package:user_address/domain/domain.dart';
import 'package:user_address/ui/screens/user_list/user_list.dart';
import 'package:user_address/ui/screens/user_list/widgets/user_data_card.dart';

import '../../../mocks/user_data_mock.dart';

void main() {
  late MockUserGateway mockGateway;

  setUp(() {
    mockGateway = MockUserGateway();
  },);

  Widget createTestWidget({
    List<Locale> supportedLocales = AppLocalizations.supportedLocales,
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
        home: UserList(),
        supportedLocales: supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: ThemeData(useMaterial3: true)
      ),
    );
  }

  testWidgets(
    'test UserList when getListUsers return a empty data',
    (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataEmptyList));

      await widgetTester.pumpWidget(createTestWidget());
      await widgetTester.pumpAndSettle();

      expect(find.byType(UserList), findsOneWidget);
      expect(find.byKey(UserList.emptyDataMessageKey), findsOneWidget);
    },
  );

  testWidgets(
    'test UserList when getListUsers return a empty data  - es locale',
      (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataEmptyList));

      await widgetTester.pumpWidget(
        createTestWidget(supportedLocales: <Locale>[
          Locale('es')
        ]),
      );
      await widgetTester.pumpAndSettle();

      expect(find.byType(UserList), findsOneWidget);
      expect(find.byKey(UserList.emptyDataMessageKey), findsOneWidget);
    },
  );

  testWidgets(
    'test UserList when getListUsers return a error',
    (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (UserDataMock.defaultError, UserDataMock.userDataEmptyList));

      await widgetTester.pumpWidget(createTestWidget());
      await widgetTester.pumpAndSettle();

      expect(find.byType(UserList), findsOneWidget);
      expect(find.byKey(UserList.errorDataMessageKey), findsOneWidget);
      expect(find.byKey(UserList.emptyDataMessageKey), findsNothing);
    },
  );

  testWidgets(
    'test UserList when getListUsers return a data',
    (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataList));

      await widgetTester.pumpWidget(createTestWidget());
      await widgetTester.pumpAndSettle();

      expect(find.byType(UserList), findsOneWidget);
      expect(find.byType(UserDataCard), findsWidgets);
    },
  );

  testWidgets(
    'delete a exist user',
    (widgetTester) async {
      when(() => mockGateway.getListUsers()).thenAnswer(
        (_) async => (null, UserDataMock.userDataList));
      when(() => mockGateway.deleteUser(any<String>())).thenAnswer(
        (_) async => (null, null));

      await widgetTester.pumpWidget(createTestWidget());
      await widgetTester.pumpAndSettle();

      final removeButton = find.byKey(UserDataCard.deleteButtonKey);
      expect(removeButton, findsWidgets);

      await widgetTester.tap(removeButton.first);
      await widgetTester.pumpAndSettle();
    },
  );
}