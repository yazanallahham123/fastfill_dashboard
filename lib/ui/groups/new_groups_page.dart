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
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../common_widgets/app_widgets/group_widget.dart';
import '../../helper/toast.dart';
import '../../model/group/group.dart';
import '../../utils/misc.dart';

class NewGroupsPage extends StatefulWidget {
  static const route = "/new_users_page";

  @override
  State<NewGroupsPage> createState() => _NewGroupsPageState();
}

final ApiClient mClient = ApiClient(certificateClient());

List<Group> groups = [];
ScrollController controller = ScrollController();
bool hasNext = false;
int currentPage = 1;
bool loadMore = false;
int totalCount = 0;
TextEditingController searchTextController = TextEditingController();


class _NewGroupsPageState extends State<NewGroupsPage> {

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
            groups = [];
            currentPage = 1;
            loadMore = false;
            hasNext = false;
            bloc.add(GetGroupsEvent(1));
          }
          else if (state is ErrorCompanyState) {
            pushToast(state.error);
            if (mounted) {
              setState(() {
                groups = [];
                currentPage = 1;
                loadMore = false;
                hasNext = false;
                totalCount = 0;
              });
            }
          }
          else if (state is GotGroupsState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                  if (state.groupsWithPagination.paginationInfo != null)
                  {
                    if (state.groupsWithPagination.paginationInfo!.pageNo == 1)
                      groups = [];

                    hasNext = state.groupsWithPagination.paginationInfo!.hasNext!;
                    totalCount = state.groupsWithPagination.paginationInfo!.totalItems!;
                  }
                  else
                    hasNext = false;

                  if (state.groupsWithPagination.groups != null) {
                    groups.addAll(state.groupsWithPagination.groups!);
                  }
                  else {
                    hasNext = false;
                  }
              });
            }
          }
          else if (state is UpdatedGroupState) {
            if (state.updateResult == "Updated successfully.")
            {
              bloc.add(GetGroupsEvent(1));
            }
            else
              pushToast(translate("messages.couldNotUpdateCompany"));
          }
          else if (state is GotGroupsByNameState) {
            if (mounted) {
              setState(() {
                loadMore = false;
                  if (state.groupsWithPagination.paginationInfo != null)
                  {
                    hasNext = state.groupsWithPagination.paginationInfo!.hasNext!;
                    totalCount = state.groupsWithPagination.paginationInfo!.totalItems!;
                  }
                  else
                    hasNext = false;

                  if (state.groupsWithPagination.groups != null) {
                    groups.addAll(state.groupsWithPagination.groups!);
                  }
                  else {
                    hasNext = false;
                  }
              });
            }
          }
          else if (state is AddedGroupState) {
            if (state.addResult == "Added successfully.")
            {
              bloc.add(GetGroupsEvent(1));
            }
            else
              pushToast(translate("messages.couldNotAddCompany"));
          }
          else if (state is DeletedGroupState) {
            if (state.deleteResult == "Deleted successfully.") {
              bloc.add(GetGroupsEvent(1));

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
                    translate("drawer.groups"),
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

                  Group? c = await showRecordDialog(
                      recordDialogStatus.Add, null);
                  if (c != null) {
                    widget.bloc.add(AddGroupEvent(c));
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

          Align(child: Padding(child: Text(translate("labels.totalGroups")+": "+ totalCount.toString(), style: TextStyle(fontWeight: FontWeight.bold),),padding: EdgeInsetsDirectional.fromSTEB(25, 10, 0, 10),), alignment: AlignmentDirectional.topStart,),
          ((widget.state is InitCompanyState) || ((widget.state is LoadingCompanyState) && (!loadMore))) ?
          Center(child: CustomLoading(),) :
          Expanded(child:
          LayoutBuilder(builder: (context, constraints) =>
              RefreshIndicator(onRefresh: () async {
                currentPage = 1;
                groups = [];
                loadMore = false;
                widget.bloc.add(GetGroupsEvent(1));
              },
                  color: Colors.white,
                  backgroundColor: buttonColor1,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  child:


                  (groups.length == 0) ?
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
                            return GroupWidget(group: groups[index],
                              onDelete: (){
                                showAlertDialog(context, translate("messages.deleteTitle"), translate("messages.deleteContent"),
                                        (){
                                      widget.bloc.add(DeleteGroupEvent(groups[index]));
                                    }
                                );
                              },
                              onEdit: () async {
                                Group? u = await showRecordDialog(
                                    recordDialogStatus.Edit, groups[index]);
                                if (u != null) {
                                  if (u.id != null) {
                                    widget.bloc.add(UpdateGroupEvent(u));
                                  }
                                }
                              },
                            );
                          },
                          itemCount: groups.length,
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

            if ((searchTextController.text.isNotEmpty))
              widget.bloc.add(GetGroupsByName(searchTextController.text, currentPage));
            else
              widget.bloc.add(GetGroupsEvent(currentPage));
          });
        }
      }
    }
  }

  search()
  {

    groups = [];
    currentPage = 1;
    loadMore = false;
    hasNext = false;
    totalCount = 0;

    hideKeyboard(context);

 {

        if (searchTextController.text.isNotEmpty) {
          widget.bloc.add(GetGroupsByName(searchTextController.text, 1));
        }
        else
        {
          widget.bloc.add(GetGroupsEvent(1));
        }

    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Group?> showRecordDialog(
      recordDialogStatus dialogStatus, Group? group) async {
    Group? a = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return _recordDialog(status: dialogStatus, group: group);
      },
    );

    return a;
  }

}

class _recordDialog extends StatefulWidget {
  final Group? group;
  final recordDialogStatus status;
  _recordDialog({required this.status, this.group });

  @override
  _recordDialogState createState() => _recordDialogState();
}

class _recordDialogState extends State<_recordDialog> {
  TextEditingController arabicNameTextController = TextEditingController();
  TextEditingController englishNameTextController = TextEditingController();
  TextEditingController idTextController = TextEditingController();

  Group finalGroup = Group();

  @override
  void initState() {
    if ((widget.status == recordDialogStatus.Edit) ||
        (widget.status == recordDialogStatus.View)) {
      finalGroup = widget.group!;
      arabicNameTextController.text = widget.group!.arabicName!;
      englishNameTextController.text = widget.group!.englishName!;
      idTextController.text = widget.group!.id!.toString();
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

                ],
              )),
          appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      if (widget.status == recordDialogStatus.Add) {
                        finalGroup.id = -1;
                      }
                      finalGroup.arabicName = arabicNameTextController.text;
                      finalGroup.englishName = englishNameTextController.text;
                      Navigator.pop(context, finalGroup);
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
