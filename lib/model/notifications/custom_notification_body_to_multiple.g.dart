// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_notification_body_to_multiple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomNotificationBodyToMultiple _$CustomNotificationBodyToMultipleFromJson(
        Map<String, dynamic> json) =>
    CustomNotificationBodyToMultiple(
      mobileNumbers: (json['mobileNumbers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      title: json['title'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$CustomNotificationBodyToMultipleToJson(
        CustomNotificationBodyToMultiple instance) =>
    <String, dynamic>{
      'mobileNumbers': instance.mobileNumbers,
      'title': instance.title,
      'content': instance.content,
    };
