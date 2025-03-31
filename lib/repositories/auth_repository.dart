part of mega_flutter;

abstract class AuthRepository {
  factory AuthRepository(AuthRemoteProvider provider) {
    return _AuthRepositoryImpl(provider, AuthLocalProvider());
  }

  User? get currentUser;

  Stream<User?> get userChanges;

  Future<void> signIn(Credentials credentials);

  Future<void> signOut();

  Future<void> reauthenticate();

  Future<void> findCurrentUser();
}

class _AuthRepositoryImpl implements AuthRepository {
  final _userController = StreamController<User?>();
  final AuthRemoteProvider _remoteProvider;
  final AuthLocalProvider _localProvider;
  User? _user;

  _AuthRepositoryImpl(this._remoteProvider, this._localProvider);

  @override
  Stream<User?> get userChanges => _userController.stream;

  @override
  User? get currentUser => _user;

  @override
  Future<void> reauthenticate() async {
    try {
      final oldToken = await _localProvider.findToken();
      final newToken = await _remoteProvider.reauthenticate(oldToken!);
      await _localProvider.saveToken(newToken);
      final user = await _remoteProvider.findUser(newToken);
      user.token = newToken;
      _notifyUserChanges(user);
    } catch (e) {
      await _localProvider.clearToken();
      _notifyUserChanges(null);
      rethrow;
    }
  }

  @override
  Future<void> signIn(Credentials credentials) async {
    await _localProvider.clearToken();
    final token = await _remoteProvider.authenticate(credentials);
    await _localProvider.saveToken(token);
    final user = await _remoteProvider.findUser(token);
    _notifyUserChanges(user);
  }

  @override
  Future<void> signOut() async {
    _notifyUserChanges(null);
    await _localProvider.clearToken();
    // await _userController.close();
  }

  @override
  Future<void> findCurrentUser() async {
    final currentToken = await _localProvider.findToken();
    if (currentToken != null) {
      try{
        await reauthenticate();
      }catch(e){
        await signOut();
      }
    }
  }

  void _notifyUserChanges(User? user) {
    _user = user;
    _userController.add(user);
  }
}
