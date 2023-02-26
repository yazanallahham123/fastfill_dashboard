// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_refill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRefill _$UserRefillFromJson(Map<String, dynamic> json) => UserRefill(
      id: json['id'] as int?,
      transactionId: json['transactionId'] as String?,
      userId: json['userId'] as int?,
      amount: (json['amount'] as num?)?.toDouble(),
      status: json['status'] as bool?,
      mobileNumber: json['mobileNumber'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      source: json['source'] as String?,
    );

Map<String, dynamic> _$UserRefillToJson(UserRefill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'userId': instance.userId,
      'amount': instance.amount,
      'status': instance.status,
      'mobileNumber': instance.mobileNumber,
      'date': instance.date?.toIso8601String(),
      'source': instance.source,
    };
