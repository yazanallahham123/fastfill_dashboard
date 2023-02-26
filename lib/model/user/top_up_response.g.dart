// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopUpResponse _$TopUpResponseFromJson(Map<String, dynamic> json) =>
    TopUpResponse(
      responseCode: json['responseCode'] as String?,
      responseMessage: json['responseMessage'] as String?,
    );

Map<String, dynamic> _$TopUpResponseToJson(TopUpResponse instance) =>
    <String, dynamic>{
      'responseCode': instance.responseCode,
      'responseMessage': instance.responseMessage,
    };
