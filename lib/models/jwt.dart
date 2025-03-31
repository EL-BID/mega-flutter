part of mega_flutter;

/// Fornece uma forma simplificada de verificar se o token ainda é válido
/// através de [Jwt.isExpired].
/// Pode ser convertida novamente para JWT utilizando [Jwt.toString]
class Jwt {
  final String _value;

  Jwt(this._value);

  bool get isExpired => JwtDecoder.isExpired(_value);

  @override
  String toString() => _value;
}
