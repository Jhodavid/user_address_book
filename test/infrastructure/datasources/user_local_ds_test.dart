import 'package:flutter_test/flutter_test.dart';

import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_address/infrastructure/datasources/user_local_ds.dart';

class MockBox extends Mock implements Box<Map> {}

void main() {
  late MockBox mockBox;
  late UserLocalDS ds;

  final userMap = {'id': '1', 'name': 'Test'};

  setUp(() {
    mockBox = MockBox();
    ds = UserLocalDS(mockBox);
  });

  group('getUser', () {
    test('returns user data when found', () async {
      when(() => mockBox.get('1')).thenReturn(userMap);

      final (error, data) = await ds.getUser('1');
      expect(error, null);
      expect(data, userMap);
    });

    test('returns NOT_FOUND when user not found', () async {
      when(() => mockBox.get('2')).thenReturn(null);

      final (error, data) = await ds.getUser('2');
      expect(error, 'NOT_FOUND');
      expect(data, null);
    });

    test('returns error on exception', () async {
      when(() => mockBox.get('3')).thenThrow(Exception('fail'));

      final (error, data) = await ds.getUser('3');
      expect(error, isA<Exception>());
      expect(data, null);
    });
  });

  group('getAll', () {
    test('returns all users', () async {
      final userList = [
        {'id': '1', 'name': 'A'},
        {'id': '2', 'name': 'B'}
      ];
      when(() => mockBox.values).thenReturn(userList);

      final (error, data) = await ds.getAll();
      expect(error, null);
      expect(data, userList);
    });

    test('returns error on exception', () async {
      when(() => mockBox.values).thenThrow(Exception('fail'));

      final (error, data) = await ds.getAll();
      expect(error, isA<Exception>());
      expect(data, null);
    });
  });

  group('putUser', () {
    test('puts user successfully', () async {
      when(() => mockBox.put('1', userMap)).thenAnswer((_) async {});

      final (error, _) = await ds.putUser('1', userMap);
      expect(error, null);
    });

    test('returns error on exception', () async {
      when(() => mockBox.put('2', userMap)).thenThrow(Exception('fail'));

      final (error, _) = await ds.putUser('2', userMap);
      expect(error, isA<Exception>());
    });
  });

  group('deleteUser', () {
    test('deletes user successfully', () async {
      when(() => mockBox.delete('1')).thenAnswer((_) async {});

      final (error, _) = await ds.deleteUser('1');
      expect(error, null);
    });

    test('returns error on exception', () async {
      when(() => mockBox.delete('2')).thenThrow(Exception('fail'));

      final (error, _) = await ds.deleteUser('2');
      expect(error, isA<Exception>());
    });
  });
}