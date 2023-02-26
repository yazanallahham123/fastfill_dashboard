import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_up_credit_dto.g.dart';

@JsonSerializable()
class TopUpCreditDto extends Equatable {
  final String? lang;
  final String? mobileNumber;
  final double? amount;
  final String? transactionId;

  const TopUpCreditDto(
      {this.lang, this.mobileNumber, this.amount, this.transactionId});

  factory TopUpCreditDto.fromJson(Map<String, dynamic> json) => _$TopUpCreditDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TopUpCreditDtoToJson(this);

  @override
  List<Object?> get props => [
    this.lang,
    this.mobileNumber,
    this.amount,
    this.transactionId
  ];
}