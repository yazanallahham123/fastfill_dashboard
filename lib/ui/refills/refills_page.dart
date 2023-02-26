
import 'package:fastfilldashboard/bloc/users/bloc.dart';
import 'package:fastfilldashboard/bloc/users/event.dart';
import 'package:fastfilldashboard/bloc/users/state.dart';
import 'package:fastfilldashboard/common_widgets/app_widgets/refill_widget.dart';
import 'package:fastfilldashboard/helper/app_colors.dart';
import 'package:fastfilldashboard/helper/enums.dart';
import 'package:fastfilldashboard/helper/size_config.dart';
import 'package:fastfilldashboard/main.dart';
import 'package:fastfilldashboard/model/refills/user_refill_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../common_widgets/buttons/custom_button.dart';
import '../../common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import '../../common_widgets/custom_text_field_widgets/methods.dart';
import '../../helper/const_styles.dart';
import '../../helper/toast.dart';
import '../../model/refills/refill_source.dart';
import '../../model/refills/user_refill.dart';
import '../../utils/misc.dart';

bool hasNext = false;
int currentPage = 1;
bool loadMore = false;

final phoneController = TextEditingController();
DateTime? fromDate;
DateTime? toDate;
List<UserRefill> refills = [];
ScrollController controller = ScrollController();
int? totalCount = 0;
double? totalAmount = 0;
int? totalSuccessCount = 0;
int? totalFailCount = 0;
double? totalSuccessAmount = 0;
double? totalFailAmount = 0;

bool expandState = true;
List<RefillSource> refillSources = [];
List<RefillSource>? selectedRefillSrcs = [];
refillStatus? selectedRefillStatusMethod = refillStatus.All;

class RefillsPage extends StatefulWidget {
  static const route = "/refills_page";
  const RefillsPage();

  @override
  State<RefillsPage> createState() => _RefillsPageState();
}

