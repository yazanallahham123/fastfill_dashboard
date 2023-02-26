import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:fastfilldashboard/model/notifications/custom_notification_body.dart';
import 'package:fastfilldashboard/model/notifications/custom_notification_body_to_multiple.dart';
import 'package:fastfilldashboard/model/refills/user_refill_filter.dart';
import 'package:fastfilldashboard/model/user/top_up_credit_dto.dart';

import '../../model/group/group.dart';
import '../../model/user/payment_transaction_results_filter.dart';
import '../../model/user/user.dart';

abstract class UserEvent extends Equatable{

  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserInitEvent extends UserEvent {
  const UserInitEvent();
}

class GetDashboardDataEvent extends UserEvent {
  const GetDashboardDataEvent();
}

class GetUsersEvent extends UserEvent {
  final int page;
  const GetUsersEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class GetAdministratorsEvent extends UserEvent {
  final int page;

  const GetAdministratorsEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class UpdateUserEvent extends UserEvent {
  final User user;
  const UpdateUserEvent(this.user);

  @override
  List<Object?> get props => [this.user];
}

class AddUserEvent extends UserEvent {
  final User user;
  const AddUserEvent(this.user);

  @override
  List<Object?> get props => [this.user];
}

class DeleteUserEvent extends UserEvent {
  final User user;
  const DeleteUserEvent(this.user);

  @override
  List<Object?> get props => [this.user];
}

class GetNotificationsEvent extends UserEvent{
  final int page;
  const GetNotificationsEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}


class GetCompaniesUsersEvent extends UserEvent {
  final int page;
  const GetCompaniesUsersEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class GetCompaniesEvent extends UserEvent {
  final int page;
  const GetCompaniesEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}


class TopUpEvent extends UserEvent {
  final TopUpCreditDto topUpCreditDto;
  const TopUpEvent(this.topUpCreditDto);

  @override
  List<Object?> get props => [this.topUpCreditDto];
}


class GetRefillsEvent extends UserEvent {
  final UserRefillFilter userRefillFilter;
  const GetRefillsEvent(this.userRefillFilter);

  @override
  List<Object?> get props => [this.userRefillFilter];
}


class SendCustomNotificationEvent extends UserEvent {
  final CustomNotificationBody customNotificationBody;
  const SendCustomNotificationEvent(this.customNotificationBody);

  @override
  List<Object?> get props => [this.customNotificationBody];
}

class SendCustomNotificationToAllEvent extends UserEvent {
  final CustomNotificationBody customNotificationBody;
  const SendCustomNotificationToAllEvent(this.customNotificationBody);

  @override
  List<Object?> get props => [this.customNotificationBody];
}

class SendCustomNotificationToMultipleEvent extends UserEvent {
  final CustomNotificationBodyToMultiple customNotificationBodyToMultiple;
  const SendCustomNotificationToMultipleEvent(this.customNotificationBodyToMultiple);

  @override
  List<Object?> get props => [this.customNotificationBodyToMultiple];
}

class GetUserByMobileNumberEvent extends UserEvent {
  final String mobileNumber;
  final int roleId;
  const GetUserByMobileNumberEvent(this.mobileNumber, this.roleId);

  @override
  List<Object?> get props => [this.mobileNumber, this.roleId];
}

class GetUserByIdEvent extends UserEvent {
  final int id;
  final int roleId;
  const GetUserByIdEvent(this.id, this.roleId);

  @override
  List<Object?> get props => [this.id, this.roleId];
}

class GetPaymentTransactionResultsEvent extends UserEvent {
  final PaymentTransactionResultsFilter paymentTransactionResultsFilter;
  const GetPaymentTransactionResultsEvent(this.paymentTransactionResultsFilter);

  @override
  List<Object?> get props => [this.paymentTransactionResultsFilter];
}


class GetGroupsByName extends UserEvent {
  final String name;
  final int page;
  const GetGroupsByName(this.name, this.page);

  @override
  List<Object?> get props => [this.name, this.page];
}

class GetGroupsEvent extends UserEvent {
  final int page;
  const GetGroupsEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class DeleteGroupEvent extends UserEvent {
  final Group group;
  const DeleteGroupEvent(this.group);

  @override
  List<Object?> get props => [this.group];
}


class AddGroupEvent extends UserEvent {
  final Group group;
  const AddGroupEvent(this.group);

  @override
  List<Object?> get props => [this.group];
}

class UpdateGroupEvent extends UserEvent {
  final Group group;
  const UpdateGroupEvent(this.group);

  @override
  List<Object?> get props => [this.group];
}