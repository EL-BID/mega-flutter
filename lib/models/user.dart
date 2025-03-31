part of mega_flutter;

/// Esta classe é apenas uma base e deve ser modificada com cautela.
/// Preferencialmente, deve-se criar novos subtipos ao invés de modificar-lá.
/// Isso permite maior flexibilidade para novos projetos sem modificar os
/// atuais.
@JsonSerializable()
class User {
  String name;

  @JsonKey(ignore: true)
  late AuthToken token;

  User({
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