class _RefillsPageState extends State<RefillsPage> {
  @override
  void initState() {
    refillSources = [];
    refillSources.add(RefillSource(id: 0, arabicName: "تطبيق سايبرتك", englishName: "Sybertech App"));
    refillSources.add(RefillSource(id: 1, arabicName: "واجهة سايبرتك", englishName: "Sybertech Gateway"));
    refillSources.add(RefillSource(id: 2, arabicName: "بشرى باي", englishName: "Bushra Pay"));
    refillSources.add(RefillSource(id: 3, arabicName: "بنك الخرطوم", englishName: "BOK"));
    refillSources.add(RefillSource(id: 4, arabicName: "بنك فيصل", englishName: "Faisal Bank"));
    refillSources.add(RefillSource(id: 100, arabicName: "يدوي", englishName: "Manual"));
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
          if (state is ErrorUserState) {
            if (mounted) {
              setState(() {
                refills = [];
              });
            }

            pushToast(state.error);
          }
          else if (state is GotRefillsState) {

            if (mounted) {
              setState(() {

                  if (state.userRefills.paginationInfo != null)
                  {
                    if (state.userRefills.paginationInfo!.pageNo == 1)
                      refills = [];


                    hasNext = state.userRefills.paginationInfo!.hasNext!;
                  }
                  else
                    hasNext = false;

                  if (state.userRefills.refills != null) {
                    if (state.userRefills.refills!
                        .length > 0) {
                      refills.addAll(
                          state.userRefills
                              .refills!);
                    }
                    else
                      hasNext = false;
                  }
                  else
                    hasNext = false;

                  totalCount = state.userRefills.totalCount;
                  totalAmount = state.userRefills.totalAmount;
                  totalSuccessCount = state.userRefills.totalSuccessCount;
                  totalFailCount = state.userRefills.totalFailCount;
                  totalSuccessAmount = state.userRefills.totalSuccessAmount;
                  totalFailAmount = state.userRefills.totalFailAmount;

              });
            }

          }
        },
        bloc: bloc,
        child: BlocBuilder<UserBloc, UserState>(
            bloc: bloc,
            builder: (context, UserState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final UserBloc bloc;
  final UserState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

class _BuildUIState extends State<_BuildUI> {
  final phoneNode = FocusNode();
  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
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

    String? pn = "";
      if ((phoneController.text.length == 9) ||
          (phoneController.text.length == 10)) {
        if ((phoneController.text.length == 10) &&
            (phoneController.text.substring(0, 1) == "0")) {
          pn = phoneController.text
              .substring(1, phoneController.text.length);
        } else {
          if (phoneController.text.length == 9) {
            pn = phoneController.text;
          }
        }
      }

    if (pn.isEmpty)
      pn = null;

    bool? restatus = null;
    if (selectedRefillStatusMethod == refillStatus.All)
      restatus = null;
    if (selectedRefillStatusMethod == refillStatus.Success)
      restatus = true;
    if (selectedRefillStatusMethod == refillStatus.Fail)
      restatus = false;

    UserRefillFilter userRefillFilter = UserRefillFilter(
        mobileNumber: pn,
        fromDate: fromDate,
        toDate: toDate,
        status: restatus,
        refillSources: selectedRefillSrcs!.map((x) => x.id!).toList(),
        page: 1, pageSize: 25);

    widget.bloc.add(GetRefillsEvent(userRefillFilter));

    setState(() {
      expandState = false;
    });

          });
        }
      }
    }
  }


  generateReport()
  {

    refills = [];

    String? pn = "";
    if ((phoneController.text.length == 9) ||
        (phoneController.text.length == 10)) {
      if ((phoneController.text.length == 10) &&
          (phoneController.text.substring(0, 1) == "0")) {
        pn = phoneController.text
            .substring(1, phoneController.text.length);
      } else {
        if (phoneController.text.length == 9) {
          pn = phoneController.text;
        }
      }
    }

    if (pn.isEmpty)
      pn = null;

    bool? restatus = null;
    if (selectedRefillStatusMethod == refillStatus.All)
      restatus = null;
    if (selectedRefillStatusMethod == refillStatus.Success)
      restatus = true;
    if (selectedRefillStatusMethod == refillStatus.Fail)
      restatus = false;

    UserRefillFilter userRefillFilter = UserRefillFilter(
        mobileNumber: pn,
        fromDate: fromDate,
        toDate: toDate,
        status: restatus,
        refillSources: selectedRefillSrcs!.map((x) => x.id!).toList(),
        page: 1, pageSize: 25);

    widget.bloc.add(GetRefillsEvent(userRefillFilter));

    setState(() {
      expandState = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate("drawer.refills")),
          automaticallyImplyLeading: false,
        ),
        body:


        (widget.state is LoadingUserState)
            ? Container(child: CustomLoading())
            :

        Column(
                children: [

                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState((){
                        expandState = !isExpanded;
                      });
                    },
                    children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: expandState,
                      body: Column(children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: SizeConfig().w(15),
                            end: SizeConfig().w(15)),
                        child: CustomTextFieldWidget(
                          controller: phoneController,
                          focusNode: phoneNode,
                          validator: validateMobile,
                          hintText: translate("labels.phoneNumber"),
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,),
                      ),

                      Row(children: [
                      Expanded(child: Padding(child:
                      CustomButton(

                        onTap: (){
                          DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2022, 1, 1),
                            maxTime: DateTime(2099, 12, 31),
                            theme: DatePickerTheme(
                                headerColor: buttonColor1,
                                backgroundColor: backgroundColor1,
                                itemStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16)),
                            onChanged: (date) {
                              print('change $date in time zone ' +
                                  date.timeZoneOffset.inHours
                                      .toString());


                            }, onConfirm: (date) {

                              if (mounted) {
                                setState(() {
                                  fromDate = date;
                                });
                              }

                            },);

                        }, title: (fromDate!=null)?DateFormat("yyyy-MM-dd","en_US").format(fromDate!):translate("buttons.fromDate"),)

                        ,padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),)),
                        (fromDate != null) ? IconButton(onPressed: (){
                          if (mounted) {
                            setState(() {
                              fromDate = null;
                            });
                          }

                        }, icon: Icon(Icons.cancel)) : Container()
                      ],),

                      Row(children: [
                        Expanded(child:
                      Padding(child:
                      CustomButton(

                        onTap: (){
                          DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2022, 1, 1),
                            maxTime: DateTime(2099, 12, 31),
                            theme: DatePickerTheme(
                                headerColor: buttonColor1,
                                backgroundColor: backgroundColor1,
                                itemStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                doneStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16)),
                            onChanged: (date) {
                              print('change $date in time zone ' +
                                  date.timeZoneOffset.inHours
                                      .toString());


                            }, onConfirm: (date) {

                              if (mounted) {
                                setState(() {
                                  toDate = date;
                                });
                              }

                            },);

                        }, title: (toDate!=null)?DateFormat("yyyy-MM-dd","en_US").format(toDate!):translate("buttons.toDate"),)

                        ,padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),)),
                        (toDate != null) ? IconButton(onPressed: (){
                          if (mounted) {
                            setState(() {
                              toDate = null;
                            });
                          }
                        }, icon: Icon(Icons.cancel)) : Container()
                      ]),


                        Padding(child:
                        CustomButton(

                            onTap: (){

                              pickRefillSources(selectedRefillSrcs!).then((x){
                                setState(() {
                                  selectedRefillSrcs = x;
                                });
                              });
                            }, title: translate("buttons.chooseSource"))

                          ,padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
                        (selectedRefillSrcs!.length > 0) ?
                        Container(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 2, 5, 2),

                            height: 40,
                            child:
                        ListView(
                          scrollDirection: Axis.horizontal,
                          children: selectedRefillSrcs!.map((x) =>
                            InkResponse(child:
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: radiusAll14,
                                    color: buttonColor1
                                ),
                              margin: EdgeInsetsDirectional.fromSTEB(5, 2, 5, 2),
                                padding: EdgeInsetsDirectional.fromSTEB(5, 2, 5, 2),
                                child:
                            Row(children: [
                              Icon(Icons.remove_circle),

                              Text((languageCode == "en") ? x.englishName! : x.arabicName!)

                        ],)),onTap: (){
                              setState(() {
                                selectedRefillSrcs!.remove(x);
                              });
                            },)

                        ).toList(),)) : Container(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Radio(value: refillStatus.All, groupValue: selectedRefillStatusMethod, onChanged: (refillStatus? val){
                            if (mounted) {
                              setState(() {
                                selectedRefillStatusMethod = val;
                              });
                            }
                          }),
                          Text(translate("labels.allStatus")),

                          Radio(value: refillStatus.Success, groupValue: selectedRefillStatusMethod, onChanged: (refillStatus? val){
                            if (mounted) {
                              setState(() {
                                selectedRefillStatusMethod = val;
                              });
                            }
                          }),
                          Text(translate("labels.successStatus")),

                          Radio(value: refillStatus.Fail, groupValue: selectedRefillStatusMethod, onChanged: (refillStatus? val){
                            if (mounted) {
                              setState(() {
                                selectedRefillStatusMethod = val;
                              });
                            }
                          }),
                          Text(translate("labels.failStatus"))

                        ],),


                      if (widget.state is LoadingUserState)
                        Padding(
                          child: const CustomLoading(),
                          padding: EdgeInsetsDirectional.only(
                              top: SizeConfig().h(62),
                              bottom: SizeConfig().h(62)),
                        )
                      else
                        Column(
                          children: [
                            Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: SizeConfig().w(10),
                                    end: SizeConfig().w(10),
                                    bottom: SizeConfig().h(10),
                                    top: SizeConfig().h(10)),
                                child: CustomButton(
                                    backColor: buttonColor1,
                                    titleColor: Colors.white,
                                    borderColor: buttonColor1,
                                    title: translate("buttons.generate"),
                                    onTap: () {
                                      generateReport();
                                    })),
                          ],
                        ),


                    ],), headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(title: Text(translate("labels.filters")),);
                    },
                    ),
                  ],),

                  Container(
                      color: Colors.greenAccent,
                      child:
                  Column(children: [
                    Align(child: Padding(child: Text(translate("labels.all")+": "+ totalCount.toString()+" - "+ formatter.format(totalAmount)+" "+translate("labels.sdg"), style: TextStyle(fontWeight: FontWeight.bold),),padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),), alignment: AlignmentDirectional.topStart,),
                    Align(child: Padding(child: Text(translate("labels.success")+": "+ totalSuccessCount.toString()+" - "+ formatter.format(totalSuccessAmount)+" "+translate("labels.sdg"), style: TextStyle(fontWeight: FontWeight.bold),),padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),), alignment: AlignmentDirectional.topStart,),
                    Align(child: Padding(child: Text(translate("labels.fail")+": "+ totalFailCount.toString()+" - "+ formatter.format(totalFailAmount)+" "+translate("labels.sdg"), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),), alignment: AlignmentDirectional.topStart,),

                  ],)),


                  //Align(child: Padding(child: Text(translate("labels.totalUsers")+": "+ totalCount.toString(), style: TextStyle(fontWeight: FontWeight.bold),),padding: EdgeInsetsDirectional.fromSTEB(25, 10, 0, 10),), alignment: AlignmentDirectional.topStart,),

                  Expanded(child:

    RefreshIndicator(
    onRefresh: () async {
      generateReport();
    },
    color: Colors.white,
    backgroundColor: buttonColor1,
    triggerMode: RefreshIndicatorTriggerMode
        .anywhere,
    child:
                  ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    controller: controller,
                    itemBuilder: (context, index)
                    {
                      return RefillWidget(userRefill: refills[index]);
                    },
                    itemCount: refills.length,
                  ))

                  ),

                ])

    );

  }


  Future<List<RefillSource>> pickRefillSources(List<RefillSource> selectedRefillSources) async {
    var res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(translate("buttons.chooseSource")),
            content: setupRefillSourcesPickerDialog(refillSources, selectedRefillSources),
            actions: [
              Padding(child:
              CustomButton(title: translate("buttons.ok"), onTap: (){
                Navigator.pop(context, selectedRefillSources);
              },), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
          Padding(child:
          CustomButton(title: translate("buttons.cancel"), onTap: (){
                Navigator.pop(context);
              }),padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10))
            ],
          );
        });

    return res;
  }

  @override
  void dispose() {
    super.dispose();
  }


}


