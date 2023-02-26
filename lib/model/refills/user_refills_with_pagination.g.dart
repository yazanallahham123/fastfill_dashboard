// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_refills_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRefillsWithPagination _$UserRefillsWithPaginationFromJson(
        Map<String, dynamic> json) =>
    UserRefillsWithPagination(
      refills: (json['refills'] as List<dynamic>?)
          ?.map((e) => UserRefill.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      totalCount: json['totalCount'] as int?,
      totalSuccessAmount: (json['totalSuccessAmount'] as num?)?.toDouble(),
      totalSuccessCount: json['totalSuccessCount'] as int?,
      totalFailAmount: (json['totalFailAmount'] as num?)?.toDouble(),
      totalFailCount: json['totalFailCount'] as int?,
      refillSourcesAmounts: (json['refillSourcesAmounts'] as List<dynamic>?)
          ?.map((e) => RefillSourceAmount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserRefillsWithPaginationToJson(
        UserRefillsWithPagination instance) =>
    <String, dynamic>{
      'refills': instance.refills,
      'paginationInfo': instance.paginationInfo,
      'totalAmount': instance.totalAmount,
      'totalCount': instance.totalCount,
      'totalSuccessAmount': instance.totalSuccessAmount,
      'totalSuccessCount': instance.totalSuccessCount,
      'totalFailAmount': instance.totalFailAmount,
      'totalFailCount': instance.totalFailCount,
      'refillSourcesAmounts': instance.refillSourcesAmounts,
    };
