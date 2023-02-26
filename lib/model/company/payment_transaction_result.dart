import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user/user.dart';
import 'company.dart';

part 'payment_transaction_result.g.dart';

@JsonSerializable()
class PaymentTransactionResult extends Equatable {
  final int? id;
  final Company? company;
  final int? userId;
  final String? date;
  final int? companyId;
  final int? fuelTypeId;
  final double? amount;
  final double? fastfill;
  final bool? status;
  final User? user;

  const PaymentTransactionResult(
      {this.id,
        this.company,
        this.userId,
        this.date,
        this.companyId,
        this.fuelTypeId,
        this.amount,
        this.fastfill,
        this.status,
        this.user

      });

  factory PaymentTransactionResult.fromJson(Map<String, dynamic> json) => _$PaymentTransactionResultFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTransactionResultToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.company,
    this.userId,
    this.date,
    this.companyId,
    this.fuelTypeId,
    this.amount,
    this.fastfill,
    this.status,
    this.user
  ];
}