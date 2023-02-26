import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../model/group/group.dart';


class GroupWidget extends StatefulWidget{

  final Group group;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const GroupWidget({required this.group,
    required this.onDelete,
    required this.onEdit
  });

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Card(child:
      Column(
        children: [
          Row(children: [
            Padding(child: Text(translate("columns.id")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            AutoSizeText(widget.group.id.toString(), maxLines: 1,),
          ],),
          Row(children: [
            Padding(child: Text(translate("columns.englishName")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            Expanded(child: AutoSizeText(widget.group.englishName!, maxLines: 1,)),
          ],),
          Row(children: [
            Padding(child: Text(translate("columns.arabicName")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            Expanded(child: AutoSizeText(widget.group.arabicName!, maxLines: 1,)),
          ],),
          Row(children: [
            IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete)),
            IconButton(onPressed: widget.onEdit, icon: Icon(Icons.edit))
          ],)
        ],));
  }
}