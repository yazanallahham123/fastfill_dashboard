// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      totalUsers: json['totalUsers'] as int?,
      totalCompanies: json['totalCompanies'] as int?,
      totalTransactionsCount: json['totalTransactionsCount'] as int?,
      totalTransactionsAmount:
          (json['totalTransactionsAmount'] as num?)?.toDouble(),
      totalFastFill: (json['totalFastFill'] as num?)?.toDouble(),
      latestPaymentTransactions:
          (json['latestPaymentTransactions'] as List<dynamic>?)
              ?.map((e) =>
                  PaymentTransactionResult.fromJson(e as Map<String, dynamic>))
              .toList(),
      weekTotalPaymentTransactions: json['weekTotalPaymentTransactions'] == null
          ? null
          : WeekTotalPaymentTransactions.fromJson(
              json['weekTotalPaymentTransactions'] as Map<String, dynamic>),
      topCompanies: (json['topCompanies'] as List<dynamic>?)
          ?.map((e) => CompanySales.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'totalCompanies': instance.totalCompanies,
      'totalTransactionsCount': instance.totalTransactionsCount,
      'totalTransactionsAmount': instance.totalTransactionsAmount,
      'totalFastFill': instance.totalFastFill,
      'latestPaymentTransactions': instance.latestPaymentTransactions,
      'weekTotalPaymentTransactions': instance.weekTotalPaymentTransactions,
      'topCompanies': instance.topCompanies,
    };
