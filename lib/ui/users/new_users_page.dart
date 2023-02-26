import 'package:fastfilldashboard/bloc/users/event.dart';
import 'package:fastfilldashboard/bloc/users/state.dart';
import 'package:fastfilldashboard/helper/app_colors.dart';
import 'package:fastfilldashboard/helper/enums.dart';
import 'package:fastfilldashboard/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../api/methods.dart';
import '../../api/retrofit.dart';
import '../../bloc/users/bloc.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../common_widgets/app_widgets/user_widget.dart';
import '../../common_widgets/buttons/custom_button.dart';
import '../../helper/toast.dart';
import '../../main.dart';
import '../../model/company/company.dart';
import '../../model/user/user.dart';
import '../../utils/misc.dart';

class NewUsersPage extends StatefulWidget {
  static const route = "/new_users_page";

  final roles role;

  const NewUsersPage({required this.role});

  @override
  State<NewUsersPage> createState() => _NewUsersPageState();
}

final ApiClient mClient = ApiClient(certificateClient());

List<User> users = [];
ScrollController controller = ScrollController();
bool hasNext = false;
int currentPage = 1;
bool loadMore = false;
int totalCount = 0;
TextEditingController searchTextController = TextEditingController();
searchBy? selectedSearchMethod = searchBy.MobileNumber;
List<Company> companies = [];
Company? selectedCompany;


class _NewUsersPageState extends State<NewUsersPage> {

