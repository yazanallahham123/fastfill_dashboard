// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_with_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersWithPagination _$UsersWithPaginationFromJson(Map<String, dynamic> json) =>
    UsersWithPagination(
      paginationInfo: json['paginationInfo'] == null
          ? null
          : PaginationInfo.fromJson(
              json['paginationInfo'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsersWithPaginationToJson(
        UsersWithPagination instance) =>
    <String, dynamic>{
      'paginationInfo': instance.paginationInfo,
      'users': instance.users,
    };
