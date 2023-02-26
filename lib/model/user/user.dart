import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../company/company.dart';
import '../group/group.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  int? roleId;
  String? mobileNumber;
  bool? disabled;
  String? imageURL;
  String? password;
  Company? company;
  int? companyId;
  Group? group;
  int? groupId;
  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.username,
        this.roleId,
        this.mobileNumber,
        this.disabled,
        this.imageURL,
        this.password,
        this.company,
        this.companyId,
      this.group,
      this.groupId});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.roleId,
    this.mobileNumber,
    this.disabled,
    this.imageURL,
    this.password,
    this.company,
    this.companyId,
    this.group,
    this.groupId
  ];
}