part of mega_flutter;

/// Fonte de dados responsável por autenticar e buscar as informações do
/// usuário.
abstract class AuthRemoteProvider extends RemoteProvider {
  Future<User> findUser(AuthToken token);

  /// Retorna um [AuthToken] ao informar um subclasse de [Credentials]. Cada
  /// projeto poderá ter diferentes tipos de credenciais, logo a
  /// [Credentials] deve ser estendida e adaptada de acordo com a necessidade
  /// de cada projeto.
  Future<AuthToken> authenticate(Credentials credentials);

  /// Retorna um novo [AuthToken] ao informar o [token] atual do usuário.
  /// Essa função poderá lançar uma [MegaResponseException] caso o novo token
  /// seja inválido.
  Future<AuthToken> reauthenticate(AuthToken token);
}

/// Provedor de autenticação local. Esta classe é responsável por gerenciar o
/// token salvo no device do usuário.
class AuthLocalProvider {
  final _accessTokenKey = 'access_token';
  final _refreshTokenKey = 'refresh_token';

  /// Tenta buscar um [AuthToken] caso já tenha sido salvo.
  /// Retornará [Null] se nenhuma informação for encontrada.
  Future<AuthToken?> findToken() async {
    final accessToken = GetStorage().read<String>(_accessTokenKey);
    final refreshToken = GetStorage().read<String>(_refreshTokenKey);
    if (accessToken != null && refreshToken != null) {
      return AuthToken._(
        accessToken: Jwt(accessToken),
        refreshToken: Jwt(refreshToken),
        expires: '',
        expiresIn: 0,
      );
    }
  }

  Future<void> clearToken() async {
    await GetStorage().remove(_accessTokenKey);
    await GetStorage().remove(_refreshTokenKey);
  }

  Future<void> saveToken(AuthToken token) async {
    await GetStorage().write(_accessTokenKey, token.accessToken.toString());
    await GetStorage().write(_refreshTokenKey, token.refreshToken.toString());
  }
}
