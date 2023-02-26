import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'custom_notification_body_to_multiple.g.dart';

@JsonSerializable()
class CustomNotificationBodyToMultiple extends Equatable {
  List<String>? mobileNumbers;
  String? title;
  String? content;

  CustomNotificationBodyToMultiple(
      {this.mobileNumbers,
        this.title,
        this.content});

  factory CustomNotificationBodyToMultiple.fromJson(Map<String, dynamic> json) => _$CustomNotificationBodyToMultipleFromJson(json);

  Map<String, dynamic> toJson() => _$CustomNotificationBodyToMultipleToJson(this);

  @override
  List<Object?> get props => [
    this.mobileNumbers,
    this.title,
    this.content,
  ];
}