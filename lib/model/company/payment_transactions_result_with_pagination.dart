import 'package:equatable/equatable.dart';
import 'package:fastfilldashboard/model/common/pagination_info.dart';
import 'package:fastfilldashboard/model/company/payment_transaction_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_transactions_result_with_pagination.g.dart';

@JsonSerializable()
class PaymentTransactionResultWithPagination extends Equatable {
  List<PaymentTransactionResult>? paymentTransactionResults;
  PaginationInfo? paginationInfo;
  double? totalAmount;
  double? totalFastfill;
  int? totalCount;

  PaymentTransactionResultWithPagination(
      {this.paymentTransactionResults,
        this.paginationInfo,
        this.totalAmount,
        this.totalFastfill,
        this.totalCount});

  factory PaymentTransactionResultWithPagination.fromJson(Map<String, dynamic> json) => _$PaymentTransactionResultWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTransactionResultWithPaginationToJson(this);

  @override
  List<Object?> get props => [
    this.paymentTransactionResults,
    this.paginationInfo,
    this.totalAmount,
    this.totalFastfill,
    this.totalCount
  ];
}