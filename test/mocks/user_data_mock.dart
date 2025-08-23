import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

import 'package:user_address/domain/domain.dart';
import 'package:user_address/infrastructure/infraestructure.dart';

class UserDataMock {

  static final defaultError = ErrorItem('dfErr', 'Default error');

  static final List<User> userDataEmptyList = [];

  static final List<User> userDataList = [
    User(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      birthDate: DateTime(1990, 1, 1),
      addresses: [
        Address(
          id: '1',
          line: '123 Main St',
          city: 'Springfield',
          country: 'USA',
          region: 'IL',
          zip: '62701',
        ),
        Address(
          id: '2',
          line: '456 Elm St',
          city: 'Springfield',
          country: 'USA',
          region: 'IL',
          zip: '62702',
        ),
      ],
    ),
    User(
      id: '2',
      firstName: 'Jane',
      lastName: 'Smith',
      birthDate: DateTime(1985, 5, 15),
      addresses: [
        Address(
          id: '1',
          line: '789 Oak St',
          city: 'Metropolis',
          country: 'USA',
          region: 'NY',
          zip: '10001',
        ),
      ],
    ),
    User(
      id: '3',
      firstName: 'Alice',
      lastName: 'Johnson',
      birthDate: DateTime(1978, 12, 30),
      addresses: [],
    ),
  ];

  static final List<Map<String, dynamic>> userMapEmptyList = [];

  static final Map<String, dynamic> userMap = {
    'id': '1',
    'firstName': 'John',
    'lastName': 'Doe',
    'birthDate': DateTime(1990, 1, 1).toIso8601String(),
    'addresses': [
      {
        'id': '1',
        'line': '123 Main St',
        'city': 'Springfield',
        'country': 'USA',
        'region': 'IL',
        'zip': '62701',
      },
      {
        'id': '2',
        'line': '456 Elm St',
        'city': 'Springfield',
        'country': 'USA',
        'region': 'IL',
        'zip': '62702',
      },
    ],
  };

  static final List<Map<String, dynamic>> userMapList = [
    {
      'id': '1',
      'firstName': 'John',
      'lastName': 'Doe',
      'birthDate': DateTime(1990, 1, 1).toIso8601String(),
      'addresses': [
        {
          'id': '1',
          'line': '123 Main St',
          'city': 'Springfield',
          'country': 'USA',
          'region': 'IL',
          'zip': '62701',
        },
        {
          'id': '2',
          'line': '456 Elm St',
          'city': 'Springfield',
          'country': 'USA',
          'region': 'IL',
          'zip': '62702',
        },
      ],
    },
    {
      'id': '2',
      'firstName': 'Jane',
      'lastName': 'Smith',
      'birthDate': DateTime(1985, 5, 15).toIso8601String(),
      'addresses': [
        {
          'id': '1',
          'line': '789 Oak St',
          'city': 'Metropolis',
          'country': 'USA',
          'region': 'NY',
          'zip': '10001',
        },
      ],
    },
    {
      'id': '3',
      'firstName': 'Alice',
      'lastName': 'Johnson',
      'birthDate': DateTime(1978, 12, 30).toIso8601String(),
      'addresses': [],
    },
  ];
}

class MockUserGateway extends Mock implements UserGateway {}
class MockUserLocalDS extends Mock implements UserLocalDS {}