import 'package:fastfilldashboard/bloc/users/bloc.dart';
import 'package:fastfilldashboard/bloc/users/event.dart';
import 'package:fastfilldashboard/bloc/users/state.dart';
import 'package:fastfilldashboard/helper/app_colors.dart';
import 'package:fastfilldashboard/helper/size_config.dart';
import 'package:fastfilldashboard/model/user/top_up_credit_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:uuid/uuid.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../common_widgets/buttons/custom_button.dart';
import '../../common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import '../../common_widgets/custom_text_field_widgets/methods.dart';
import '../../helper/toast.dart';

final phoneController = TextEditingController();
final amountController = TextEditingController();
final confirmAmountController = TextEditingController();

class TopUpPage extends StatefulWidget {
  static const route = "/top_up_page";
  const TopUpPage();

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
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
          if (state is ErrorUserState)
            pushToast(state.error);
          else if (state is TopUpState) {
            if (state.response.responseCode == "0") {
              if (mounted) {
                pushToast(translate("messages.successTopepUp"));
                setState(() {
                  phoneController.text = "";
                  amountController.text = "";
                  confirmAmountController.text = "";
                });
              }
            }
            else
              pushToast(translate("messages.couldNotTopUp"));
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
  final amountNode = FocusNode();
  final confirmAmountNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate("drawer.topUp")),
          automaticallyImplyLeading: false,
        ),
        body: (widget.state is LoadingUserState)
            ? CustomLoading()
            : SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: SizeConfig().h(40),
                          start: SizeConfig().w(15),
                          end: SizeConfig().w(15)),
                      child: CustomTextFieldWidget(
                          controller: phoneController,
                          focusNode: phoneNode,
                          validator: validateMobile,
                          hintText: translate("labels.phoneNumber"),
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(amountNode)),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: SizeConfig().h(0),
                            start: SizeConfig().w(15),
                            end: SizeConfig().w(15)),
                        child: CustomTextFieldWidget(
                            controller: amountController,
                            textInputAction: TextInputAction.next,
                            focusNode: amountNode,
                            validator: validateAmount,
                            hintText: translate("labels.amount"),
                            onFieldSubmitted: (_) {})),
                    Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: SizeConfig().h(0),
                            start: SizeConfig().w(15),
                            end: SizeConfig().w(15)),
                        child: CustomTextFieldWidget(
                            controller: confirmAmountController,
                            textInputAction: TextInputAction.go,
                            focusNode: confirmAmountNode,
                            validator: validateAmount,
                            hintText: translate("labels.confirmAmount"),
                            onFieldSubmitted: (_) {})),
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
                                  bottom: SizeConfig().h(100),
                                  top: SizeConfig().h(10)),
                              child: CustomButton(
                                  backColor: buttonColor1,
                                  titleColor: Colors.white,
                                  borderColor: buttonColor1,
                                  title: translate("buttons.topUp"),
                                  onTap: () {

                                    String pn = "";
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

                                    if (amountController.text == confirmAmountController.text) {
                                      var uuid = Uuid();
                                      TopUpCreditDto topUpCreditDto =
                                      new TopUpCreditDto(
                                          lang: "ar",
                                          mobileNumber: pn,
                                          amount: double.parse(
                                              amountController.text),
                                          transactionId: uuid.v1());
                                      widget.bloc.add(TopUpEvent(
                                          topUpCreditDto));
                                    }
                                    else
                                      {
                                        pushToast(translate("messages.confirmAmountMustEqualAmount"));
                                      }
                                  })),
                        ],
                      ),
                  ])));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
