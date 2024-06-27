import 'dart:convert';
import 'dart:developer';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zego_zim/zego_zim.dart';

import '../../../app/constant.dart';
import '../../../app/routes.dart';
import '../../../app/theme.dart';
import '../room_chat/provider/room_provider.dart';

class ConverListCell extends HookConsumerWidget {
  final ZIMConversation conversation;

  ConverListCell(this.conversation);

  String getTitleValue() {
    return conversation.conversationName.isNotEmpty
        ? conversation.conversationName
        : conversation.conversationID;
  }

  bool get isShowBadge {
    return conversation.unreadMessageCount > 0;
  }

  String getTime() {
    if (conversation.lastMessage == null) {
      return '';
    }

    int timeStamp = (conversation.lastMessage!.timestamp / 1000).round();
    int time = (DateTime.now().millisecondsSinceEpoch / 1000).round();

    int _distance = time - timeStamp;
    if (_distance <= 60) {
      return CustomStamp_str(Timestamp: timeStamp, Date: 'MM/DD hh:mm');
    } else if (_distance <= 3600) {
      return CustomStamp_str(Timestamp: timeStamp, Date: 'MM/DD hh:mm');
    } else if (_distance <= 43200) {
      return CustomStamp_str(Timestamp: timeStamp, Date: 'MM/DD hh:mm');
    } else if (DateTime.fromMillisecondsSinceEpoch(time * 1000).year ==
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).year) {
      return CustomStamp_str(Timestamp: timeStamp, Date: 'MM/DD hh:mm');
    } else {
      return CustomStamp_str(Timestamp: timeStamp, Date: 'YY/MM/DD hh:mm');
    }
  }

  String CustomStamp_str({
    required int Timestamp,
    required String Date,
    bool toInt = true,
  }) {
    String Time_str =
        (DateTime.fromMillisecondsSinceEpoch(Timestamp * 1000)).toString();

    dynamic Date_arr = Time_str.split(' ')[0];
    dynamic Time_arr = Time_str.split(' ')[1];

    String YY = Date_arr.split('-')[0];
    String MM = Date_arr.split('-')[1];
    String DD = Date_arr.split('-')[2];

    String hh = Time_arr.split(':')[0];
    String mm = Time_arr.split(':')[1];
    String ss = Time_arr.split(':')[2];
    ss = ss.split('.')[0];

    if (toInt) {
      MM = int.parse(MM).toString();
      DD = int.parse(DD).toString();
      hh = int.parse(hh).toString();
      mm = int.parse(mm).toString();
    }

    return Date.replaceAll('YY', YY)
        .replaceAll('MM', MM)
        .replaceAll('DD', DD)
        .replaceAll('hh', hh)
        .replaceAll('mm', mm)
        .replaceAll('ss', ss);
  }

  IconData getAvatar() {
    switch (conversation.type) {
      case ZIMConversationType.peer:
        return Icons.person;
      case ZIMConversationType.room:
        return Icons.home_sharp;
      case ZIMConversationType.group:
        return Icons.people;
      default:
        return Icons.person;
    }
  }

  String getLastMessageValue() {
    if (conversation.lastMessage == null) return '';
    switch (conversation.lastMessage!.type) {
      case ZIMMessageType.text:
        return jsonDecode(
            (conversation.lastMessage as ZIMTextMessage).message)['message'];
      case ZIMMessageType.command:
        return '[cmd]';
      case ZIMMessageType.barrage:
        return (conversation.lastMessage as ZIMBarrageMessage).message;
      case ZIMMessageType.audio:
        return '[audio]';
      case ZIMMessageType.video:
        return '[video]';
      case ZIMMessageType.file:
        return '[file]';
      case ZIMMessageType.image:
        return '[image]';
      default:
        return '[unknown message type]';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        print("conversation.conversationID");
        print(conversation.conversationID);
        ref.read(currentRoomIdProvider.notifier).state =
            conversation.conversationID;
        ref.read(currentRoomNameProvider.notifier).state =
            conversation.conversationName;
        Navigator.pushNamed(context, roomChatRoute);

        // switch (widget.conversation.type) {
        //   case ZIMConversationType.peer:
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: ((context) {
        //           return PeerChatPage(
        //             conversationID: widget.conversation.conversationID,
        //             conversationName: widget.conversation.conversationName,
        //           );
        //         }),
        //       ),
        //     );
        //     break;
        //   case ZIMConversationType.group:
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: ((context) {
        //           return GroupChatPage(
        //             conversationID: widget.conversation.conversationID,
        //             conversationName: widget.conversation.conversationName,
        //           );
        //         }),
        //       ),
        //     );
        //     break;
        //   default:
        // }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Color(0xFFd9d9d9)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 13.0),
              child: Container(
                width: getActualX(x: 50, context: context),
                height: getActualY(y: 50, context: context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://linksehat.dev/assets/img/users/male-avatar.png",
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                getTitleValue(),
                                style: textLargeMedium(context: context),
                                maxLines: 1,
                              ),
                            ),
                            Text(
                              getTime(),
                              style: textMediumReguler(context: context)
                                  .copyWith(color: netralColor60),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                getLastMessageValue(),
                                style: textMediumReguler(context: context)
                                    .copyWith(color: netralColor60),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isShowBadge)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      getActualX(x: 8, context: context),
                                  vertical: getActualY(y: 8, context: context),
                                ),
                                decoration: BoxDecoration(
                                  color: primaryMainColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  conversation.unreadMessageCount.toString(),
                                  style: textMediumMedium(context: context),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
