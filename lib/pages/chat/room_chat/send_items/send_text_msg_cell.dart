import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zego_zim/zego_zim.dart';

import '../../../../app/constant.dart';
import '../../../../app/theme.dart';
import '../../../../widgets/bubble/text_bubble.dart';

class SendTextMsgCell extends StatefulWidget {
  ZIMTextMessage message;

  SendTextMsgCell({required this.message});
  @override
  State<StatefulWidget> createState() => _MyCellState();
}

class _MyCellState extends State<SendTextMsgCell> {
  get isSending {
    if (widget.message.sentStatus == ZIMMessageSentStatus.sending) {
      return true;
    } else {
      return false;
    }
  }

  get isSentFailed {
    if (widget.message.sentStatus == ZIMMessageSentStatus.failed) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var message = jsonDecode(widget.message.message);
    print(DateTime.fromMillisecondsSinceEpoch(widget.message.timestamp * 100));
    return Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        width: double.infinity,
        child: Align(
            alignment: Alignment.centerRight,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                decoration: const BoxDecoration(
                    color: primarySurfaceColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8))),
                padding: EdgeInsets.symmetric(
                    horizontal: getActualX(x: 10, context: context),
                    vertical: getActualY(y: 10, context: context)),
                child: Text(
                  message['message'] ?? '',
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
