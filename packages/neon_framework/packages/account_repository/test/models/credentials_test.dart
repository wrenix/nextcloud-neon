import 'package:account_repository/src/models/models.dart';
import 'package:account_repository/testing.dart';
import 'package:built_value_test/matcher.dart';
import 'package:test/test.dart';

void main() {
  group('Credentials', () {
    group('constructor', () {
      test('works correctly', () {
        expect(
          createCredentials,
          returnsNormally,
        );
      });
    });

    test('supports value equality', () {
      expect(
        createCredentials(),
        equalsBuilt(createCredentials()),
      );

      expect(
        createCredentials().hashCode,
        equals(createCredentials().hashCode),
      );

      expect(
        createCredentials(),
        isNot(equalsBuilt(createCredentials(password: null))),
      );
    });

    group('rebuild', () {
      test('returns the same object if not attributes are changed', () {
        expect(
          createCredentials().rebuild((_) {}),
          equalsBuilt(createCredentials()),
        );
      });

      test('replaces every attribute', () {
        expect(
          createCredentials().rebuild((b) {
            b
              ..serverURL = Uri.https('new-serverURL')
              ..username = 'new-username'
              ..password = 'new-password';
          }),
          equalsBuilt(
            createCredentials(
              serverURL: Uri.https('new-serverURL'),
              username: 'new-username',
              password: 'new-password',
            ),
          ),
        );
      });
    });

    test('creates id', () {
      expect(
        createCredentials().id,
        equals('b0682d652840ef50a4115cc77109bedd8c577ccc'),
      );
    });

    test('creates humanReadableID', () {
      final credentials = createCredentials(
        serverURL: Uri.https('example.com'),
        username: 'JohnDoe',
      );

      expect(
        credentials.humanReadableID,
        'JohnDoe@example.com',
      );

      final credentialsWithDefaultPort = createCredentials(
        serverURL: Uri(scheme: 'http', host: 'example.com', port: 80),
        username: 'JohnDoe',
        password: 'super_secret',
      );

      expect(credentialsWithDefaultPort.humanReadableID, 'JohnDoe@example.com');

      final credentialsWithPort = createCredentials(
        serverURL: Uri(scheme: 'http', host: 'example.com', port: 8080),
        username: 'JohnDoe',
        password: 'super_secret',
      );

      expect(credentialsWithPort.humanReadableID, 'JohnDoe@example.com:8080');
    });

    group('serialization', () {
      test('fromJson works correctly', () {
        expect(
          Credentials.fromJson({
            'serverURL': 'https://serverurl',
            'username': 'username',
            'password': 'password',
          }),
          equalsBuilt(createCredentials()),
        );
      });

      test('toJson works correctly', () {
        expect(
          createCredentials().toJson(),
          equals({
            'serverURL': 'https://serverurl',
            'username': 'username',
            'password': 'password',
          }),
        );
      });
    });

    test('to string', () {
      expect(
        createCredentials().toString(),
        equals('''
Credentials {
  serverURL=https://serverurl,
  username=username,
  password=password,
}'''),
      );
    });
  });
}
