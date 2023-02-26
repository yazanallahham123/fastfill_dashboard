import 'package:auto_size_text/auto_size_text.dart';
import 'package:fastfilldashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../model/user/user.dart';


class UserWidget extends StatefulWidget{

  final User user;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const UserWidget({required this.user,
  required this.onDelete,
  required this.onEdit
  });

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Card(child:
      Column(
      children: [
        Row(children: [
          Padding(child: Text(translate("labels.id")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
          AutoSizeText(widget.user.id.toString(), maxLines: 1,),
        ],),
        Row(children: [
          Padding(child: Text(translate("labels.fullname")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
          Expanded(child: AutoSizeText(widget.user.firstName!, maxLines: 1,)),
        ],),
        ((widget.user.roleId == 4) && (widget.user.company != null))
            ?
        Row(children: [
          Padding(child: Text(translate("columns.companyName")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
          Expanded(child: AutoSizeText((languageCode == "ar") ? widget.user.company!.arabicName! : widget.user.company!.englishName!, maxLines: 1,))
        ],) : Container(),
        Row(children: [
          Padding(child: Text(translate("labels.phoneNumber")+":"), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
          Expanded(child: AutoSizeText("0"+widget.user.mobileNumber!, maxLines: 1,)),
        ],),
        Row(children: [
          IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete)),
          IconButton(onPressed: widget.onEdit, icon: Icon(Icons.edit))
        ],)
    ],));
  }
}