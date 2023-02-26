// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_transactions_result_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTransactionResultWithPagination
    _$PaymentTransactionResultWithPaginationFromJson(
            Map<String, dynamic> json) =>
        PaymentTransactionResultWithPagination(
          paymentTransactionResults: (json['paymentTransactionResults']
                  as List<dynamic>?)
              ?.map((e) =>
                  PaymentTransactionResult.fromJson(e as Map<String, dynamic>))
              .toList(),
          paginationInfo: json['paginationInfo'] == null
              ? null
              : PaginationInfo.fromJson(
                  json['paginationInfo'] as Map<String, dynamic>),
          totalAmount: (json['totalAmount'] as num?)?.toDouble(),
          totalFastfill: (json['totalFastfill'] as num?)?.toDouble(),
          totalCount: json['totalCount'] as int?,
        );

Map<String, dynamic> _$PaymentTransactionResultWithPaginationToJson(
        PaymentTransactionResultWithPagination instance) =>
    <String, dynamic>{
      'paymentTransactionResults': instance.paymentTransactionResults,
      'paginationInfo': instance.paginationInfo,
      'totalAmount': instance.totalAmount,
      'totalFastfill': instance.totalFastfill,
      'totalCount': instance.totalCount,
    };
