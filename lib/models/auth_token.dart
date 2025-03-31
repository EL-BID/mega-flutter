part of mega_flutter;

/// Estrutura responsável por armazenar os tokens de acesso e refresh do
/// usuário autenticado.
class AuthToken {
  final Jwt accessToken;
  final Jwt refreshToken;
  final int expiresIn;
  final String expires;

  factory AuthToken.fromResponse(MegaResponse response) {
    return AuthToken._(
      accessToken: Jwt(response.data['access_token']),
      refreshToken: Jwt(response.data['refresh_token']),
      expiresIn: response.data['expires_in'],
      expires: response.data['expires'],
    );
  }

  AuthToken._(
      {required this.accessToken,
      required this.refreshToken,
      required this.expiresIn,
      required this.expires});
}
