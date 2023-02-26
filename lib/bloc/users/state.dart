import 'package:equatable/equatable.dart';
import 'package:fastfilldashboard/model/company/payment_transactions_result_with_pagination.dart';
import 'package:fastfilldashboard/model/dashboard/dashboard_data.dart';
import 'package:fastfilldashboard/model/refills/user_refills_with_pagination.dart';
import 'package:fastfilldashboard/model/user/top_up_response.dart';

import '../../model/company/companies_with_pagination.dart';
import '../../model/group/groups_with_pagination.dart';
import '../../model/notifications/notifications_with_pagination.dart';
import '../../model/user/user.dart';
import '../../model/user/users_with_pagination.dart';

abstract class UserState extends Equatable{

  const UserState();

  @override
  List<Object?> get props => [];
}

class InitUserState extends UserState{
  const InitUserState();
}

class LoadingUserState extends UserState{
  const LoadingUserState();
}

class ErrorUserState extends UserState{
  final String error;

  const ErrorUserState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class GotUsersState extends UserState {
  final UsersWithPagination usersWithPagination;

  const GotUsersState(this.usersWithPagination);

  @override
  List<Object?> get props => [this.usersWithPagination];
}

class GotAdministratorsState extends UserState {
  final UsersWithPagination administratorsWithPagination;

  const GotAdministratorsState(this.administratorsWithPagination);

  @override
  List<Object?> get props => [this.administratorsWithPagination];
}

class UpdatedUserState extends UserState {
  final String updateResult;

  const UpdatedUserState(this.updateResult);

  @override
  List<Object?> get props => [this.updateResult];
}

class AddedUserState extends UserState {
  final String addResult;

  const AddedUserState(this.addResult);

  @override
  List<Object?> get props => [this.addResult];
}

class DeletedUserState extends UserState {
  final String deleteResult;

  const DeletedUserState(this.deleteResult);

  @override
  List<Object?> get props => [this.deleteResult];
}

class GotNotificationsState extends UserState{
  final NotificationsWithPagination notificationsWithPagination;

  const GotNotificationsState(this.notificationsWithPagination);

  @override
  List<Object?> get props => [this.notificationsWithPagination];

}

class GotCompaniesUsersState extends UserState {
  final UsersWithPagination companiesUsersWithPagination;

  const GotCompaniesUsersState(this.companiesUsersWithPagination);

  @override
  List<Object?> get props => [this.companiesUsersWithPagination];
}

class GotDashboardData extends UserState {

  final DashboardData dashboardData;

  const GotDashboardData(this.dashboardData);

  @override
  List<Object?> get props => [this.dashboardData];
}

class GotCompaniesState extends UserState {
  final CompaniesWithPagination companiesWithPagination;

  const GotCompaniesState(this.companiesWithPagination);

  @override
  List<Object?> get props => [this.companiesWithPagination];
}

class TopUpState extends UserState {
  final TopUpResponse response;

  const TopUpState(this.response);

  @override
  List<Object?> get props => [this.response];
}

class GotRefillsState extends UserState {
  final UserRefillsWithPagination userRefills;
  const GotRefillsState(this.userRefills);

  @override
  List<Object?> get props => [this.userRefills];
}

class SentCustomNotificationState extends UserState {
  final bool result;
  const SentCustomNotificationState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class SentCustomNotificationToMultipleState extends UserState {
  final bool result;
  const SentCustomNotificationToMultipleState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class SentCustomNotificationToAllState extends UserState {
  final bool result;
  const SentCustomNotificationToAllState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class GotUserByMobileNumberState extends UserState {
  final User? user;
  const GotUserByMobileNumberState(this.user);

  @override
  List<Object?> get props => [this.user];
}

class GotUserByIdState extends UserState {
  final User? user;
  const GotUserByIdState(this.user);

  @override
  List<Object?> get props => [this.user];
}

class GotPaymentTransactionResultsState extends UserState {
  final PaymentTransactionResultWithPagination paymentTransactionResults;
  const GotPaymentTransactionResultsState(this.paymentTransactionResults);

  @override
  List<Object?> get props => [this.paymentTransactionResults];
}


class GotGroupsByNameState extends UserState {
  final GroupsWithPagination groupsWithPagination;

  const GotGroupsByNameState(this.groupsWithPagination);

  @override
  List<Object?> get props => [this.groupsWithPagination];
}


class GotGroupsState extends UserState {
  final GroupsWithPagination groupsWithPagination;

  const GotGroupsState(this.groupsWithPagination);

  @override
  List<Object?> get props => [this.groupsWithPagination];
}

class UpdatedGroupState extends UserState {
  final String updateResult;

  const UpdatedGroupState(this.updateResult);

  @override
  List<Object?> get props => [this.updateResult];
}

class AddedGroupState extends UserState {
  final String addResult;

  const AddedGroupState(this.addResult);

  @override
  List<Object?> get props => [this.addResult];
}

class DeletedGroupState extends UserState {
  final String deleteResult;

  const DeletedGroupState(this.deleteResult);

  @override
  List<Object?> get props => [this.deleteResult];
}
