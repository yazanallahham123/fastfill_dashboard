// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyBranch _$CompanyBranchFromJson(Map<String, dynamic> json) =>
    CompanyBranch(
      id: json['id'] as int?,
      arabicName: json['arabicName'] as String?,
      englishName: json['englishName'] as String?,
      arabicAddress: json['arabicAddress'] as String?,
      englishAddress: json['englishAddress'] as String?,
      code: json['code'] as String?,
      companyId: json['companyId'] as int?,
    );

Map<String, dynamic> _$CompanyBranchToJson(CompanyBranch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'arabicName': instance.arabicName,
      'englishName': instance.englishName,
      'arabicAddress': instance.arabicAddress,
      'englishAddress': instance.englishAddress,
      'code': instance.code,
      'companyId': instance.companyId,
    };
