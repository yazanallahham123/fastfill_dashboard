// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_branches_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyBranchesWithPagination _$CompanyBranchesWithPaginationFromJson(
        Map<String, dynamic> json) =>
    CompanyBranchesWithPagination(
      companyBranches: (json['companyBranches'] as List<dynamic>?)
          ?.map((e) => CompanyBranch.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyBranchesWithPaginationToJson(
        CompanyBranchesWithPagination instance) =>
    <String, dynamic>{
      'companyBranches': instance.companyBranches,
      'paginationInfo': instance.paginationInfo,
    };
