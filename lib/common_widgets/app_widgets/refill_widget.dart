import 'package:auto_size_text/auto_size_text.dart';
import 'package:fastfilldashboard/model/refills/user_refill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import '../../utils/misc.dart';

class RefillWidget extends StatefulWidget {
  final UserRefill userRefill;
  const RefillWidget({required this.userRefill});

  @override
  State<RefillWidget> createState() => _RefillWidgetState();
}

class _RefillWidgetState extends State<RefillWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Card(
        color: (widget.userRefill.status == false) ? Colors.red : Colors.white,
      margin: EdgeInsets.all(10),
        child: Column(
      children: [
        Row(
          children: [
            Padding(child: Text(
              translate("labels.id") + ":",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 0),),
            Expanded(
                child: Padding(child: AutoSizeText(
              widget.userRefill.id.toString(),
              maxLines: 1,
            ),padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0))),
            Padding(child: Text(translate("labels.date") + ":",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 0)),
            Padding(child: AutoSizeText(
              DateFormat("yyyy-MM-dd hh:mm a").format(widget.userRefill.date!),
              maxLines: 1,
            ),padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0)),
          ],
        ),
        Row(
          children: [
            Padding(
              child: Text(translate("labels.phoneNumber")+":",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10) ),
              padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 0),
            ),
            Expanded(
                child: Padding(child: AutoSizeText(
              "0" + widget.userRefill.mobileNumber!,
              maxLines: 1,
            ), padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0))),
          ],
        ),
        Row(
          children: [
            Padding(
              child: Text(translate("labels.transactionId") + ":",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 0),
            ),
            Expanded(
                child: Padding(child: AutoSizeText(
                  widget.userRefill.transactionId!,
                  maxLines: 1,
                ), padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0))),
          ],
        ),
        Row(
          children: [
            Padding(
              child: Text(translate("labels.amount") + ":",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 0),
            ),
            Expanded(
                child: Padding(child: AutoSizeText(
                  formatter.format(widget.userRefill.amount) +
                      " " +
                      translate("labels.sdg"),
                  maxLines: 1,
                ), padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0))),
          ],
        ),
        Row(
          children: [
            Padding(
              child: Text(translate("labels.status") + ":",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 0),
            ),
            Expanded(
                child: Padding(
    child: AutoSizeText(
              (widget.userRefill.status ?? false)
                  ? translate("labels.successStatus")
                  : translate("labels.failStatus"),
              maxLines: 1,
            ), padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0))),
          ],
        ),
        Row(
          children: [
            Padding(
              child: Text(translate("labels.source") + ":",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
              padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 5),
            ),
            Expanded(
                child:
    Padding(
    child: AutoSizeText(
              widget.userRefill.source!,
              maxLines: 1,
            ),padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),)),
          ],
        ),
      ],
    ));
  }
}
