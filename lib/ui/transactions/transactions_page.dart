import 'package:fastfilldashboard/bloc/users/bloc.dart';
import 'package:fastfilldashboard/bloc/users/event.dart';
import 'package:fastfilldashboard/bloc/users/state.dart';
import 'package:fastfilldashboard/helper/app_colors.dart';
import 'package:fastfilldashboard/helper/size_config.dart';
import 'package:fastfilldashboard/main.dart';
import 'package:fastfilldashboard/model/company/payment_transaction_result.dart';
import 'package:fastfilldashboard/ui/administrators/new_administrators_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../common_widgets/app_widgets/payment_transaction_result_widget.dart';
import '../../common_widgets/buttons/custom_button.dart';
import '../../common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import '../../common_widgets/custom_text_field_widgets/methods.dart';
import '../../helper/const_styles.dart';
import '../../helper/toast.dart';
import '../../model/company/company.dart';
import '../../model/user/payment_transaction_results_filter.dart';
import '../../utils/misc.dart';

final phoneController = TextEditingController();
DateTime? fromDate;
DateTime? toDate;
ScrollController controller = ScrollController();
int? totalCount = 0;
double? totalAmount = 0;
double? totalFastfill = 0;
bool expandState = true;
List<Company> companies = [];
List<Company> selectedCompanies = [];
List<PaymentTransactionResult> paymentTransactionResults = [];
ScrollController companiesController = ScrollController();
bool companiesLoadMore = false;
bool companiesHasNext = false;
int currentCompaniesPage = 1;

