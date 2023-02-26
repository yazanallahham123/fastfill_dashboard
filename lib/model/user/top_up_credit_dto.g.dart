// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_up_credit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopUpCreditDto _$TopUpCreditDtoFromJson(Map<String, dynamic> json) =>
    TopUpCreditDto(
      lang: json['lang'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$TopUpCreditDtoToJson(TopUpCreditDto instance) =>
    <String, dynamic>{
      'lang': instance.lang,
      'mobileNumber': instance.mobileNumber,
      'amount': instance.amount,
      'transactionId': instance.transactionId,
    };
