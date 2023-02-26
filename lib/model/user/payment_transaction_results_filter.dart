import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_transaction_results_filter.g.dart';

@JsonSerializable()
class PaymentTransactionResultsFilter extends Equatable{
  final String? mobileNumber;
  final DateTime? fromDate;
  final DateTime? toDate;
  final List<int>? companies;
  final int page;
  final int pageSize;

  PaymentTransactionResultsFilter({this.mobileNumber, this.fromDate, this.toDate, this.companies, required this.page, required this.pageSize});

  factory PaymentTransactionResultsFilter.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionResultsFilterFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTransactionResultsFilterToJson(this);

  @override
  List<Object?> get props =>
      [this.mobileNumber, this.fromDate, this.toDate, this.companies, this.pageSize, this.pageSize];
}
