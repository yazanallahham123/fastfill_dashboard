// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: json['id'] as int?,
      arabicName: json['arabicName'] as String?,
      englishName: json['englishName'] as String?,
      arabicAddress: json['arabicAddress'] as String?,
      englishAddress: json['englishAddress'] as String?,
      code: json['code'] as String?,
      disabled: json['disabled'] as bool?,
      group: json['group'] == null
          ? null
          : Group.fromJson(json['group'] as Map<String, dynamic>),
      groupId: json['groupId'] as int?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'arabicName': instance.arabicName,
      'englishName': instance.englishName,
      'arabicAddress': instance.arabicAddress,
      'englishAddress': instance.englishAddress,
      'code': instance.code,
      'disabled': instance.disabled,
      'group': instance.group,
      'groupId': instance.groupId,
    };
