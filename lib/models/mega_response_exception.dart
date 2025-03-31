part of mega_flutter;

@JsonSerializable()
class MegaResponseException implements Exception {
  String? message;
  Map<String, List<String>>? errors;

  @JsonKey(name: 'messageEx')
  String? stackTrace;

  @JsonKey(ignore: true)
  late final int statusCode;

  MegaResponseException({
    this.message,
    this.stackTrace,
    this.errors,
  });

  factory MegaResponseException.fromJson(Map<String, dynamic> json) {
    return _$MegaResponseExceptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MegaResponseExceptionToJson(this);
}
