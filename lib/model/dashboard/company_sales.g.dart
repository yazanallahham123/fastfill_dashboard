// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_sales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanySales _$CompanySalesFromJson(Map<String, dynamic> json) => CompanySales(
      arabicName: json['arabicName'] as String?,
      englishName: json['englishName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$CompanySalesToJson(CompanySales instance) =>
    <String, dynamic>{
      'arabicName': instance.arabicName,
      'englishName': instance.englishName,
      'amount': instance.amount,
      'count': instance.count,
    };