class TransactionsPage extends StatefulWidget {
  static const route = "/transactions_page";
  const TransactionsPage();

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
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
            companiesLoadMore = true;
            companies = [];
            companiesHasNext = false;
            bloc.add(GetCompaniesEvent(1));
          } else if (state is GotCompaniesState) {

            //companies = state.companiesWithPagination.companies ?? [];


            if (mounted) {
              setState(() {
                companiesLoadMore = false;
                  if (state.companiesWithPagination.paginationInfo != null)
                  {
                    if (state.companiesWithPagination.paginationInfo!.pageNo == 1)
                      companies = [];
                    companiesHasNext = state.companiesWithPagination.paginationInfo!.hasNext!;
                  }
                  else
                    companiesHasNext = false;

                  if (state.companiesWithPagination.companies != null) {
                    companies.addAll(state.companiesWithPagination.companies!);
                  }
                  else {
                    companiesHasNext = false;
                  }
              });
            }

          }
          else if (state is ErrorUserState) {
            if (mounted) {
              setState(() {
                paymentTransactionResults = [];
              });
            }

            pushToast(state.error);
          } else if (state is GotPaymentTransactionResultsState) {

            if (mounted) {
              setState(() {
                if (state.paymentTransactionResults.paginationInfo!.pageNo ==
                    1) {
                  paymentTransactionResults = [];
                }
                  if (state.paymentTransactionResults.paginationInfo != null) {
                    hasNext =
                    state.paymentTransactionResults.paginationInfo!.hasNext!;
                  }
                  else
                    hasNext = false;

                  if (state.paymentTransactionResults
                      .paymentTransactionResults != null) {
                    if (state.paymentTransactionResults
                        .paymentTransactionResults!
                        .length > 0) {
                      paymentTransactionResults.addAll(
                          state.paymentTransactionResults
                              .paymentTransactionResults!);
                    }
                    else
                      hasNext = false;
                  }
                  else
                    hasNext = false;


                  totalCount = state.paymentTransactionResults.totalCount;
                  totalAmount = state.paymentTransactionResults.totalAmount;
                  totalFastfill = state.paymentTransactionResults.totalFastfill;
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
              if ((phoneController
                  .text.length ==
                  9) ||
                  (phoneController
                      .text.length ==
                      10)) {
                if ((phoneController
                    .text.length ==
                    10) &&
                    (phoneController.text
                        .substring(
                        0, 1) ==
                        "0")) {
                  pn = phoneController.text
                      .substring(
                      1,
                      phoneController
                          .text.length);
                } else {
                  if (phoneController
                      .text.length ==
                      9) {
                    pn = phoneController.text;
                  }
                }
              }

            if (pn.isEmpty) pn = null;

            PaymentTransactionResultsFilter
            paymentTransactionsResultsFilter =
            PaymentTransactionResultsFilter(
                mobileNumber: pn,
                fromDate: fromDate,
                toDate: toDate,
                companies:
                selectedCompanies
                    .map((x) => x.id!)
                    .toList(),
                page: currentPage,
                pageSize: 25);

            widget.bloc.add(
                GetPaymentTransactionResultsEvent(
                    paymentTransactionsResultsFilter));

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

    paymentTransactionResults = [];

    String? pn = "";
    if ((phoneController
        .text.length ==
        9) ||
        (phoneController
            .text.length ==
            10)) {
      if ((phoneController
          .text.length ==
          10) &&
          (phoneController.text
              .substring(
              0, 1) ==
              "0")) {
        pn = phoneController.text
            .substring(
            1,
            phoneController
                .text.length);
      } else {
        if (phoneController
            .text.length ==
            9) {
          pn = phoneController.text;
        }
      }
    }


    if (pn.isEmpty) pn = null;

    PaymentTransactionResultsFilter
    paymentTransactionsResultsFilter =
    PaymentTransactionResultsFilter(
        mobileNumber: pn,
        fromDate: fromDate,
        toDate: toDate,
        companies:
        selectedCompanies
            .map((x) => x.id!)
            .toList(),
        page: 1,
        pageSize: 25);

    widget.bloc.add(
        GetPaymentTransactionResultsEvent(
            paymentTransactionsResultsFilter));

    setState(() {
      expandState = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate("drawer.transactions")),
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
                        setState(() {
                          expandState = !isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          canTapOnHeader: true,
                          isExpanded: expandState,
                          body: Column(
                            children: [
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
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    child: CustomButton(
                                      onTap: () {
                                        DatePicker.showDatePicker(
                                          context,
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
                                          },
                                          onConfirm: (date) {
                                            if (mounted) {
                                              setState(() {
                                                fromDate = date;
                                              });
                                            }
                                          },
                                        );
                                      },
                                      title: (fromDate != null)
                                          ? DateFormat("yyyy-MM-dd", "en_US")
                                              .format(fromDate!)
                                          : translate("buttons.fromDate"),
                                    ),
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 10),
                                  )),
                                  (fromDate != null)
                                      ? IconButton(
                                          onPressed: () {
                                            if (mounted) {
                                              setState(() {
                                                fromDate = null;
                                              });
                                            }
                                          },
                                          icon: Icon(Icons.cancel))
                                      : Container()
                                ],
                              ),
                              Row(children: [
                                Expanded(
                                    child: Padding(
                                  child: CustomButton(
                                    onTap: () {
                                      DatePicker.showDatePicker(
                                        context,
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
                                        },
                                        onConfirm: (date) {
                                          if (mounted) {
                                            setState(() {
                                              toDate = date;
                                            });
                                          }
                                        },
                                      );
                                    },
                                    title: (toDate != null)
                                        ? DateFormat("yyyy-MM-dd", "en_US")
                                            .format(toDate!)
                                        : translate("buttons.toDate"),
                                  ),
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                )),
                                (toDate != null)
                                    ? IconButton(
                                        onPressed: () {
                                          if (mounted) {
                                            setState(() {
                                              toDate = null;
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.cancel))
                                    : Container()
                              ]),
                              Padding(
                                child: CustomButton(
                                    onTap: () {
                                      pickCompanies(selectedCompanies)
                                          .then((x) {
                                        setState(() {
                                          selectedCompanies = x;
                                        });
                                      });
                                    },
                                    title:
                                        translate("buttons.chooseCompanies")),
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                              ),
                              (selectedCompanies.length > 0)
                                  ? Container(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 2, 5, 2),
                                      height: 40,
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: selectedCompanies
                                            .map((x) => InkResponse(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              radiusAll14,
                                                          color: buttonColor1),
                                                      margin:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 2, 5, 2),
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 2, 5, 2),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .remove_circle),
                                                          Text((languageCode ==
                                                                  "en")
                                                              ? x.englishName!
                                                              : x.arabicName!)
                                                        ],
                                                      )),
                                                  onTap: () {
                                                    setState(() {
                                                      selectedCompanies
                                                          .remove(x);
                                                    });
                                                  },
                                                ))
                                            .toList(),
                                      ))
                                  : Container(),
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
                                            title:
                                                translate("buttons.generate"),
                                            onTap: () {
                                              generateReport();
                                            })),
                                  ],
                                ),
                            ],
                          ),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(translate("labels.filters")),
                            );
                          },
                        ),
                      ],
                    ),

                    Container(
                        color: Colors.greenAccent,
                        child: Column(
                          children: [
                            Align(
                              child: Padding(
                                child: Text(
                                  translate("labels.totalCount") +
                                      ": " +
                                      totalCount.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 0, 0),
                              ),
                              alignment: AlignmentDirectional.topStart,
                            ),
                            Align(
                              child: Padding(
                                child: Text(
                                  translate("labels.totalAmount") +
                                      ": " +
                                      formatter.format(totalAmount) +
                                      " " +
                                      translate("labels.sdg"),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              ),
                              alignment: AlignmentDirectional.topStart,
                            ),
                            Align(
                              child: Padding(
                                child: Text(
                                  translate("labels.totalFastfill") +
                                      ": " +
                                      formatter.format(totalFastfill) +
                                      " " +
                                      translate("labels.sdg"),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 0, 10),
                              ),
                              alignment: AlignmentDirectional.topStart,
                            ),
                          ],
                        )),

                  Expanded(
                            child:
                                    RefreshIndicator(
                                        onRefresh: () async {
                                          generateReport();
                                        },
                                        color: Colors.white,
                                        backgroundColor: buttonColor1,
                                        triggerMode: RefreshIndicatorTriggerMode
                                            .anywhere,
                                        child: ListView.builder(
                                                      physics:
                                                          AlwaysScrollableScrollPhysics(),
                                                      controller: controller,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return PaymentTransactionResultWidget(
                                                            paymentTransactionResult:
                                                                paymentTransactionResults[
                                                                    index]);
                                                      },
                                                      itemCount:
                                                          paymentTransactionResults
                                                              .length,
                                                    ),
                                              )),
                  ])

        );
  }

  Future<List<Company>> pickCompanies(List<Company> selectedCompanies) async {
    var res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocProvider<UserBloc>.value(
            value: widget.bloc,
            child:
            AlertDialog(
              title: Text(translate("buttons.chooseCompanies")),
              content: setupCompaniesPickerDialog(selectedCompanies),
              actions: [
                Padding(
                  child: CustomButton(
                    title: translate("buttons.ok"),
                    onTap: () {
                      Navigator.pop(context, selectedCompanies);
                    },
                  ),
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                ),
                Padding(
                    child: CustomButton(
                        title: translate("buttons.cancel"),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10))
              ],
            )
          );



        });

    return res;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

