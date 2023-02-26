// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refill_source_amount.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefillSourceAmount _$RefillSourceAmountFromJson(Map<String, dynamic> json) =>
    RefillSourceAmount(
      refillSource: json['refillSource'] == null
          ? null
          : RefillSource.fromJson(json['refillSource'] as Map<String, dynamic>),
      successAmount: (json['successAmount'] as num?)?.toDouble(),
      successCount: json['successCount'] as int?,
      failAmount: (json['failAmount'] as num?)?.toDouble(),
      failCount: json['failCount'] as int?,
    );

Map<String, dynamic> _$RefillSourceAmountToJson(RefillSourceAmount instance) =>
    <String, dynamic>{
      'refillSource': instance.refillSource,
      'successAmount': instance.successAmount,
      'successCount': instance.successCount,
      'failAmount': instance.failAmount,
      'failCount': instance.failCount,
    };
