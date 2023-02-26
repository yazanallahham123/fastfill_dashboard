import 'package:equatable/equatable.dart';
import 'package:fastfilldashboard/model/refills/refill_source.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refill_source_amount.g.dart';

@JsonSerializable()
class RefillSourceAmount extends Equatable{
  final RefillSource? refillSource;
  final double? successAmount;
  final int? successCount;
  final double? failAmount;
  final int? failCount;

  RefillSourceAmount({this.refillSource, this.successAmount, this.successCount, this.failAmount, this.failCount});

  factory RefillSourceAmount.fromJson(Map<String, dynamic> json) =>
      _$RefillSourceAmountFromJson(json);

  Map<String, dynamic> toJson() => _$RefillSourceAmountToJson(this);

  @override
  List<Object?> get props =>
      [this.refillSource, this.successAmount, this.successCount, this.failAmount, this.failCount];
}
