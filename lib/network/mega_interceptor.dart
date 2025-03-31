part of mega_flutter;

class MegaInterceptor extends InterceptorsWrapper {
  final AuthRepository _authRepository;

  MegaInterceptor(this._authRepository);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _addTokenIfPossible(options);
    await _addDeviceIdIfPossible(options);
    super.onRequest(options, handler);
  }

  Future<void> _addTokenIfPossible(RequestOptions options) async {
    final user = _authRepository.currentUser;
    if (user != null) {
      await _refreshTokenIfNecessary(user);
      options.headers.putIfAbsent(
        'Authorization',
        () => 'Bearer ${user.token.accessToken.toString()}',
      );
    }
  }

  Future<void> _addDeviceIdIfPossible(RequestOptions options) async {
    final storage = GetStorage();
    String deviceId = storage.read('deviceId') ?? '';
    if (deviceId.isNotEmpty) {
      options.headers.putIfAbsent(
        'deviceId',
            () => '$deviceId',
      );
    }
  }

  Future<void> _refreshTokenIfNecessary(User user) async {
    if (user.token.accessToken.isExpired) {
      await _authRepository.reauthenticate();
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    response.data = MegaResponse.fromJson(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      err.type = DioErrorType.other;
      err.error = MegaResponseException.fromJson(err.response!.data)
        ..statusCode = err.response!.statusCode!;
    }
    super.onError(err, handler);
  }
}
