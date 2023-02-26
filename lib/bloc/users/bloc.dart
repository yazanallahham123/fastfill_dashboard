import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../api/methods.dart';
import '../../api/retrofit.dart';
import '../../utils/local_data.dart';
import 'event.dart';
import 'state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late ApiClient mClient;

  UserBloc() : super(InitUserState()) {
    mClient = ApiClient(certificateClient());

      on<UserInitEvent>((event, emit){
       emit(InitUserState());
     });

    on<GetCompaniesEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getAllCompanies(token,event.page, 10).then((v) {
            emit(GotCompaniesState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotGetCompanies")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });

    on<GetDashboardDataEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getDashboardData(token,).then((v) {
            emit(GotDashboardData(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotGetDashboardData")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });

    on<GetNotificationsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getNotifications(token, event.page, 30).then((v) {
            emit(GotNotificationsState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotGetNotifications")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });

    on<GetUsersEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getUsers(token, event.page, 30).then((v) {
              emit(GotUsersState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotLoadUsers")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotLoadUsers")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetCompaniesUsersEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getCompaniesUsers(token, event.page, 30).then((v) {
              emit(GotCompaniesUsersState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotLoadAdministrators")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotLoadAdministrators")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetAdministratorsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getAdministrators(token, event.page, 30).then((v) {
              emit(GotAdministratorsState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotLoadAdministrators")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotLoadAdministrators")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<UpdateUserEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.updateUser(token, event.user).then((v) {
              emit(UpdatedUserState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotUpdateUser")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotUpdateUser")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<TopUpEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.topUpCredit(token, event.topUpCreditDto).then((v) {
            emit(TopUpState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotTopUp")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotTopUp")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<AddUserEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.insertUser(token, event.user).then((v) {
            emit(AddedUserState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotAddUser")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotAddUser")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.deleteUser(token, event.user.id!).then((v) {
            emit(DeletedUserState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotDeleteUser")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotDeleteUser")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<GetPaymentTransactionResultsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getPaymentTransactionResults(token, event.paymentTransactionResultsFilter).then((v) {
            emit(GotPaymentTransactionResultsState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotGetPaymentTransactionResults")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotGetPaymentTransactionResults")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetRefillsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getRefills(token, event.userRefillFilter).then((v) {
            emit(GotRefillsState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotGetRefills")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotGetRefills")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<GetUserByIdEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getUserById(token, event.id, event.roleId).then((v) {
            emit(GotUserByIdState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotGetUserById")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotGetUserById")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });



    on<GetUserByMobileNumberEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getUserByMobileNumber(token, event.mobileNumber, event.roleId).then((v) {
            emit(GotUserByMobileNumberState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotGetUserByMobileNumber")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotGetUserByMobileNumber")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<SendCustomNotificationToMultipleEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.sendCustomNotificationToMultiple(token, event.customNotificationBodyToMultiple).then((v) {
            emit(SentCustomNotificationToMultipleState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotSendNotification")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotSendNotification")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<SendCustomNotificationEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.sendCustomNotification(token, event.customNotificationBody).then((v) {
            emit(SentCustomNotificationState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotSendNotification")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotSendNotification")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<SendCustomNotificationToAllEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.sendCustomNotificationToAll(token, event.customNotificationBody).then((v) {
            emit(SentCustomNotificationToAllState(v));
          });
        }
        else
          emit(ErrorUserState(translate("messages.couldNotSendNotificationToAll")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorUserState(translate("messages.couldNotSendNotificationToAll")));
        else {
          print("Error" + e.toString());
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetGroupsEvent>((event, emit) async {
      try {
        emit(LoadingUserState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getAllGroups(token,event.page, 10).then((v) {
            emit(GotGroupsState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorUserState(
                translate("messages.couldNotGetGroups")));
          else {
            print("Error" + e.toString());
            emit(ErrorUserState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorUserState(dioErrorMessageAdapter(e)));
      }
    });
  }
}


