import 'package:mega_flutter/mega_flutter.dart';

import '../models/email_credentials.dart';
import '../models/premium_user.dart';

class MockedAuthProvider extends AuthRemoteProvider {
  @override
  Future<AuthToken> authenticate(Credentials credentials) async {
    credentials as EmailCredentials;
    final response = await post('/auth', body: {
      'email': credentials.email,
      'password': credentials.password,
    });
    return AuthToken.fromResponse(response);
  }

  @override
  Future<User> findUser(AuthToken token) async {
    final response = await get('/user');
    return PremiumUser.fromJson(response.data);
  }

  @override
  Future<AuthToken> reauthenticate(AuthToken token) async {
    final response = await post('/refresh', body: {
      'refreshToken': token.refreshToken.toString(),
    });
    return AuthToken.fromResponse(response);
  }
}
