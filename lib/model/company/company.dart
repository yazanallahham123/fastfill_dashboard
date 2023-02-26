import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../group/group.dart';

part 'company.g.dart';

@JsonSerializable()
class Company extends Equatable {
  int? id;
  String? arabicName;
  String? englishName;
  String? arabicAddress;
  String? englishAddress;
  String? code;
  bool? disabled;
  Group? group;
  int? groupId;
  bool? autoAddToFavorite;

  Company(
      {this.id,
        this.arabicName,
        this.englishName,
        this.arabicAddress,
        this.englishAddress,
        this.code,
        this.disabled,
        this.group,
        this.groupId,
        this.autoAddToFavorite});

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.arabicName,
    this.englishName,
    this.arabicAddress,
    this.englishAddress,
    this.code,
    this.disabled,
    this.group,
    this.groupId,
    this.autoAddToFavorite
  ];
}