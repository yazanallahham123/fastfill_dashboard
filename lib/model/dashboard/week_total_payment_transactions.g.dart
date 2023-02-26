// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_total_payment_transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekTotalPaymentTransactions _$WeekTotalPaymentTransactionsFromJson(
        Map<String, dynamic> json) =>
    WeekTotalPaymentTransactions(
      today: (json['today'] as num?)?.toDouble(),
      oneDayBefore: (json['oneDayBefore'] as num?)?.toDouble(),
      twoDaysBefore: (json['twoDaysBefore'] as num?)?.toDouble(),
      threeDaysBefore: (json['threeDaysBefore'] as num?)?.toDouble(),
      fourDaysBefore: (json['fourDaysBefore'] as num?)?.toDouble(),
      fiveDaysBefore: (json['fiveDaysBefore'] as num?)?.toDouble(),
      sixDaysBefore: (json['sixDaysBefore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeekTotalPaymentTransactionsToJson(
        WeekTotalPaymentTransactions instance) =>
    <String, dynamic>{
      'today': instance.today,
      'oneDayBefore': instance.oneDayBefore,
      'twoDaysBefore': instance.twoDaysBefore,
      'threeDaysBefore': instance.threeDaysBefore,
      'fourDaysBefore': instance.fourDaysBefore,
      'fiveDaysBefore': instance.fiveDaysBefore,
      'sixDaysBefore': instance.sixDaysBefore,
    };
