import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'custom_notification_body.g.dart';

@JsonSerializable()
class CustomNotificationBody extends Equatable {
  String? mobileNumber;
  String? title;
  String? content;

  CustomNotificationBody(
      {this.mobileNumber,
        this.title,
        this.content});

  factory CustomNotificationBody.fromJson(Map<String, dynamic> json) => _$CustomNotificationBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CustomNotificationBodyToJson(this);

  @override
  List<Object?> get props => [
    this.mobileNumber,
    this.title,
    this.content,
  ];
}