part of mega_flutter;

typedef _Request = Future<Response<MegaResponse>> Function();

abstract class RemoteProvider {
  Future<MegaResponse> post(
    String endpoint, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async =>
      _handleRequest(() async {
        return MegaFlutter.instance.httpClient.post(
          endpoint,
          options: Options(headers: headers),
          queryParameters: queryParameters,
          data: body,
        );
      });

  Future<MegaResponse> get(
    String endpoint, {
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> queryParameters = const {},
  }) async =>
      _handleRequest(() async {
        return MegaFlutter.instance.httpClient.get(
          endpoint,
          options: Options(headers: headers),
          queryParameters: queryParameters,
        );
      });

  Future<http.Response> getHttps(
    String baseUrl,
    String endpoint,
    Map<String, String> headers, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    baseUrl = baseUrl.replaceFirst("https://", "");
    final uri = Uri.https(baseUrl.split("/")[0],
        baseUrl.split("/")[1] + "/" + baseUrl.split("/")[2] + endpoint, body);
    return await http.Client().get(uri, headers: headers);
  }

  Future<http.Response> postHttps(
    String baseUrl,
    String endpoint,
    Map<String, String> headers, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> body = const {},
  }) async {
    baseUrl = baseUrl.replaceFirst("https://", "");
    final uri = Uri.https(baseUrl.split("/")[0],
        baseUrl.split("/")[1] + '/' + baseUrl.split("/")[2] + endpoint);
    return await http.Client().post(uri, headers: headers, body: body);
  }

  Future<MegaResponse> _handleRequest(_Request request) async {
    try {
      final response = await request();
      return response.data!;
    } on DioError catch (e) {
      print(e.error.toString());
      if (e.error is MegaResponseException) {
        throw e.error;
      } else {
        rethrow;
      }
    }
  }
}
