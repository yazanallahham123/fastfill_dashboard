import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';


import '../../bloc/login/bloc.dart';
import '../../bloc/login/event.dart';
import '../../bloc/login/state.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../common_widgets/buttons/custom_button.dart';
import '../../common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import '../../common_widgets/custom_text_field_widgets/methods.dart';
import '../../common_widgets/custom_text_field_widgets/textfield_password_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/methods.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../main.dart';
import '../../model/login/login_body.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  static const route = "/login_page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) async {
          if (state is ErrorLoginState)
            pushToast(state.error);
          else if (state is SuccessLoginState) {
            await setCurrentUserValue(state.loginUser.value!.userDetails!);
            await setTokenValue(state.loginUser.value!.token!);
            pushToast(translate("messages.youLoggedSuccessfully"));
            print("successful login");
            Navigator.pushReplacementNamed(context, HomePage.route);
          }
        },
        bloc: bloc,
        child: BlocBuilder<LoginBloc, LoginState>(
            bloc: bloc,
            builder: (context, LoginState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}

class _BuildUI extends StatefulWidget {
  final LoginBloc bloc;
  final LoginState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}


class _BuildUIState extends State<_BuildUI> {

  final phoneController = TextEditingController();
  final passController = TextEditingController();
  final phoneNode = FocusNode();
  final passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body:
    SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(
                  top: SizeConfig().h(175),
                  start: SizeConfig().w(20),
                  end: SizeConfig().w(20)),
              padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
              child: Column(
                children: [
                  Padding(child:
                  Text(translate("labels.welcome")),padding: EdgeInsetsDirectional.fromSTEB(0, SizeConfig().h(20), 0, SizeConfig().h(10))),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.only(top: SizeConfig().h(40)),
                    child: CustomTextFieldWidget(
                        controller: phoneController,
                        focusNode: phoneNode,
                        validator: validateUsername,
                        hintText: translate("labels.userName"),
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(passNode)),
                  ),
                  TextFieldPasswordWidget(
                      controller: passController,
                      textInputAction: TextInputAction.go,
                      focusNode: passNode,
                      hintText: translate("labels.password"),
                      onFieldSubmitted: (_) {
                        _login(context);
                      }),
                  if (widget.state is LoadingLoginState)
                    Padding(
                      child: const CustomLoading(),
                      padding: EdgeInsetsDirectional.only(
                          top: SizeConfig().h(62), bottom: SizeConfig().h(62)),
                    )
                  else
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.only(
                                bottom: SizeConfig().h(100),
                                top: SizeConfig().h(10)),
                            child: CustomButton(
                                backColor: buttonColor1,
                                titleColor: Colors.white,
                                borderColor: buttonColor1,
                                title: translate("buttons.signIn"),
                                onTap: () {
                                  _login(context);
                                })),
                      ],
                    ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                if (isArabic()) {
                  await setLanguageValue("en");
                  languageCode = "en";
                  FastFillAdminPanelApp.setLocale(context, Locale.fromSubtags(languageCode: "en"));
                  changeLocale(context, "en");
                }
                else
                  {
                    await setLanguageValue("ar");
                    languageCode = "ar";
                    FastFillAdminPanelApp.setLocale(context, Locale.fromSubtags(languageCode: "ar"));
                    changeLocale(context, "ar");
                  }
              },
              child: Container(
                  alignment: Alignment.topLeft,
                  height: SizeConfig().h(50),
                  width: SizeConfig().w(75),
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig().w(12),
                      vertical: SizeConfig().h(55)),
                  child: (isArabic())
                      ? Text("English", style: TextStyle(color: buttonColor1),)
                      : Text("عربي", style: TextStyle(color: buttonColor1))),
            )
          ],
        )));
  }

  void _login(BuildContext context) async {
    hideKeyboard(context);
    final bloc = BlocProvider.of<LoginBloc>(context);
    if (phoneController.text.isNotEmpty && passController.text.isNotEmpty) {
      if (!validateUsername(phoneController.text))
        FocusScope.of(context).requestFocus(phoneNode);
      else if (!isStrongPassword(passController.text))
        FocusScope.of(context).requestFocus(passNode);
      else {

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

        pn = phoneController.text;

        int languageId = (languageCode=="en") ? 1 : 2;

        bloc.add(LoginUserEvent(LoginBody(
            mobileNumber: pn,
            password: passController.text,
            language: languageId)));
      }
    } else
      pushToast(translate("messages.theseFieldsMustBeFilledIn"));
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passController.dispose();
    passNode.dispose();
    phoneNode.dispose();
  }
}


