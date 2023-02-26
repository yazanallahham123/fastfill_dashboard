import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_up_response.g.dart';

@JsonSerializable()
class TopUpResponse extends Equatable {
  final String? responseCode;
  final String? responseMessage;

  const TopUpResponse(
      {this.responseCode, this.responseMessage});

  factory TopUpResponse.fromJson(Map<String, dynamic> json) => _$TopUpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopUpResponseToJson(this);

  @override
  List<Object?> get props => [
    this.responseCode,
    this.responseMessage,
  ];
}