  @override
  void initState() {
    print("aaaaa");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) =>
        UserBloc()..add(UserInitEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is InitUserState) {
            users = [];
            currentPage = 1;
            loadMore = false;
            hasNext = false;
            if (widget.role == roles.User)
              bloc.add(GetUsersEvent(1));
            else
            if (widget.role == roles.Admin)
              bloc.add(GetAdministratorsEvent(1));
            else
            if (widget.role == roles.CompanyUser)
              bloc.add(GetCompaniesUsersEvent(1));
          }
          else if (state is ErrorUserState) {
            pushToast(state.error);
            if (mounted) {
              setState(() {
                users = [];
                currentPage = 1;
                loadMore = false;
                hasNext = false;
                totalCount = 0;
              });
            }
          }
          else if (state is GotUsersState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                  if (state.usersWithPagination.paginationInfo != null)
                    {
                      if (state.usersWithPagination.paginationInfo!.pageNo == 1)
                        users = [];
                    hasNext = state.usersWithPagination.paginationInfo!.hasNext!;
                    totalCount = state.usersWithPagination.paginationInfo!.totalItems!;
                    }
                  else
                    hasNext = false;

                  if (state.usersWithPagination.users != null) {
                    users.addAll(state.usersWithPagination.users!);
                  }
                  else {
                    hasNext = false;
                  }
              });
            }
          }
          else if (state is GotAdministratorsState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                  if (state.administratorsWithPagination.paginationInfo != null)
                  {
                    hasNext = state.administratorsWithPagination.paginationInfo!.hasNext!;
                    totalCount = state.administratorsWithPagination.paginationInfo!.totalItems!;
                  }
                  else
                    hasNext = false;

                  if (state.administratorsWithPagination.users != null) {
                    users.addAll(state.administratorsWithPagination.users!);
                  }
                  else {
                    hasNext = false;
                  }
              });
            }
          }
          else if (state is GotCompaniesUsersState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                  if (state.companiesUsersWithPagination.paginationInfo != null)
                  {
                    hasNext = state.companiesUsersWithPagination.paginationInfo!.hasNext!;
                    totalCount = state.companiesUsersWithPagination.paginationInfo!.totalItems!;
                  }
                  else
                    hasNext = false;

                  if (state.companiesUsersWithPagination.users != null) {
                    users.addAll(state.companiesUsersWithPagination.users!);
                  }
                  else {
                    hasNext = false;
                  }


                companies = [];
                bloc.add(GetCompaniesEvent(1));
              });
            }
          }
          else if (state is GotCompaniesState) {
            companies.addAll(state.companiesWithPagination.companies!);
          }
          else if (state is UpdatedUserState) {
            if (state.updateResult == "Updated successfully.")
              {
                if (widget.role == roles.User)
                  bloc.add(GetUsersEvent(1));
                else
                if (widget.role == roles.Admin)
                  bloc.add(GetAdministratorsEvent(1));
                else
                if (widget.role == roles.CompanyUser)
                  bloc.add(GetCompaniesUsersEvent(1));
              }
            else
              pushToast(translate("messages.couldNotUpdateUser"));
          }
          else if (state is GotUserByIdState) {
            if (state.user != null)
            {
              if (mounted) {
                setState(() {
                  users = [];
                  currentPage = 1;
                  loadMore = false;
                  hasNext = false;
                  users.add(state.user!);
                  totalCount = 1;
                });
              }
            }
            else
            {
              if (mounted) {
                setState(() {
                  users = [];
                  currentPage = 1;
                  loadMore = false;
                  hasNext = false;
                  totalCount = 0;
                });
              }
            }
          }
          else if (state is GotUserByMobileNumberState) {
            if (state.user != null)
              {
                if (mounted) {
                  setState(() {
                    users = [];
                    currentPage = 1;
                    loadMore = false;
                    hasNext = false;
                    users.add(state.user!);
                    totalCount = 1;
                  });
                }
              }
            else
              {
                if (mounted) {
                  setState(() {
                    users = [];
                    currentPage = 1;
                    loadMore = false;
                    hasNext = false;
                    totalCount = 0;
                  });
                }
              }
          }
          else if (state is AddedUserState) {
            if (state.addResult == "Added successfully.")
              {
                if (widget.role == roles.User)
                  bloc.add(GetUsersEvent(1));
                else
                if (widget.role == roles.Admin)
                  bloc.add(GetAdministratorsEvent(1));
                else
                if (widget.role == roles.CompanyUser)
                  bloc.add(GetCompaniesUsersEvent(1));
              }
            else
              pushToast(translate("messages.couldNotAddUser"));
          }
          else if (state is DeletedUserState) {
            if (state.deleteResult == "Deleted successfully.") {
              if (widget.role == roles.User)
                bloc.add(GetUsersEvent(1));
              else
              if (widget.role == roles.Admin)
                bloc.add(GetAdministratorsEvent(1));
              else
              if (widget.role == roles.CompanyUser)
                bloc.add(GetCompaniesUsersEvent(1));

            } else
              pushToast(translate("messages.couldNotDeleteUser"));
          }
        },
        bloc: bloc,
        child: BlocBuilder<UserBloc, UserState>(
            bloc: bloc,
            builder: (context, UserState state) {
              return new _BuildUI(bloc: bloc, state: state, role: widget.role);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final UserBloc bloc;
  final UserState state;
  final roles role;

  _BuildUI({required this.bloc, required this.state, required this.role});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body:
        Column(children: [

          Row(children: [
          Align(
            child: Padding(
                child:
                Text(
            (widget.role == roles.User) ? translate("drawer.users") : (widget.role == roles.Admin) ? translate("drawer.administrators") : (widget.role == roles.CompanyUser) ? translate("drawer.companiesUsers") : "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: buttonColor1),
                ),
                padding: EdgeInsetsDirectional.only(
                    start: SizeConfig().w(25),
                    top: SizeConfig().h(10))),
            alignment: AlignmentDirectional.topStart,
          ),
    Padding(
    child:
          IconButton(onPressed: () async {

            User? u = await showRecordDialog(
                recordDialogStatus.Add, null);
            if (u != null) {
              widget.bloc.add(AddUserEvent(u));
            }
          }, icon: Icon(Icons.add)),
        padding: EdgeInsetsDirectional.only(
            top: SizeConfig().h(10))
    ),

          ],),

          Padding(child:
          Row(children: [
            Expanded(child: TextField(
              controller: searchTextController,
              onSubmitted: (x){
                search();
              },
              decoration: InputDecoration(
                  hintText: translate("messages.pleaseEnterText")),
            )),

                IconButton(onPressed: () async {
                  search();
                }, icon: Icon(Icons.search)),
          ],),
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          ),
          Row(children: [
            Padding(child:
            Radio(value: searchBy.Id, groupValue: selectedSearchMethod, onChanged: (searchBy? val){
              if (mounted) {
                setState(() {
                  selectedSearchMethod = val;
                });
              }
            }), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 0),),
            Text("By Id"),

            Padding(child:
            Radio(value: searchBy.MobileNumber, groupValue: selectedSearchMethod, onChanged: (searchBy? val){
              if (mounted) {
                setState(() {
                  selectedSearchMethod = val;
                });
              }
            }), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 0),),
            Text("By Mobile Number"),
          ],),

          Align(child: Padding(child: Text(translate("labels.totalUsers")+": "+ totalCount.toString(), style: TextStyle(fontWeight: FontWeight.bold),),padding: EdgeInsetsDirectional.fromSTEB(25, 10, 0, 10),), alignment: AlignmentDirectional.topStart,),
          ((widget.state is InitUserState) || ((widget.state is LoadingUserState) && (!loadMore))) ?
          Center(child: CustomLoading(),) :
          Expanded(child:
          LayoutBuilder(builder: (context, constraints) =>
              RefreshIndicator(onRefresh: () async {
                currentPage = 1;
                users = [];
                loadMore = false;
                if (widget.role == roles.User)
                  widget.bloc.add(GetUsersEvent(1));
                else
                if (widget.role == roles.Admin)
                  widget.bloc.add(GetAdministratorsEvent(1));
                else
                if (widget.role == roles.CompanyUser)
                  widget.bloc.add(GetCompaniesUsersEvent(1));
              },
                  color: Colors.white,
                  backgroundColor: buttonColor1,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  child:


                  (users.length == 0) ?
                  SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child:
                      ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child:

                          Center(child: ListView(
                            shrinkWrap: true,
                            children: [

                              Align(child: Text(translate("messages.noData"), style: TextStyle(color: Colors.white),),alignment: AlignmentDirectional.center,)

                            ],

                          )))) :
                  Stack(children: [
                    Material(
                        type: MaterialType.transparency,
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          controller: controller,
                          itemBuilder: (context, index)
                          {
                            return UserWidget(user: users[index],
                              onDelete: (){
                                showAlertDialog(context, translate("messages.deleteTitle"), translate("messages.deleteContent"),
                                        (){
                                      widget.bloc.add(DeleteUserEvent(users[index]));
                                    }
                                );
                              },
                              onEdit: () async {
                                User? u = await showRecordDialog(
                                    recordDialogStatus.Edit, users[index]);
                                if (u != null) {
                                  if (u.id != null) {
                                    widget.bloc.add(UpdateUserEvent(u));
                                  }
                                }
                              },
                            );
                          },
                          itemCount: users.length,
                        )),
                    (loadMore) ?
                    Container(
                      color: Colors.white12,
                      child: Align(child: CustomLoading(), alignment: AlignmentDirectional.center,),) :
                    Container()
                  ]))
          )
          ),
        ],)
    );
  }

  void _scrollListener() {
    print(controller.position.extentAfter);
    if ((!(widget.state is LoadingUserState)) && (!loadMore)) {
      if (hasNext) {
        if (controller.position.pixels >
            (controller.position.maxScrollExtent * .75)) {
          setState(() {
            loadMore = true;
            currentPage = currentPage + 1;
            if (widget.role == roles.User)
              widget.bloc.add(GetUsersEvent(currentPage));
            else
            if (widget.role == roles.Admin)
              widget.bloc.add(GetAdministratorsEvent(currentPage));
            else
            if (widget.role == roles.CompanyUser)
              widget.bloc.add(GetCompaniesUsersEvent(currentPage));

          });
        }
      }
    }
  }

  search()
  {


    hideKeyboard(context);

    if (selectedSearchMethod == searchBy.MobileNumber)
    {

      if (searchTextController.text.isNotEmpty) {
        String pn = "";
          if ((searchTextController.text.length == 9) ||
              (searchTextController.text.length == 10)) {
            if ((searchTextController.text.length == 10) &&
                (searchTextController.text.substring(0, 1) ==
                    "0")) {
              pn = searchTextController.text
                  .substring(1, searchTextController.text.length);
            } else {
              if (searchTextController.text.length == 9) {
                pn = searchTextController.text;
              }
            }
          }
        widget.bloc.add(GetUserByMobileNumberEvent(pn,
            (widget.role == roles.User) ? 3 :
            (widget.role == roles.Admin) ? 1 :
            (widget.role == roles.CompanyUser) ? 4 :
                0
        ));
      }
      else
      {
        if (widget.role == roles.User)
          widget.bloc.add(GetUsersEvent(1));
        else
        if (widget.role == roles.Admin)
          widget.bloc.add(GetAdministratorsEvent(1));
        else
        if (widget.role == roles.CompanyUser)
          widget.bloc.add(GetCompaniesUsersEvent(1));

      }
    }
    else {
      if (searchTextController.text.isNotEmpty) {
        int? id = null;
        try {
          id = int.tryParse(searchTextController.text);
        } catch (x) {
          id = null;
        }

        if (id != null)
          widget.bloc.add(GetUserByIdEvent(id,

              (widget.role == roles.User) ? 3 :
              (widget.role == roles.Admin) ? 1 :
              (widget.role == roles.CompanyUser) ? 4 :
              0

          ));
        else {
          if (widget.role == roles.User)
            widget.bloc.add(GetUsersEvent(1));
          else if (widget.role == roles.Admin)
            widget.bloc.add(GetAdministratorsEvent(1));
          else if (widget.role == roles.CompanyUser)
            widget.bloc.add(GetCompaniesUsersEvent(1));
        }
      }
      else
      {
        if (widget.role == roles.User)
          widget.bloc.add(GetUsersEvent(1));
        else if (widget.role == roles.Admin)
          widget.bloc.add(GetAdministratorsEvent(1));
        else if (widget.role == roles.CompanyUser)
          widget.bloc.add(GetCompaniesUsersEvent(1));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<User?> showRecordDialog(
      recordDialogStatus dialogStatus, User? user) async {
    User? a = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return _recordDialog(status: dialogStatus, role: widget.role, user: user);
      },
    );

    return a;
  }

}

