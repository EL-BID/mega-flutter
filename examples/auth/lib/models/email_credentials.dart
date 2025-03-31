import 'package:mega_flutter/mega_flutter.dart';

class EmailCredentials extends Credentials {
  final String email;
  final String password;

  EmailCredentials({
    required this.email,
    required this.password,
  });
}
