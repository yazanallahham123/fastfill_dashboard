import 'package:auto_size_text/auto_size_text.dart';
import 'package:fastfilldashboard/main.dart';
import 'package:fastfilldashboard/model/company/payment_transaction_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import '../../utils/misc.dart';


class PaymentTransactionResultWidget extends StatefulWidget{

  final PaymentTransactionResult paymentTransactionResult;
  const PaymentTransactionResultWidget({required this.paymentTransactionResult
  });

  @override
  State<PaymentTransactionResultWidget> createState() => _PaymentTransactionResultWidgetState();
}

class _PaymentTransactionResultWidgetState extends State<PaymentTransactionResultWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Card(
          margin: EdgeInsets.all(10),
          child:
      Column(
        children: [
          Row(children: [
            Padding(child: Text(translate("labels.id")+":", style: TextStyle(fontWeight: FontWeight.bold),), padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),),
            Expanded(child: Padding(child: AutoSizeText(widget.paymentTransactionResult.id.toString(), maxLines: 1,), padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0))),
            Padding(child: Text(translate("labels.date")+":", style: TextStyle(fontWeight: FontWeight.bold)), padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),),
            Padding(child: AutoSizeText(DateFormat("yyyy-MM-dd hh:mm a").format(DateTime.parse(widget.paymentTransactionResult.date!)), maxLines: 1,),padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0)),

          ],),
          Row(children: [
          ],),
          Row(children: [
            Padding(child: Text(translate("labels.phoneNumber")+":",style: TextStyle(fontWeight: FontWeight.bold)), padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),),
            Expanded(child: Padding(child: AutoSizeText("0"+widget.paymentTransactionResult.user!.mobileNumber!, maxLines: 1,),  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0))),
          ],),
          Row(children: [
            Padding(child: Text(translate("labels.amount")+":",style: TextStyle(fontWeight: FontWeight.bold)), padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),),
            Expanded(child: Padding(child: AutoSizeText(formatter.format(widget.paymentTransactionResult.amount)+" "+translate("labels.sdg"), maxLines: 1,), padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0))),
          ],),
          Row(children: [
            Padding(child: Text(translate("labels.fastfill")+":",style: TextStyle(fontWeight: FontWeight.bold)), padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),),
            Expanded(child:  Padding(child: AutoSizeText(formatter.format(widget.paymentTransactionResult.fastfill)+" "+translate("labels.sdg"), maxLines: 1,),padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 0) )),
          ],),
          Row(children: [
            Padding(child: Text(translate("labels.station")+":",style: TextStyle(fontWeight: FontWeight.bold)), padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),),
            Expanded(child:  Padding(child: AutoSizeText((languageCode == "en") ? widget.paymentTransactionResult.company!.englishName! : widget.paymentTransactionResult.company!.arabicName!, maxLines: 1,),padding: EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5))),
          ],),
        ],));
  }
}