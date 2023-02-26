import 'package:equatable/equatable.dart';
import 'package:fastfilldashboard/model/company/payment_transaction_result.dart';
import 'package:fastfilldashboard/model/dashboard/week_total_payment_transactions.dart';
import 'package:json_annotation/json_annotation.dart';

import 'company_sales.dart';

part 'dashboard_data.g.dart';

@JsonSerializable()
class DashboardData extends Equatable {
  int? totalUsers;
  int? totalCompanies;
  int? totalTransactionsCount;
  double? totalTransactionsAmount;
  double? totalFastFill;
  List<PaymentTransactionResult>? latestPaymentTransactions;
  WeekTotalPaymentTransactions? weekTotalPaymentTransactions;
  List<CompanySales>? topCompanies;

  DashboardData(
      {this.totalUsers,
        this.totalCompanies,
        this.totalTransactionsCount,
        this.totalTransactionsAmount,
        this.totalFastFill,
        this.latestPaymentTransactions,
        this.weekTotalPaymentTransactions,
        this.topCompanies});

  factory DashboardData.fromJson(Map<String, dynamic> json) => _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);

  @override
  List<Object?> get props => [
    this.totalUsers,
    this.totalCompanies,
    this.totalTransactionsCount,
    this.totalTransactionsAmount,
    this.totalFastFill,
    this.latestPaymentTransactions,
    this.weekTotalPaymentTransactions,
    this.topCompanies
  ];
}