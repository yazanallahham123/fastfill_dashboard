import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../model/company/company.dart';


class CompanyWidget extends StatefulWidget{

  final Company company;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const CompanyWidget({required this.company,
    required this.onDelete,
    required this.onEdit
  });

  @override
  State<CompanyWidget> createState() => _CompanyWidgetState();
}

class _CompanyWidgetState extends State<CompanyWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Card(child:
      Column(
        children: [
          Row(children: [
            Padding(child: Text(translate("columns.id")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            AutoSizeText(widget.company.id.toString(), maxLines: 1,),
          ],),
          Row(children: [
            Padding(child: Text(translate("columns.code")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            AutoSizeText(widget.company.code.toString(), maxLines: 1,),
          ],),
          Row(children: [
            Padding(child: Text(translate("columns.englishName")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            Expanded(child: AutoSizeText(widget.company.englishName!, maxLines: 1,)),
          ],),
          Row(children: [
            Padding(child: Text(translate("columns.arabicName")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            Expanded(child: AutoSizeText(widget.company.arabicName!, maxLines: 1,)),
          ],),
          Row(children: [
            Padding(child: Text(translate("columns.englishAddress")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            Expanded(child: AutoSizeText(widget.company.englishAddress!, maxLines: 1,)),
          ],),
          Row(children: [
            Padding(child: Text(translate("columns.arabicAddress")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            Expanded(child: AutoSizeText(widget.company.arabicAddress!, maxLines: 1,)),
          ],),
          Row(children: [
            IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete)),
            IconButton(onPressed: widget.onEdit, icon: Icon(Icons.edit))
          ],)
        ],));
  }
}