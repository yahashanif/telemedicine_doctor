import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zim/zego_zim.dart';

import '../../../../app/constant.dart';
import '../../../../app/theme.dart';
import '../../../../widgets/bubble/text_bubble.dart';

class ReceiveTextMsgCell extends StatefulWidget {
  ZIMTextMessage message;

  ReceiveTextMsgCell({required this.message});

  @override
  State<StatefulWidget> createState() => _MyCellState();
}

class _MyCellState extends State<ReceiveTextMsgCell> {
  String? userID = '';

  getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.get("userID").toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    var message = jsonDecode(widget.message.message);
    print(widget.message.conversationID);
    return Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        width: double.infinity,
        child: Align(
            alignment: Alignment.centerLeft,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: const BoxDecoration(
                    color: netralColor30,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                padding: EdgeInsets.symmetric(
                    horizontal: getActualX(x: 10, context: context),
                    vertical: getActualY(y: 10, context: context)),
                child: Text(
                  message['message'].toString(),
                  style: textMediumReguler(context: context),
                ),
              ),
              Text(
                DateFormat('hh.mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(message['time'] != null
                        ? int.parse(message['time'].toString())
                        : widget.message.timestamp)),
                style: textSmallReguler(context: context),
              ),
              SizedBox(
                height: getActualY(y: 12, context: context),
              ),
            ])));
  }
}
