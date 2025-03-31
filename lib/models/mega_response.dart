part of mega_flutter;

@JsonSerializable()
class MegaResponse {
  dynamic data;

  MegaResponse({
    required this.data,
  });

  factory MegaResponse.fromJson(Map<String, dynamic> json) {
    return _$MegaResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MegaResponseToJson(this);
}
