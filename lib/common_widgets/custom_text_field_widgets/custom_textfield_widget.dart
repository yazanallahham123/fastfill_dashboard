
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../helper/const_sizes.dart';
import '../../helper/const_styles.dart';
import '../../helper/font_styles.dart';
import '../../helper/size_config.dart';


class CustomTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputType? textInputType;
  final Widget? icon;
  final Color? color;
  final TextInputFormatter? textFormatter;
  final double? height;

  final bool Function(String? value)? validator;

  CustomTextFieldWidget(
      {Key? key,
      this.hintText,
      required this.controller,
      this.validator,
      this.textInputAction,
      this.focusNode,
      this.onFieldSubmitted,
      this.textInputType,
      this.icon,
      this.color,
      this.textFormatter,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    ValueNotifier<bool?> showError = ValueNotifier<bool?>(null);
    return  ValueListenableBuilder<bool?>(
            valueListenable: showError,
            builder: (BuildContext context, value, Widget? child) {
              return Container(
                  height: (value != null && value) ? SizeConfig().h(70) : SizeConfig().h(55),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: SizeConfig().h(height??47),
                        decoration: BoxDecoration(
                            borderRadius: radiusAll10,
                            color: (color??Colors.white)),
                        child: TextFormField(
                            inputFormatters: (textFormatter != null ) ? [textFormatter!] : [],
                            controller: controller,
                            cursorColor: Colors.black,
                            focusNode: focusNode,
                            textInputAction: textInputAction,
                            keyboardType: textInputType,
                            style: largeMediumPrimaryColor3(),
                            maxLines: null,
                            expands: true,
                            onFieldSubmitted: onFieldSubmitted,
                            decoration: new InputDecoration(
                              prefixIcon: icon,
                                border: OutlineInputBorder(
                                  borderRadius: radiusAll10,
                                ),
                                errorStyle: TextStyle(
                                  color: Colors.red,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: showError.value == null
                                            ? Colors.amber
                                            : showError.value == true
                                                ? Colors.yellow
                                                : Colors.green,
                                        width: width1),
                                    borderRadius: radiusAll10),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: showError.value == null
                                            ? Color(0xffd8e0e5)
                                            : showError.value == true
                                                ? Colors.red
                                                : Colors.green,
                                        width: width1),
                                    borderRadius: radiusAll10),
                                hintStyle: smallCustomGreyColor5(),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    SizeConfig().w(20),
                                    0,
                                    SizeConfig().w(20),
                                    SizeConfig().h(16)),
                                hintText: hintText),
                            onChanged: (stringValue) {
                              showError.value = (validator != null &&
                                  !validator!(stringValue));
                            })),
                    if (value != null && value)
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig().w(10)),
                          child: Text(translate("messages.thisFieldMustBeFilledIn"),
                              style: errorStyle()))
                  ]));
            });
  }
}
