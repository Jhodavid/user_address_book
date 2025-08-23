import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_address/domain/domain.dart';
import 'package:user_address/infrastructure/driven_adapters/hive_user_adapter.dart';

import '../../mocks/user_data_mock.dart';

void main() {
  late MockUserLocalDS mockLocalDS;
  late HiveUserAdapter gateway;

  setUp(() {
    mockLocalDS = MockUserLocalDS();
    gateway = HiveUserAdapter(mockLocalDS);
  },);

  group('createUser tests', () {
    test('successfully creates user', () async {
      when(() => mockLocalDS.putUser(any(), any())).thenAnswer((_) async => (null, null));

      final (error, _) = await gateway.createUser(UserDataMock.userDataList.first);

      expect(error, null);
    });

    test('returns error when putUser fails', () async {
      when(() => mockLocalDS.putUser(any(), any())).thenAnswer((_) async => ('ERROR', null));

      final (error, _) = await gateway.createUser(UserDataMock.userDataList.first);

      expect(error, isA<ErrorItem>());
      expect(error?.message, contains('ERROR'));
    });
  });

  group(
    'getAll users test',
    () {
      test(
        'test when success get users data',
        () async {
          when(() => mockLocalDS.getAll()).thenAnswer((_)
            async => (null, UserDataMock.userMapList));

          final (error, data) = await gateway.getListUsers();

          expect(error, null);
          expect(data, isA<List<User>>());
          expect(data.length, UserDataMock.userMapList.length);
        },
      );

      test(
        'test when Breeds data is empty',
        () async {
          when(() => mockLocalDS.getAll()).thenAnswer((_)
          async => (null, UserDataMock.userMapEmptyList));

          final (error, data) = await gateway.getListUsers();

          expect(error, null);
          expect(data, isA<List<User>>());
          expect(data.length, 0);
        },
      );

      test(
        'test when error get Breeds data',
        () async {
          when(() => mockLocalDS.getAll()).thenAnswer((_)
            async => (UserDataMock.defaultError, null));

          final (error, data) = await gateway.getListUsers();

          expect(error, isA<ErrorItem>());
          expect(data, isA<List<User>>());
          expect(data.length, 0);
        },
      );
    },
  );

  group('deleteUser tests', () {
    test('returns user data when found', () async {
      when(() => mockLocalDS.getUser(any())).thenAnswer((_)
        async => (null, UserDataMock.userMap));
      when(() => mockLocalDS.deleteUser(any())).thenAnswer((_)
        async => (null, null));

      final (error, _) = await gateway.deleteUser('someId');

      expect(error, null);
    });

    test('returns error data when found but fail delete', () async {
      when(() => mockLocalDS.getUser(any())).thenAnswer((_)
        async => (null, UserDataMock.userMap));
      when(() => mockLocalDS.deleteUser(any())).thenAnswer((_)
        async => ('ERROR', null));

      final (error, _) = await gateway.deleteUser('someId');

      expect(error, isNotNull);
    });

    test('returns no data when user not found', () async {
      when(() => mockLocalDS.getUser(any())).thenAnswer((_)
        async => (null, null));
      when(() => mockLocalDS.deleteUser(any())).thenAnswer((_)
        async => (null, null));

      final (error, _) = await gateway.deleteUser('someId');

      expect(error?.message, isNotNull);
    });

    test('returns ERROR when result error', () async {
      when(() => mockLocalDS.getUser(any())).thenAnswer((_)
        async => ('ERROR', null));
      when(() => mockLocalDS.deleteUser(any())).thenAnswer((_)
        async => (null, null));

      final (error, _) = await gateway.deleteUser('someId');

      expect(error?.message, 'ERROR');
    });
  });

  group('updateUser tests', () {
    test('successfully puts user', () async {
      when(() => mockLocalDS.getUser(any())).thenAnswer((_)
       async => (null, UserDataMock.userMap));
      when(() => mockLocalDS.putUser(any(), any())).thenAnswer((_)
        async => (null, null));

      final (error, _) = await gateway.updateUser(UserDataMock.userDataList.first);

      expect(error, null);
    });

    test('returns error when put fails', () async {
      when(() => mockLocalDS.getUser(any())).thenAnswer((_)
       async => (null, UserDataMock.userMap));
      when(() => mockLocalDS.putUser(any(), any())).thenAnswer((_)
        async => (Exception('error'), null));

      final (error, _) = await gateway.updateUser(UserDataMock.userDataList.first);

      expect(error, isA<ErrorItem>());
    });

    test('returns no data when user not found', () async {
      when(() => mockLocalDS.getUser(any())).thenAnswer((_)
        async => (null, null));
      when(() => mockLocalDS.putUser(any(), any())).thenAnswer((_)
        async => (null, null));

      final (error, _) = await gateway.updateUser(UserDataMock.userDataList.first);

      expect(error?.message, isNotNull);
    });

    test('returns ERROR when result error', () async {
      when(() => mockLocalDS.getUser(any())).thenAnswer((_)
        async => ('ERROR', null));
      when(() => mockLocalDS.putUser(any(), any())).thenAnswer((_)
        async => (null, null));

      final (error, _) = await gateway.updateUser(UserDataMock.userDataList.first);

      expect(error?.message, 'ERROR');
    });
  });
}