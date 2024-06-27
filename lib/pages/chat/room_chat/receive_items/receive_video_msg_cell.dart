import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zego_zim/zego_zim.dart';

import '../../../../app/constant.dart';
import '../../../../app/theme.dart';
import '../../../../model/downloading_progress_model.dart';
import '../../../../widgets/bubble/video_bubble.dart';

class ReceiveVideoMsgCell extends StatefulWidget {
  ZIMVideoMessage message;
  double? progress;
  DownloadingProgressModel? downloadingProgressModel;
  ZIMMediaDownloadingProgress? downloadingProgress;

  ReceiveVideoMsgCell(
      {required this.message, required this.downloadingProgressModel});

  get isUpLoading {
    if (message.sentStatus == ZIMMessageSentStatus.sending) {
      return true;
    } else {
      return false;
    }
  }

  get isUpLoadFailed {
    if (message.sentStatus == ZIMMessageSentStatus.failed) {
      return true;
    } else {
      return false;
    }
  }

  @override
  State<StatefulWidget> createState() => ReceiveVideoeMsgCellState();
}

class ReceiveVideoeMsgCellState extends State<ReceiveVideoMsgCell> {
  checkIsdownload() async {
    if (widget.message.fileLocalPath == '') {
      ZIMMediaDownloadedResult result = await ZIM
          .getInstance()!
          .downloadMediaFile(widget.message, ZIMMediaFileType.originalFile,
              (message, currentFileSize, totalFileSize) {});
      setState(() {
        widget.message = result.message as ZIMVideoMessage;
      });
    }
  }

  getVideoBubble() {
    return VideoBubble(
      url: widget.message.fileDownloadUrl,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    checkIsdownload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon(
          //   Icons.person,
          //   size: 50,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.message.senderUserID),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [getVideoBubble()],
              ),
              Text(
                DateFormat('hh.mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        widget.message.timestamp)),
              ),
              SizedBox(
                height: getActualY(y: 12, context: context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
