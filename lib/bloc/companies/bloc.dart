import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../api/methods.dart';
import '../../api/retrofit.dart';
import '../../utils/local_data.dart';
import 'event.dart';
import 'state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  late ApiClient mClient;

  CompanyBloc() : super(InitCompanyState()) {
    mClient = ApiClient(certificateClient());
     on<CompanyInitEvent>((event, emit){
       emit(InitCompanyState());
     });


    on<GetCompanyByCode>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getCompanyByCode(token,event.code).then((v) {
            emit(GotCompanyByCodeState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorCompanyState(
                translate("messages.couldNotGetCompaniesByCode")));
          else {
            print("Error" + e.toString());
            emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
      }
    });

    on<GetCompaniesByName>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getCompaniesByName(token,event.page, 10, event.name).then((v) {
            emit(GotCompaniesByNameState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorCompanyState(
                translate("messages.couldNotGetCompaniesByName")));
          else {
            print("Error" + e.toString());
            emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
      }
    });


    on<GetCompaniesEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getAllCompanies(token,event.page, 10).then((v) {
            emit(GotCompaniesState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorCompanyState(
                translate("messages.couldNotGetCompanies")));
          else {
            print("Error" + e.toString());
            emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
      }
    });


    on<UpdateCompanyEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.updateCompany(token, event.company).then((v) {
              emit(UpdatedCompanyState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotUpdateCompany")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotUpdateCompany")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<AddCompanyEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.insertCompany(token, event.company).then((v) {
            emit(AddedCompanyState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotAddCompany")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotAddCompany")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<DeleteCompanyEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.deleteCompany(token, event.company.id!).then((v) {
            emit(DeletedCompanyState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotDeleteCompany")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotDeleteCompany")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });





    on<GetCompanyBranchesEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getCompanyBranches(token, 1, 999999, event.companyId).then((v) {
              emit(GotCompanyBranchesState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotLoadCompanyBranches")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotLoadCompanyBranches")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetAllCompanyBranchesEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getAllCompanyBranches(token, 1, 999999).then((v) {
              emit(GotAllCompanyBranchesState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotLoadAllCompanyBranches")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotLoadAllCompanyBranches")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<UpdateCompanyBranchEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.updateCompanyBranch(token, event.companyBranch).then((v) {
            emit(UpdatedCompanyBranchState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotUpdateCompanyBranch")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotUpdateCompanyBranch")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<AddCompanyBranchEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.insertCompanyBranch(token, event.companyBranch).then((v) {
            emit(AddedCompanyBranchState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotAddCompanyBranch")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotAddCompanyBranch")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<DeleteCompanyBranchEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.deleteCompanyBranch(token, event.companyBranch.id!).then((v) {
            emit(DeletedCompanyBranchState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotDeleteCompanyBranch")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotDeleteCompanyBranch")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });



    on<GetGroupsByName>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getGroupsByName(token,event.page, 10, event.name).then((v) {
            emit(GotGroupsByNameState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorCompanyState(
                translate("messages.couldNotGetGroupsByName")));
          else {
            print("Error" + e.toString());
            emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
      }
    });


    on<GetGroupsEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.getAllGroups(token,event.page, 10).then((v) {
            emit(GotGroupsState(v));
          });
        }
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorCompanyState(
                translate("messages.couldNotGetGroups")));
          else {
            print("Error" + e.toString());
            emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
          }
        }
        else
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
      }
    });


    on<UpdateGroupEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.updateGroup(token, event.group).then((v) {
            emit(UpdatedGroupState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotUpdateGroup")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotUpdateGroup")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<AddGroupEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.insertGroup(token, event.group).then((v) {
            emit(AddedGroupState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotAddGroup")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotAddGroup")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<DeleteGroupEvent>((event, emit) async {
      try {
        emit(LoadingCompanyState());
        var token = await getBearerTokenValue();
        if (token != null) {
          await mClient.deleteGroup(token, event.group.id!).then((v) {
            emit(DeletedGroupState(v));
          });
        }
        else
          emit(ErrorCompanyState(translate("messages.couldNotDeleteGroup")));
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
          emit(ErrorCompanyState(translate("messages.couldNotDeleteGroup")));
        else {
          print("Error" + e.toString());
          emit(ErrorCompanyState(dioErrorMessageAdapter(e)));
        }
      }
    });




  }
}


