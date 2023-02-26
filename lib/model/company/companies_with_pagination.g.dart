// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompaniesWithPagination _$CompaniesWithPaginationFromJson(
        Map<String, dynamic> json) =>
    CompaniesWithPagination(
      companies: (json['companies'] as List<dynamic>?)
          ?.map((e) => Company.fromJson(e as Map<String, dynamic>))
          .toList(),
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompaniesWithPaginationToJson(
        CompaniesWithPagination instance) =>
    <String, dynamic>{
      'companies': instance.companies,
      'paginationInfo': instance.paginationInfo,
    };
