import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_sales.g.dart';

@JsonSerializable()
class CompanySales extends Equatable {
  String? arabicName;
  String? englishName;
  double? amount;
  int? count;

  CompanySales(
      {this.arabicName,
        this.englishName,
        this.amount,
        this.count});

  factory CompanySales.fromJson(Map<String, dynamic> json) => _$CompanySalesFromJson(json);

  Map<String, dynamic> toJson() => _$CompanySalesToJson(this);

  @override
  List<Object?> get props => [
    this.arabicName,
    this.englishName,
    this.amount,
    this.count
  ];
}