Widget setupCompaniesPickerDialog(
    List<Company> selectedList) {

  return 
    BlocBuilder<UserBloc, UserState>(builder:
    (context, state){

      final bloc = BlocProvider.of<UserBloc>(context);

    return CompaniesWidget(
        selectedCompanies: selectedList,
        state: state,
        bloc: bloc,
      );
    });
  
}

class CompaniesWidget extends StatefulWidget {
  final List<Company> selectedCompanies;
  final UserState state;
  final UserBloc bloc;

  const CompaniesWidget(
      {Key? key, required this.selectedCompanies, required this.state, required this.bloc})
      : super(key: key);

  @override
  State<CompaniesWidget> createState() => _CompaniesWidgetState();
}

class _CompaniesWidgetState extends State<CompaniesWidget> {

  void _companiesScrollListener() {
    print(companiesController.position.extentAfter);
    if ((!(widget.state is LoadingUserState)) && (!companiesLoadMore)) {
      if (companiesHasNext) {
        if (companiesController.position.pixels >
            (companiesController.position.maxScrollExtent * .75)) {
          setState(() {
            companiesLoadMore = true;
            currentCompaniesPage = currentCompaniesPage + 1;
            widget.bloc.add(GetCompaniesEvent(currentCompaniesPage));

          });
        }
      }
    }
  }


  @override
  void initState() {
    companiesController = ScrollController()..addListener(_companiesScrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child:

      (widget.state is LoadingUserState) ?
      Center(child: CustomLoading(),) :
      ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        controller: companiesController,
        shrinkWrap: true,
        itemCount: companies.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Checkbox(
                  value: (widget.selectedCompanies
                      .contains(companies[index])),
                  onChanged: (x) {
                    setState(() {
                      if (widget.selectedCompanies
                          .contains(companies[index])) {
                        widget.selectedCompanies
                            .remove(companies[index]);
                      } else {
                        widget.selectedCompanies.add(companies[index]);
                      }
                    });
                  }),
              InkWell(
                child: SizedBox(
                  width: 180,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      (languageCode == "en")
                          ? companies[index].englishName ?? ""
                          : companies[index].arabicName ?? "",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (widget.selectedCompanies
                        .contains(companies[index])) {
                      widget.selectedCompanies.remove(companies[index]);
                    } else {
                      widget.selectedCompanies.add(companies[index]);
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