class _recordDialog extends StatefulWidget {
  final User? user;
  final recordDialogStatus status;
  final roles role;
  _recordDialog({required this.status, required this.role, this.user });

  @override
  _recordDialogState createState() => _recordDialogState();
}

class _recordDialogState extends State<_recordDialog> {
  TextEditingController fullnameTextController = TextEditingController();
  TextEditingController mobileNumberTextController = TextEditingController();
  TextEditingController idTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool disabledValue = false;
  User finalUser = User();

  @override
  void initState() {
    if ((widget.status == recordDialogStatus.Edit) ||
        (widget.status == recordDialogStatus.View)) {
      finalUser = widget.user!;
      disabledValue = widget.user!.disabled??false;
      fullnameTextController.text = widget.user!.firstName!;
      mobileNumberTextController.text = widget.user!.mobileNumber!;
      idTextController.text = widget.user!.id!.toString();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = (widget.status == recordDialogStatus.Edit)
        ? translate("labels.edit")
        : (widget.status == recordDialogStatus.Add)
        ? translate("labels.add")
        : translate("labels.view");
    return Dialog(
        child: Scaffold(
          body: SingleChildScrollView(child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20),
                  SizeConfig().h(20), SizeConfig().w(20), SizeConfig().h(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: fullnameTextController,
                    decoration: InputDecoration(
                        labelText: translate("labels.fullname"),
                        hintText: translate("messages.pleaseEnter") +
                            translate("labels.fullname")),
                  ),
                  TextField(
                    controller: mobileNumberTextController,
                    decoration: InputDecoration(
                        labelText: translate("columns.mobileNumber"),
                        hintText: translate("messages.pleaseEnter") +
                            translate("columns.mobileNumber")),
                  ),
                  TextField(
                    controller: passwordTextController,
                    decoration: InputDecoration(
                        labelText: translate("columns.password"),
                        hintText: translate("messages.pleaseEnter") +
                            translate("columns.password")),
                  ),

                  (widget.user!.roleId! == 4) ? CustomButton(
                      backColor: buttonColor1,
                      titleColor: Colors.white,
                      borderColor: buttonColor1,
                      title: ((widget.status == recordDialogStatus.Edit) ||
                          (widget.status == recordDialogStatus.View)) ? (languageCode == "ar") ? widget.user!.company?.arabicName??"" : widget.user!.company?.englishName??"" : translate("buttons.selectCompany"),
                      onTap: () {
                        showMaterialScrollPicker<Company?>(
                          context: context,
                          title: 'Pick Company',
                          showDivider: false,
                          items: companies,
                          selectedItem: selectedCompany,
                          onChanged: (value) =>
                              setState(() => selectedCompany = value),
                          onCancelled: () => print('Scroll Picker cancelled'),
                          onConfirmed: () => print('Scroll Picker confirmed'),
                        );
                      }) : Container(),

                  Row(
                    children: [
                      Text(translate("columns.disabled")),
                      Checkbox(
                          value: disabledValue,
                          onChanged: (value) {
                            if (mounted) {
                              setState(() {
                                disabledValue = value!;
                              });
                            }
                          })
                    ],
                  )
                ],
              ))),
          appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      if (widget.status == recordDialogStatus.Add) {
                        finalUser.id = -1;
                        if (widget.role == roles.User)
                          finalUser.roleId = 3;
                        if (widget.role == roles.CompanyUser)
                          finalUser.roleId = 4;
                        if (widget.role == roles.Admin)
                          finalUser.roleId = 1;
                        finalUser.imageURL = "";
                      }
                      finalUser.firstName = fullnameTextController.text;
                      finalUser.lastName = fullnameTextController.text;
                      finalUser.mobileNumber = mobileNumberTextController.text;
                      finalUser.username = mobileNumberTextController.text;
                      finalUser.disabled = disabledValue;
                      finalUser.password = passwordTextController.text;
                      if (selectedCompany != null)
                        {
                          finalUser.companyId == selectedCompany!.id;
                          finalUser.company == selectedCompany;
                        }
                      Navigator.pop(context, finalUser);
                    },
                    icon: Icon(Icons.check)),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    icon: Icon(Icons.cancel))
              ],
              title: Text(title)),
        ));
  }


}
