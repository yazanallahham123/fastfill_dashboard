import 'package:equatable/equatable.dart';
import 'package:fastfilldashboard/model/common/pagination_info.dart';
import 'package:fastfilldashboard/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_with_pagination.g.dart';

@JsonSerializable()
class UsersWithPagination extends Equatable {
  final PaginationInfo? paginationInfo;
  final List<User>? users;


  const UsersWithPagination(
      {this.paginationInfo,
        this.users});

  factory UsersWithPagination.fromJson(Map<String, dynamic> json) => _$UsersWithPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$UsersWithPaginationToJson(this);

  @override
  List<Object?> get props => [
    this.paginationInfo,
    this.users,
  ];
}