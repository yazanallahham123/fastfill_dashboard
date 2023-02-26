// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_transaction_results_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTransactionResultsFilter _$PaymentTransactionResultsFilterFromJson(
        Map<String, dynamic> json) =>
    PaymentTransactionResultsFilter(
      mobileNumber: json['mobileNumber'] as String?,
      fromDate: json['fromDate'] == null
          ? null
          : DateTime.parse(json['fromDate'] as String),
      toDate: json['toDate'] == null
          ? null
          : DateTime.parse(json['toDate'] as String),
      companies:
          (json['companies'] as List<dynamic>?)?.map((e) => e as int).toList(),
      page: json['page'] as int,
      pageSize: json['pageSize'] as int,
    );

Map<String, dynamic> _$PaymentTransactionResultsFilterToJson(
        PaymentTransactionResultsFilter instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'fromDate': instance.fromDate?.toIso8601String(),
      'toDate': instance.toDate?.toIso8601String(),
      'companies': instance.companies,
      'page': instance.page,
      'pageSize': instance.pageSize,
    };
