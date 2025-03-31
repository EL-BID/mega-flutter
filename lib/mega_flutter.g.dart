// GENERATED CODE - DO NOT MODIFY BY HAND

part of mega_flutter;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MegaResponse _$MegaResponseFromJson(Map<String, dynamic> json) {
  return MegaResponse(
    data: json['data'],
  );
}

Map<String, dynamic> _$MegaResponseToJson(MegaResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

MegaResponseException _$MegaResponseExceptionFromJson(
    Map<String, dynamic> json) {
  return MegaResponseException(
    message: json['message'] as String?,
    stackTrace: json['messageEx'] as String?,
    errors: (json['errors'] as Map<String, dynamic>?)?.map(
      (k, e) =>
          MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
    ),
  );
}

Map<String, dynamic> _$MegaResponseExceptionToJson(
        MegaResponseException instance) =>
    <String, dynamic>{
      'message': instance.message,
      'messageEx': instance.stackTrace,
      'errors': instance.errors,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
    };
