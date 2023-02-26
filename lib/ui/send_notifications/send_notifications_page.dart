import 'package:fastfilldashboard/bloc/users/bloc.dart';
import 'package:fastfilldashboard/bloc/users/event.dart';
import 'package:fastfilldashboard/bloc/users/state.dart';
import 'package:fastfilldashboard/model/notifications/custom_notification_body.dart';
import 'package:fastfilldashboard/model/notifications/custom_notification_body_to_multiple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../common_widgets/buttons/custom_button.dart';
import '../../common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import '../../common_widgets/custom_text_field_widgets/methods.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';

final phoneController = TextEditingController();
final contentController = TextEditingController();
final List<String> phoneNumbers = [];

class SendNotificationsPage extends StatefulWidget {
  static const route = "/send_notifications_page";
  const SendNotificationsPage();

  @override
  State<SendNotificationsPage> createState() => _SendNotificationsPageState();
}

class _SendNotificationsPageState extends State<SendNotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
        create: (BuildContext context) => UserBloc(), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) async {
          if (state is ErrorUserState)
            pushToast(state.error);
          else
          if (state is SentCustomNotificationToMultipleState)
          {
            if (state.result)
            {
              if (mounted) {
                setState(() {
                  phoneController.text = "";
                  contentController.text = "";
                });
              }
              pushToast(translate("messages.notificationSuccessfullySent"));
            }
            else
              pushToast(translate("messages.couldNotSendNotification"));
          }
          else
            if (state is SentCustomNotificationState)
              {
                if (state.result)
                  {
                    if (mounted) {
                      setState(() {
                        phoneController.text = "";
                        contentController.text = "";
                      });
                    }
                    pushToast(translate("messages.notificationSuccessfullySent"));
                  }
                else
                  pushToast(translate("messages.couldNotSendNotification"));
              }
            else
              if (state is SentCustomNotificationToAllState)
                {
                  if (state.result)
                  {
                    if (mounted) {
                      setState(() {
                        phoneController.text = "";
                        contentController.text = "";
                      });
                    }
                    pushToast(translate("messages.notificationSuccessfullySent"));
                  }
                  else
                    pushToast(translate("messages.couldNotSendNotification"));
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
  final contentNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(translate("drawer.custom_notifications")),
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
                            FocusScope.of(context).requestFocus(contentNode)),
                  ),

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
                              title: translate("buttons.add"),
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
                                if (pn.trim().isNotEmpty) {
                                  if (mounted) {
                                    setState(() {
                                      phoneNumbers.add(pn);
                                    });
                                  }
                                }
                                })),
                    ],
                  ),

                  (phoneNumbers.length > 0)
                      ? Container(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          5, 2, 5, 2),
                      height: 40,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: phoneNumbers
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
                                  Text(x)
                                ],
                              )),
                          onTap: () {
                            setState(() {
                              phoneNumbers
                                  .remove(x);
                            });
                          },
                        ))
                            .toList(),
                      ))
                      : Container(),


                  Container(
                      height: 100,
                      child:
                  Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: SizeConfig().h(0),
                          start: SizeConfig().w(15),
                          end: SizeConfig().w(15)),
                      child: CustomTextFieldWidget(
                        height: 100,
                          controller: contentController,
                          textInputAction: TextInputAction.newline,
                          focusNode: contentNode,
                          textInputType: TextInputType.multiline,
                          hintText: translate("labels.content"),
                          onFieldSubmitted: (_) {}))),
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
                                title: translate("buttons.send"),
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


                                  if (phoneNumbers.length == 1) {
                                    if (contentController.text != "") {
                                      CustomNotificationBody customNotificationBody = CustomNotificationBody(
                                          mobileNumber: phoneNumbers[0],
                                          content: contentController.text,
                                          title: "");

                                      widget.bloc.add(
                                          SendCustomNotificationEvent(
                                              customNotificationBody));
                                    }
                                    else {
                                      pushToast(translate(
                                          "messages.pleaseAddContent"));
                                    }
                                  }
                                  else {
                                    if (phoneNumbers.length == 0) {
                                      if (contentController.text != "") {
                                        CustomNotificationBody customNotificationBody = CustomNotificationBody(
                                            mobileNumber: "",
                                            content: contentController.text,
                                            title: "");

                                        widget.bloc.add(
                                            SendCustomNotificationToAllEvent(
                                                customNotificationBody));
                                      }
                                      else {
                                        pushToast(translate(
                                            "messages.pleaseAddContent"));
                                      }
                                    }
                                    else
                                      {
                                        if (phoneNumbers.length > 1)
                                          {
                                            if (contentController.text != "") {
                                              CustomNotificationBodyToMultiple customNotificationBodyToMultiple = CustomNotificationBodyToMultiple(
                                                  mobileNumbers: phoneNumbers,
                                                  content: contentController.text,
                                                  title: "");

                                              widget.bloc.add(
                                                  SendCustomNotificationToMultipleEvent(
                                                      customNotificationBodyToMultiple));
                                            }
                                            else {
                                              pushToast(translate(
                                                  "messages.pleaseAddContent"));
                                            }
                                          }
                                      }
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


