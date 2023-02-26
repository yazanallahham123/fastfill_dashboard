import 'package:fastfilldashboard/bloc/companies/bloc.dart';
import 'package:fastfilldashboard/helper/app_colors.dart';
import 'package:fastfilldashboard/helper/enums.dart';
import 'package:fastfilldashboard/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../api/methods.dart';
import '../../api/retrofit.dart';
import '../../bloc/companies/event.dart';
import '../../bloc/companies/state.dart';
import '../../common_widgets/app_widgets/company_widget.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../common_widgets/buttons/custom_button.dart';
import '../../helper/toast.dart';
import '../../main.dart';
import '../../model/company/company.dart';
import '../../model/group/group.dart';
import '../../utils/misc.dart';

class NewStationsPage extends StatefulWidget {
  static const route = "/new_users_page";

  @override
  State<NewStationsPage> createState() => _NewStationsPageState();
}

final ApiClient mClient = ApiClient(certificateClient());

List<Company> companies = [];
ScrollController controller = ScrollController();
bool hasNext = false;
int currentPage = 1;
bool loadMore = false;
int totalCount = 0;
TextEditingController searchTextController = TextEditingController();
searchBy? selectedSearchMethod = searchBy.Id;


Group? selectedGroup;
List<Group> groups = [];
ScrollController groupsController = ScrollController();
bool groupsHasNext = false;
int currentGroupsPage = 1;
bool groupsLoadMore = false;

