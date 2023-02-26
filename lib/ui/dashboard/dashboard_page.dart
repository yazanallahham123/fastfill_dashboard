
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fastfilldashboard/bloc/users/event.dart';
import 'package:fastfilldashboard/model/dashboard/dashboard_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import '../../bloc/users/bloc.dart';
import '../../bloc/users/state.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../main.dart';
import '../../model/user/user.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';


class DashboardPage extends StatefulWidget {
  static const route = "/dashboard_page";

  const DashboardPage();

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

DashboardData dashboardData = DashboardData();
class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc()..add(GetDashboardDataEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is GotDashboardData) {
            if (mounted) {
              setState(() {
                dashboardData = state.dashboardData;
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

List<charts.Series>? seriesList;


class OrdinalSales {
  String? day;
  double? value;
  OrdinalSales(this.day, this.value);
}

class _BuildUIState extends State<_BuildUI> {
  String? currentLanguage = (languageCode == "en") ? "English" : "عربي";


  static List<charts.Series<OrdinalSales, String>> _processWeeklkyData() {
    final data = [
      new OrdinalSales(DateFormat("EE").format(DateTime.now()), dashboardData.weekTotalPaymentTransactions!.today!),
      new OrdinalSales(DateFormat("EE").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1)), dashboardData.weekTotalPaymentTransactions!.oneDayBefore!),
      new OrdinalSales(DateFormat("EE").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 2)), dashboardData.weekTotalPaymentTransactions!.twoDaysBefore!),
      new OrdinalSales(DateFormat("EE").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 3)), dashboardData.weekTotalPaymentTransactions!.threeDaysBefore!),
      new OrdinalSales(DateFormat("EE").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 4)), dashboardData.weekTotalPaymentTransactions!.fourDaysBefore!),
      new OrdinalSales(DateFormat("EE").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 5)), dashboardData.weekTotalPaymentTransactions!.fiveDaysBefore!),
      new OrdinalSales(DateFormat("EE").format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 6)), dashboardData.weekTotalPaymentTransactions!.sixDaysBefore!),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.day!,
        measureFn: (OrdinalSales sales, _) => sales.value!,
        labelAccessorFn: (OrdinalSales sales, _) => '${formatter.format(sales.value)} SDG',
        data: data,
      )
    ];
  }

  void initState() {
    super.initState();
  }

  User _buildUserInstance(AsyncSnapshot<User> snapshot) {
    if (snapshot.hasData && snapshot.data!.id != 0 && snapshot.data!.id != null)
      return snapshot.data!;
    return User();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body:

      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

      Expanded(child:
      LayoutBuilder(builder: (context, constraints) =>


        RefreshIndicator(onRefresh: () async {
        widget.bloc.add(GetDashboardDataEvent());
      },
          color: Colors.white,
          backgroundColor: buttonColor1,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          child:

 SingleChildScrollView(
     physics: AlwaysScrollableScrollPhysics(),
          child:

          FutureBuilder<User>(
          future: getCurrentUserValue(),
    builder: (context, AsyncSnapshot<User> snapshot) {
    User usr = _buildUserInstance(snapshot);
    if (usr.id != null) {
    return  Stack(children: [
      (widget.state is LoadingUserState) ?
      Center(child: CustomLoading(),)
          :
      Column(
        children: [

          Row(children: [
            Expanded(child:
            Container(
              margin: EdgeInsetsDirectional.fromSTEB(5, 10, 0, 5),
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              decoration: BoxDecoration(color: backgroundColor1, borderRadius: radiusAll20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(translate(usr.firstName!), style: TextStyle(color: Colors.white, fontSize: 10),),
                  Text(DateFormat('yyyy MMMM MM-dd EEEE').format( DateTime.now()), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),),
                ],),
            ),flex: 3),

            Expanded(child: Container(
              margin: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 5),
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              decoration: BoxDecoration(color: backgroundColor1, borderRadius: radiusAll20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(translate("labels.totalUsers")+": "+dashboardData.totalUsers.toString(), style: TextStyle(color: Colors.white, fontSize: 10)),
                  Text(translate("labels.totalCompanies")+": "+dashboardData.totalCompanies.toString(), style: TextStyle(color: Colors.white, fontSize: 10)),
                ],),
            ), flex: 2)],),

          Container(
            alignment: AlignmentDirectional.topStart,
            margin: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            decoration: BoxDecoration(color: backgroundColor1, borderRadius: radiusAll20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(translate("labels.transactions"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                Text(translate("labels.totalTransactionsCount")+": "+ formatter.format(dashboardData.totalTransactionsCount), style: TextStyle(color: Colors.white, fontSize: 12)),
                Text(translate("labels.totalTransactionsAmount")+": "+formatter.format(dashboardData.totalTransactionsAmount)+" "+translate("labels.sdg"), style: TextStyle(color: Colors.white, fontSize: 12)),
                Text(translate("labels.totalFastFill")+": "+formatter.format(dashboardData.totalFastFill)+" "+translate("labels.sdg"), style: TextStyle(color: Colors.white, fontSize: 12))
              ],),
          ),

          Container(
              padding: EdgeInsets.all(10),
              height: 250,
              width: MediaQuery.of(context).size.width,
              child:
              charts.BarChart(_processWeeklkyData(),animate: true,
                barRendererDecorator: new charts.BarLabelDecorator<String>(
                    outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 10),
                    insideLabelStyleSpec: charts.TextStyleSpec(fontSize: 25)),
                domainAxis: new charts.OrdinalAxisSpec(),)),

          Container(
            alignment: AlignmentDirectional.topStart,
            margin: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            decoration: BoxDecoration(color: backgroundColor1, borderRadius: radiusAll20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(translate("labels.topStations"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                Row(
                  children: [
                    Expanded(child: Align(child: Text(translate("labels.station"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),), alignment: AlignmentDirectional.center,), flex: 2),
                    Expanded(child: Align(child: Text(translate("labels.amount"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),alignment: AlignmentDirectional.center,), flex: 1),
                    Expanded(child: Align(child: Text(translate("labels.count"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),alignment: AlignmentDirectional.center,), flex: 1),
                  ],),
                (dashboardData.topCompanies != null) ? (dashboardData.topCompanies!.length > 0) ?
                Column(

                  children: dashboardData.topCompanies!.map((e) => Container(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Align(child: Text((languageCode == "en") ? e.englishName! : e.arabicName!,  style: TextStyle(color: Colors.white, fontSize: 10)), alignment: AlignmentDirectional.center,), flex: 2),
                      Expanded(child: Align(child: Text(formatter.format(e.amount!).toString() + " " + translate("labels.sdg"), style: TextStyle(color: Colors.white, fontSize: 10)), alignment: AlignmentDirectional.center,), flex: 1),
                      Expanded(child: Align(child: Text(e.count!.toString(), style: TextStyle(color: Colors.white, fontSize: 12)),alignment: AlignmentDirectional.center,), flex: 1),
                    ],),)).toList(),) : Container() : Container()
              ],),

          )


        ],),

    ],);
    }
    else
    return Container();
    })




        )


        )))]));

  }
}

