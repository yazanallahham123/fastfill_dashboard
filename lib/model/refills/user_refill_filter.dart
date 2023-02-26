import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_refill_filter.g.dart';

@JsonSerializable()
class UserRefillFilter extends Equatable{
  final String? mobileNumber;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? transactionId;
  final bool? status;
  final List<int>? refillSources;
  final int page;
  final int pageSize;

  UserRefillFilter({this.mobileNumber, this.fromDate, this.toDate, this.transactionId, this.status,
    this.refillSources, required this.page, required this.pageSize});

  factory UserRefillFilter.fromJson(Map<String, dynamic> json) =>
      _$UserRefillFilterFromJson(json);

  Map<String, dynamic> toJson() => _$UserRefillFilterToJson(this);

  @override
  List<Object?> get props =>
      [this.mobileNumber, this.fromDate, this.toDate, this.transactionId, this.status,
        this.refillSources, this.pageSize, this.pageSize];
}
