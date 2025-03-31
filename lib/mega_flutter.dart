library mega_flutter;

import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:ua_client_hints/ua_client_hints.dart';

part 'mega_flutter.g.dart';
part 'models/auth_token.dart';
part 'models/credentials.dart';
part 'models/mega_response.dart';
part 'models/mega_response_exception.dart';
part 'models/user.dart';
part 'network/mega_interceptor.dart';
part 'package:mega_flutter/models/jwt.dart';
part 'providers/auth_provider.dart';
part 'providers/remote_provider.dart';
part 'repositories/auth_repository.dart';

/// Classe responsável por inicializar a biblioteca. Deve ser chamada
/// preferencialmente na função main.
class MegaFlutter {
  /// Singleton responsável por prover a instância já inicializada. Uma
  /// exceção será lançada se este atributo for lido antes que [initialize]
  /// tenha sido completada.
  static late final MegaFlutter instance;

  /// Prove acesso aos recursos de autenticação, oferecendo acesso ao usuário
  /// logado, e funções de login e logout.
  final AuthRepository auth;

  /// Cliente HTTP customizado, oferecendo uma abstração de autenticação e
  /// respostas formatadas como [MegaResponse] em caso de sucesso, e
  /// [MegaResponseException] em caso de erro.
  /// Após o usuário estar autenticado, não será necessário prover o header de
  /// autorização já que internamente [httpClient] estará gerenciando isso.
  final Dio httpClient;

  MegaFlutter._(this.auth, this.httpClient);

  /// Esta função deve ser inicializa preferencialmente na main da aplicação.
  /// Quando completada com sucesso, [instance] estará disponível para ser
  /// acessada de qualquer lugar.
  static Future<void> initialize({
    required String baseUrl,
    required AuthRemoteProvider authProvider,
    regionUtcSubstract,
  }) async {
    await GetStorage.init();
    instance = MegaFlutter._(
      AuthRepository(authProvider),
      Dio(BaseOptions(baseUrl: baseUrl)),
    );
    instance.httpClient.interceptors.addAll([
      MegaInterceptor(instance.auth),
      LogInterceptor(responseBody: true, requestBody: true)
    ]);
  }
}