Widget setupRefillSourcesPickerDialog(List<RefillSource> refillSources, List<RefillSource> selectedList) {
  return RefillSourcesWidget(refillSources: refillSources, selectedRefillSources: selectedList,);
}

class RefillSourcesWidget extends StatefulWidget{
  final List<RefillSource> refillSources;
  final List<RefillSource> selectedRefillSources;

  const RefillSourcesWidget({Key? key, required this.refillSources, required this.selectedRefillSources})
      : super(key: key);

  @override
  State<RefillSourcesWidget> createState() => _RefillSourcesWidgetState();
}

class _RefillSourcesWidgetState extends State<RefillSourcesWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child:
      ListView.builder(
        shrinkWrap: true,
        itemCount: widget.refillSources.length,
        itemBuilder: (BuildContext context, int index) {
          return
            Row(children: [
              Checkbox(value: (widget.selectedRefillSources.contains(widget.refillSources[index])), onChanged: (x) {
                setState(() {
                  if (widget.selectedRefillSources.contains(widget.refillSources[index]))
                  {
                    widget.selectedRefillSources.remove(widget.refillSources[index]);
                  }
                  else
                  {
                    widget.selectedRefillSources.add(widget.refillSources[index]);
                  }
                });
              }),
              InkWell(child:
              Text((languageCode == "en") ? widget.refillSources[index].englishName??"" :  widget.refillSources[index].arabicName??"" ),
              onTap: (){
                setState(() {
                  if (widget.selectedRefillSources.contains(widget.refillSources[index]))
                  {
                    widget.selectedRefillSources.remove(widget.refillSources[index]);
                  }
                  else
                  {
                    widget.selectedRefillSources.add(widget.refillSources[index]);
                  }
                });
              },
              ),
            ],);
        },
      ),
    );
  }


}
