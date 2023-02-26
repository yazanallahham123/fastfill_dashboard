import 'package:equatable/equatable.dart';
import 'package:fastfilldashboard/model/common/pagination_info.dart';
import 'package:json_annotation/json_annotation.dart';

import 'company_branch.dart';

part 'company_branches_with_pagination.g.dart';

@JsonSerializable()
class CompanyBranchesWithPagination extends Equatable {
  List<CompanyBranch>? companyBranches;
  PaginationInfo? paginationInfo;

  CompanyBranchesWithPagination(
      {this.companyBranches,
        this.paginationInfo});

  factory CompanyBranchesWithPagination.fromJson(Map<String, dynamic> json) => _$CompanyBranchesWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyBranchesWithPaginationToJson(this);

  @override
  List<Object?> get props => [
    this.companyBranches,
    this.paginationInfo
  ];
}