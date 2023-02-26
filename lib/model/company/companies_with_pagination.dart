import 'package:equatable/equatable.dart';
import 'package:fastfilldashboard/model/common/pagination_info.dart';
import 'package:json_annotation/json_annotation.dart';

import 'company.dart';

part 'companies_with_pagination.g.dart';

@JsonSerializable()
class CompaniesWithPagination extends Equatable {
  final List<Company>? companies;
  final PaginationInfo? paginationInfo;

  CompaniesWithPagination(
      {this.companies,
        this.paginationInfo});

  factory CompaniesWithPagination.fromJson(Map<String, dynamic> json) => _$CompaniesWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$CompaniesWithPaginationToJson(this);

  @override
  List<Object?> get props => [
    this.companies,
    this.paginationInfo
  ];
}