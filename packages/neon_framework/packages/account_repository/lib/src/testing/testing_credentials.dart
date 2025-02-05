import 'package:account_repository/src/models/models.dart';
import 'package:meta/meta.dart';

/// Creates a mocked [Credentials] object.
@visibleForTesting
Credentials createCredentials({
  Uri? serverURL,
  String username = 'username',
  String? password = 'password',
}) {
  return Credentials((b) {
    b
      ..serverURL = serverURL ?? Uri.https('serverURL')
      ..username = username
      ..password = password;
  });
}
