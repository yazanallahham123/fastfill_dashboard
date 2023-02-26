import 'package:equatable/equatable.dart';
import 'package:fastfilldashboard/model/common/pagination_info.dart';
import 'package:fastfilldashboard/model/refills/refill_source_amount.dart';
import 'package:fastfilldashboard/model/refills/user_refill.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_refills_with_pagination.g.dart';

@JsonSerializable()
class UserRefillsWithPagination extends Equatable {
  List<UserRefill>? refills;
  PaginationInfo? paginationInfo;
  double? totalAmount;
  int? totalCount;
  double? totalSuccessAmount;
  int? totalSuccessCount;
  double? totalFailAmount;
  int? totalFailCount;

  List<RefillSourceAmount>? refillSourcesAmounts;

  UserRefillsWithPagination(
      {this.refills,
        this.paginationInfo,
        this.totalAmount,
        this.totalCount,
        this.totalSuccessAmount,
        this.totalSuccessCount,
        this.totalFailAmount,
        this.totalFailCount,
        this.refillSourcesAmounts});

  factory UserRefillsWithPagination.fromJson(Map<String, dynamic> json) => _$UserRefillsWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$UserRefillsWithPaginationToJson(this);

  @override
  List<Object?> get props => [
    this.refills,
    this.paginationInfo,
    this.totalAmount,
    this.totalCount,
    this.totalSuccessAmount,
    this.totalSuccessCount,
    this.totalFailAmount,
    this.totalFailCount,
    this.refillSourcesAmounts
  ];
}