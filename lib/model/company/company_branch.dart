import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_branch.g.dart';

@JsonSerializable()
class CompanyBranch extends Equatable {
  int? id;
  String? arabicName;
  String? englishName;
  String? arabicAddress;
  String? englishAddress;
  String? code;
  int? companyId;

  CompanyBranch(
      {this.id,
        this.arabicName,
        this.englishName,
        this.arabicAddress,
        this.englishAddress,
        this.code,
        this.companyId});

  factory CompanyBranch.fromJson(Map<String, dynamic> json) => _$CompanyBranchFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyBranchToJson(this);

  @override
  List<Object?> get props => [
    this.id,
    this.arabicName,
    this.englishName,
    this.arabicAddress,
    this.englishAddress,
    this.code,
    this.companyId
  ];
}