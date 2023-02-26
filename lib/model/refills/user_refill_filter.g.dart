// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_refill_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRefillFilter _$UserRefillFilterFromJson(Map<String, dynamic> json) =>
    UserRefillFilter(
      mobileNumber: json['mobileNumber'] as String?,
      fromDate: json['fromDate'] == null
          ? null
          : DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
      transactionId: json['transactionId'] as String?,
      status: json['status'] as bool?,
      refillSources: (json['refillSources'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
    );

Map<String, dynamic> _$UserRefillFilterToJson(UserRefillFilter instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'fromDate': instance.fromDate?.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
      'transactionId': instance.transactionId,
      'status': instance.status,
      'refillSources': instance.refillSources,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
