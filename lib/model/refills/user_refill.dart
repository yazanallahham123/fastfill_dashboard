import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_refill.g.dart';

@JsonSerializable()
class UserRefill extends Equatable{
  final int? id;
  final String? transactionId;
  final int? userId;
  final double? amount;
  final bool? status;
  final String? mobileNumber;
  final DateTime? date;
  final String? source;

  UserRefill({this.id, this.transactionId, this.userId, this.amount, this.status, this.mobileNumber, this.date,
    this.source});

  factory UserRefill.fromJson(Map<String, dynamic> json) =>
      _$UserRefillFromJson(json);

  Map<String, dynamic> toJson() => _$UserRefillToJson(this);

  @override
  List<Object?> get props =>
      [this.id, this.transactionId, this.userId, this.amount, this.status, this.mobileNumber, this.date,
        this.source];
}