class _NewStationsPageState extends State<NewStationsPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CompanyBloc>(
        create: (BuildContext context) =>
        CompanyBloc()..add(CompanyInitEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<CompanyBloc>(context);

    return BlocListener<CompanyBloc, CompanyState>(
        listener: (context, state) async {
          if (state is InitCompanyState) {
            companies = [];
            currentPage = 1;
            loadMore = false;
            hasNext = false;
            bloc.add(GetCompaniesEvent(1));
          }
          else if (state is ErrorCompanyState) {
            pushToast(state.error);
            if (mounted) {
              setState(() {
                companies = [];
                currentPage = 1;
                loadMore = false;
                hasNext = false;
                totalCount = 0;
              });
            }
          }
          else if (state is GotCompaniesState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                  if (state.companiesWithPagination.paginationInfo != null)
                  {
                    if (state.companiesWithPagination.paginationInfo!.pageNo == 1)
                      companies = [];
                    hasNext = state.companiesWithPagination.paginationInfo!.hasNext!;
                    totalCount = state.companiesWithPagination.paginationInfo!.totalItems!;
                  }
                  else
                    hasNext = false;

                  if (state.companiesWithPagination.companies != null) {
                    companies.addAll(state.companiesWithPagination.companies!);
                  }
                  else {
                    hasNext = false;
                  }
              });

            }
            bloc.add(GetGroupsEvent(1));
          }
          else if (state is GotGroupsState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                  if (state.groupsWithPagination.paginationInfo != null)
                  {
                    if (state.groupsWithPagination.paginationInfo!.pageNo == 1)
                      groups = [];
                    groupsHasNext = state.groupsWithPagination.paginationInfo!.hasNext!;
                  }
                  else
                    groupsHasNext = false;

                  if (state.groupsWithPagination.groups != null) {
                    groups.addAll(state.groupsWithPagination.groups!);
                  }
                  else {
                    groupsHasNext = false;
                  }
              });
            }
          }
          else if (state is UpdatedCompanyState) {
            if (state.updateResult == "Updated successfully.")
            {
                bloc.add(GetCompaniesEvent(1));
            }
            else
              pushToast(translate("messages.couldNotUpdateCompany"));
          }
          else if (state is GotCompanyByCodeState) {

              if (mounted) {
                setState(() {
                  companies = [];
                  currentPage = 1;
                  loadMore = false;
                  hasNext = false;
                  companies.add(state.company);
                  totalCount = 1;
                });
              }
          }
          else if (state is GotCompaniesByNameState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                  if (state.companiesWithPagination.paginationInfo != null)
                  {
                    if (state.companiesWithPagination.paginationInfo!.pageNo == 1)
                      companies = [];

                    hasNext = state.companiesWithPagination.paginationInfo!.hasNext!;
                    totalCount = state.companiesWithPagination.paginationInfo!.totalItems!;
                  }
                  else
                    hasNext = false;

                  if (state.companiesWithPagination.companies != null) {
                    companies.addAll(state.companiesWithPagination.companies!);
                  }
                  else {
                    hasNext = false;
                  }
              });
            }
          }
          else if (state is AddedCompanyState) {
            if (state.addResult == "Added successfully.")
            {
                bloc.add(GetCompaniesEvent(1));
            }
            else
              pushToast(translate("messages.couldNotAddCompany"));
          }
          else if (state is DeletedCompanyState) {
            if (state.deleteResult == "Deleted successfully.") {
              bloc.add(GetCompaniesEvent(1));

            } else
              pushToast(translate("messages.couldNotDeleteUser"));
          }
        },
        bloc: bloc,
        child: BlocBuilder<CompanyBloc, CompanyState>(
            bloc: bloc,
            builder: (context, CompanyState state) {
              return new _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final CompanyBloc bloc;
  final CompanyState state;

  _BuildUI({required this.bloc, required this.state});

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
                    translate("drawer.stations"),
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

                  Company? c = await showRecordDialog(
                      recordDialogStatus.Add, null);
                  if (c != null) {
                    widget.bloc.add(AddCompanyEvent(c));
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
            Radio(value: searchBy.Code, groupValue: selectedSearchMethod, onChanged: (searchBy? val){
              if (mounted) {
                setState(() {
                  selectedSearchMethod = val;
                });
              }
            }), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 0),),
            Text("By Code"),

            Padding(child:
            Radio(value: searchBy.Name, groupValue: selectedSearchMethod, onChanged: (searchBy? val){
              if (mounted) {
                setState(() {
                  selectedSearchMethod = val;
                });
              }
            }), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 0),),
            Text("By Name"),
          ],),

          Align(child: Padding(child: Text(translate("labels.totalCompanies")+": "+ totalCount.toString(), style: TextStyle(fontWeight: FontWeight.bold),),padding: EdgeInsetsDirectional.fromSTEB(25, 10, 0, 10),), alignment: AlignmentDirectional.topStart,),
          ((widget.state is InitCompanyState) || ((widget.state is LoadingCompanyState) && (!loadMore))) ?
          Center(child: CustomLoading(),) :
          Expanded(child:
          LayoutBuilder(builder: (context, constraints) =>
              RefreshIndicator(onRefresh: () async {
                currentPage = 1;
                companies = [];
                loadMore = false;
                  widget.bloc.add(GetCompaniesEvent(1));
              },
                  color: Colors.white,
                  backgroundColor: buttonColor1,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  child:


                  (companies.length == 0) ?
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
                            return CompanyWidget(company: companies[index],
                              onDelete: (){
                                showAlertDialog(context, translate("messages.deleteTitle"), translate("messages.deleteContent"),
                                        (){
                                      widget.bloc.add(DeleteCompanyEvent(companies[index]));
                                    }
                                );
                              },
                              onEdit: () async {
                                Company? u = await showRecordDialog(
                                    recordDialogStatus.Edit, companies[index]);
                                if (u != null) {
                                  if (u.id != null) {
                                    widget.bloc.add(UpdateCompanyEvent(u));
                                  }
                                }
                              },
                            );
                          },
                          itemCount: companies.length,
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
    if ((!(widget.state is LoadingCompanyState)) && (!loadMore)) {
      if (hasNext) {
        if (controller.position.pixels >
            (controller.position.maxScrollExtent * .75)) {
          setState(() {
            loadMore = true;
            currentPage = currentPage + 1;

              if ((searchTextController.text.isNotEmpty) && (selectedSearchMethod == searchBy.Name))
                widget.bloc.add(GetCompaniesByName(searchTextController.text, currentPage));
              else
                widget.bloc.add(GetCompaniesEvent(currentPage));
          });
        }
      }
    }
  }

  search()
  {

    companies = [];
    currentPage = 1;
    loadMore = false;
    hasNext = false;
    totalCount = 0;

    hideKeyboard(context);

    if (selectedSearchMethod == searchBy.Code)
    {

      if (searchTextController.text.isNotEmpty) {
        widget.bloc.add(GetCompanyByCode(searchTextController.text));
      }
      else
      {
        widget.bloc.add(GetCompaniesEvent(1));
      }
    }
    else {
      if (selectedSearchMethod == searchBy.Name)
      {
        if (searchTextController.text.isNotEmpty) {
          widget.bloc.add(GetCompaniesByName(searchTextController.text, 1));
        }
        else
        {
          widget.bloc.add(GetCompaniesEvent(1));
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Company?> showRecordDialog(
      recordDialogStatus dialogStatus, Company? company) async {
    Company? a = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return _recordDialog(bloc: widget.bloc, status: dialogStatus, company: company);
      },
    );
    return a;
  }
}

class _recordDialog extends StatefulWidget {
  final Company? company;
  final recordDialogStatus status;
  final CompanyBloc bloc;

  _recordDialog({required this.bloc, required this.status, this.company });

  @override
  _recordDialogState createState() => _recordDialogState();
}

class _recordDialogState extends State<_recordDialog> {
  TextEditingController arabicNameTextController = TextEditingController();
  TextEditingController englishNameTextController = TextEditingController();
  TextEditingController arabicAddressTextController = TextEditingController();
  TextEditingController englishAddressTextController = TextEditingController();
  TextEditingController idTextController = TextEditingController();
  TextEditingController codeTextController = TextEditingController();

  bool disabledValue = false;
  bool autoAddToFavorite = false;
  Company finalCompany = Company();

  Future<Group?> pickGroup() async {
    var res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return BlocProvider<CompanyBloc>.value(
                    value: widget.bloc,
                    child:
                    AlertDialog(
                      title: Text(translate("buttons.chooseGroups")),
                      content: setupGroupsPickerDialog(),
                      actions: [
                        Padding(
                          child: CustomButton(
                            title: translate("buttons.ok"),
                            onTap: () {
                              setState((){
                                Navigator.pop(context, selectedGroup);
                              });
                            },
                          ),
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        ),
                        Padding(
                            child: CustomButton(
                                title: translate("buttons.cancel"),
                                onTap: () {
                                  setState((){
                                    Navigator.pop(context);
                                  });
                                }),
                            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10))
                      ],
                    )
                );});
        });

    return res;
  }

  @override
  void initState() {
    if ((widget.status == recordDialogStatus.Edit) ||
        (widget.status == recordDialogStatus.View)) {
      finalCompany = widget.company!;
      arabicNameTextController.text = widget.company!.arabicName!;
      englishNameTextController.text = widget.company!.englishName!;
      arabicAddressTextController.text = widget.company!.arabicAddress!;
      englishAddressTextController.text = widget.company!.englishAddress!;
      idTextController.text = widget.company!.id!.toString();
      codeTextController.text = widget.company!.code!;
      disabledValue = widget.company!.disabled??false;
      autoAddToFavorite = widget.company!.autoAddToFavorite??false;
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
          body: Container(
              padding: EdgeInsetsDirectional.fromSTEB(SizeConfig().w(20),
                  SizeConfig().h(20), SizeConfig().w(20), SizeConfig().h(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: arabicNameTextController,
                    decoration: InputDecoration(
                        labelText: translate("columns.arabicName"),
                        hintText: translate("messages.pleaseEnter") +
                            translate("columns.arabicName")),
                  ),
                  TextField(
                    controller: englishNameTextController,
                    decoration: InputDecoration(
                        labelText: translate("columns.englishName"),
                        hintText: translate("messages.pleaseEnter") +
                            translate("columns.englishName")),
                  ),
                  TextField(
                    controller: arabicAddressTextController,
                    decoration: InputDecoration(
                        labelText: translate("columns.arabicAddress"),
                        hintText: translate("messages.pleaseEnter") +
                            translate("columns.arabicAddress")),
                  ),
                  TextField(
                    controller: englishAddressTextController,
                    decoration: InputDecoration(
                        labelText: translate("columns.englishAddress"),
                        hintText: translate("messages.pleaseEnter") +
                            translate("columns.englishAddress")),
                  ),
                  TextField(
                    controller: codeTextController,
                    decoration: InputDecoration(
                        labelText: translate("columns.code"),
                        hintText: translate("messages.pleaseEnter") +
                            translate("columns.code")),
                  ),

                  Row(
                    children: [
                      Text(translate("columns.disabled")),
                      Checkbox(
                          value: disabledValue,
                          onChanged: (value) {
                            if (mounted) {
                              setState(() {
                                disabledValue = value??false;
                              });
                            }
                          })
                    ],
                  ),

                  Row(
                    children: [
                      Text(translate("columns.autoAddToFavorite")),
                      Checkbox(
                          value: autoAddToFavorite,
                          onChanged: (value) {
                            if (mounted) {
                              setState(() {
                                autoAddToFavorite = value??false;
                              });
                            }
                          })
                    ],
                  ),

                  CustomButton(
                      backColor: (widget.company!.group != null) ? buttonColor1 : Colors.red,
                      titleColor: Colors.white,
                      borderColor: buttonColor1,
                      title: (widget.company!.group != null) ? ((widget.status == recordDialogStatus.Edit) ||
                          (widget.status == recordDialogStatus.View)) ? (languageCode == "ar") ? widget.company!.group!.arabicName??"" : widget.company!.group?.englishName??"" : translate("buttons.selectGroup") : translate("buttons.selectGroup"),
                      onTap: () async {
                        selectedGroup = widget.company!.group;
                        await pickGroup();
                        setState(() {

                          widget.company!.group = selectedGroup;
                          if (selectedGroup != null)
                            widget.company!.groupId = selectedGroup!.id;

                        });
                      })
                ],
              )),
          appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      if (widget.status == recordDialogStatus.Add) {
                        finalCompany.id = -1;
                      }
                      finalCompany.arabicName = arabicNameTextController.text;
                      finalCompany.englishName = englishNameTextController.text;
                      finalCompany.arabicAddress = arabicAddressTextController.text;
                      finalCompany.englishAddress = englishAddressTextController.text;
                      finalCompany.code = codeTextController.text;
                      finalCompany.disabled = disabledValue;
                      finalCompany.autoAddToFavorite = autoAddToFavorite;
                      if (selectedGroup != null)
                      {
                        finalCompany.groupId = selectedGroup!.id;
                        finalCompany.group = selectedGroup;
                      }
                      Navigator.pop(context, finalCompany);
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



Widget setupGroupsPickerDialog() {

  return
    BlocBuilder<CompanyBloc, CompanyState>(builder:
        (context, state){

      final bloc = BlocProvider.of<CompanyBloc>(context);

      return GroupsWidget(
        selectedGroup: selectedGroup,
        state: state,
        bloc: bloc,
      );
    });

}

class GroupsWidget extends StatefulWidget {
  final Group? selectedGroup;
  final CompanyState state;
  final CompanyBloc bloc;

  const GroupsWidget(
      {Key? key, this.selectedGroup, required this.state, required this.bloc})
      : super(key: key);

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {

  void _groupsScrollListener() {
    print(groupsController.position.extentAfter);
    if ((!(widget.state is LoadingCompanyState)) && (!groupsLoadMore)) {
      if (groupsHasNext) {
        if (groupsController.position.pixels >
            (groupsController.position.maxScrollExtent * .75)) {
          setState(() {
            groupsLoadMore = true;
            currentGroupsPage = currentGroupsPage + 1;
            widget.bloc.add(GetGroupsEvent(currentGroupsPage));

          });
        }
      }
    }
  }


  @override
  void initState() {
    groupsController = ScrollController()..addListener(_groupsScrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child:

      (widget.state is LoadingCompanyState) ?
      Center(child: CustomLoading(),) :
      ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: groupsController,
        shrinkWrap: true,
        itemCount: groups.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Checkbox(
                  value: (selectedGroup != null ) ? (selectedGroup!.id == groups[index].id) : false,
                  onChanged: (x) {
                    setState(() {
                      if (selectedGroup == null)
                        selectedGroup = groups[index];
                      else {
                        if (selectedGroup == groups[index])
                          selectedGroup = null;
                        else
                          selectedGroup = groups[index];
                      }
                    });
                  }),
              InkWell(
                child: SizedBox(
                  height: 25,
                  width: 180,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      (languageCode == "en")
                          ? groups[index].englishName ?? ""
                          : groups[index].arabicName ?? "",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                    setState(() {
                      if (selectedGroup == null)
                        selectedGroup = groups[index];
                      else {
                        if (selectedGroup == groups[index])
                          selectedGroup = null;
                        else
                          selectedGroup = groups[index];
                      }
                    });
                },
              )
            ],
          );
        },
      ),
    );
  }
}
