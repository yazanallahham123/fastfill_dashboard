// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_notification_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomNotificationBody _$CustomNotificationBodyFromJson(
        Map<String, dynamic> json) =>
    CustomNotificationBody(
      mobileNumber: json['mobileNumber'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$CustomNotificationBodyToJson(
        CustomNotificationBody instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'title': instance.title,
      'content': instance.content,
    };
