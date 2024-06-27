import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zego_zim/zego_zim.dart';

import '../../../app/routes.dart';
import '../../../model/downloading_progress_model.dart';
import '../../../model/uploading_progress_model.dart';
import '../../../model/user_model.dart';
import '../../../widgets/base_appbar.dart';
import '../../../zego_call_manager.dart';
import '../../call/call_controller.dart';
import '../../home_page.dart';
import '../../login/provider/userdata_provider.dart';
import 'msg_converter.dart';
import 'msg_list.dart';
import 'msg_normal_bottom_box.dart';
import 'provider/room_provider.dart';
import 'receive_items/receive_image_msg_cell.dart';
import 'receive_items/receive_text_msg_cell.dart';
import 'receive_items/receive_video_msg_cell.dart';
import 'send_items/send_text_msg_cell.dart';

class RoomChatPage extends HookConsumerWidget {
  const RoomChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _historyMessageWidgetList = useState<List<Widget>>([]);
    final _historyZIMMessageList = useState<List<ZIMMessage>>([]);

    final emojiShowing = useState(false);
    final queryHistoryMsgComplete = useState(false);
    final roomID = ref.watch(currentRoomIdProvider);
    final userID = ref.watch(currentDataUserIDProvider);
    final userName = ref.watch(currentDataUserNameProvider);
    final roomName = ref.watch(currentRoomNameProvider);
    final count = useState(0);

    queryMoreHistoryMessageWidgetList() async {
      if (queryHistoryMsgComplete.value) {
        return;
      }
      ZIMMessageQueryConfig queryConfig = ZIMMessageQueryConfig();
      queryConfig.count = 20;
      queryConfig.reverse = true;
      try {
        queryConfig.nextMessage = _historyZIMMessageList.value.first;
      } catch (onerror) {
        queryConfig.nextMessage = null;
      }
      try {
        ZIMMessageQueriedResult result = await ZIM
            .getInstance()!
            .queryHistoryMessage(
                roomID!, ZIMConversationType.peer, queryConfig);
        if (result.messageList.length < 20) {
          queryHistoryMsgComplete.value = true;
        }
        List<Widget> oldMessageWidgetList =
            MsgConverter.cnvMessageToWidget(result.messageList, userID!);
        result.messageList.addAll(_historyZIMMessageList.value);
        _historyZIMMessageList.value = result.messageList;
        oldMessageWidgetList.addAll(_historyMessageWidgetList.value);
        _historyMessageWidgetList.value = oldMessageWidgetList;
        // count.value++;
      } on PlatformException catch (onError) {
        //log(onError.code);
      }
    }

    clearUnReadMessage() {
      ZIM.getInstance()!.clearConversationUnreadMessageCount(
          roomID!, ZIMConversationType.peer);
    }

    registerZIMEvent() {
      print("REGISTER");
      ZIMEventHandler.onReceivePeerMessage = (zim, messageList, fromUserID) {
        // queryMoreHistoryMessageWidgetList();
        print("messageL22ist");
        // print(UserModel.shared().userInfo!.userID);
        print(fromUserID);
        print(fromUserID != roomID);
        // print(messageList);
        print(roomID);
        print("roomID");
        if (fromUserID != roomID) {
          return;
        }
        for (ZIMMessage message in messageList) {
          if (message.type == ZIMMessageType.image) {
            var messageData = message as ZIMMediaMessage;
            var cell = MsgConverter.cnvMessageToWidget([message], userID!);
            _historyMessageWidgetList.value.addAll(cell);
          } else {
            var messageData = message as ZIMTextMessage;
            print(messageData.senderUserID);
            print(messageData.message);
            print(userID);
            var cell = MsgConverter.cnvMessageToWidget([message], userID!);
            _historyMessageWidgetList.value.addAll(cell);
          }
        }
        count.value++;
      };

      // ZIMEventHandler.onReceiveRoomMessage = (zim, messageList, fromUserID) {
      //   print("object");
      //   print(fromUserID);
      // if (fromUserID != roomID) {
      //   return;
      // }
      //   _historyZIMMessageList.value.addAll(messageList);
      //   for (ZIMMessage message in messageList) {
      //     switch (message.type) {
      //       case ZIMMessageType.text:
      //         ReceiveTextMsgCell cell =
      //             ReceiveTextMsgCell(message: (message as ZIMTextMessage));
      //         _historyMessageWidgetList.value.add(cell);
      //         break;
      //       case ZIMMessageType.image:
      //         if ((message as ZIMImageMessage).fileLocalPath == "") {
      //           DownloadingProgressModel downloadingProgressModel =
      //               DownloadingProgressModel();

      //           ReceiveImageMsgCell resultCell;
      //           ZIM
      //               .getInstance()!
      //               .downloadMediaFile(message, ZIMMediaFileType.originalFile,
      //                   (message, currentFileSize, totalFileSize) {})
      //               .then((value) => {
      //                     resultCell = ReceiveImageMsgCell(
      //                         message: (value.message as ZIMImageMessage),
      //                         downloadingProgress: null,
      //                         downloadingProgressModel:
      //                             downloadingProgressModel),
      //                     _historyMessageWidgetList.value.add(resultCell),
      //                   });
      //         } else {
      //           ReceiveImageMsgCell resultCell = ReceiveImageMsgCell(
      //               message: message,
      //               downloadingProgress: null,
      //               downloadingProgressModel: null);
      //           _historyMessageWidgetList.value.add(resultCell);
      //         }

      //         break;
      //       case ZIMMessageType.video:
      //         if ((message as ZIMVideoMessage).fileLocalPath == "") {
      //           ReceiveVideoMsgCell resultCell;
      //           ZIM
      //               .getInstance()!
      //               .downloadMediaFile(message, ZIMMediaFileType.originalFile,
      //                   (message, currentFileSize, totalFileSize) {})
      //               .then((value) => {
      //                     resultCell = ReceiveVideoMsgCell(
      //                         message: value.message as ZIMVideoMessage,
      //                         downloadingProgressModel: null),
      //                     _historyMessageWidgetList.value.add(resultCell),
      //                   });
      //         } else {
      //           ReceiveVideoMsgCell resultCell = ReceiveVideoMsgCell(
      //               message: message, downloadingProgressModel: null);
      //           _historyMessageWidgetList.value.add(resultCell);
      //         }
      //         break;
      //       default:
      //     }
      //   }
      // };
    }

    unregisterZIMEvent() {
      ZIMEventHandler.onReceiveRoomMessage = null;
    }

    Future<void> startCall(ZegoCallType callType) async {
      final userIDList = roomID!.split(',');
      if (callType == ZegoCallType.video) {
        if (userIDList.length > 1) {
          ZegoCallManager()
              .sendGroupVideoCallInvitation(userIDList)
              .then((value) {})
              .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('send call invitation failed: $error')),
            );
          });
        } else {
          ZegoCallManager().sendVideoCallInvitation(roomID!).then((value) {
            final errorInvitees =
                value.info.errorInvitees.map((e) => e.userID).toList();
            if (errorInvitees.contains(roomID!)) {
              ZegoCallManager.instance.clearCallData();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('user is not online: $value')),
              );
            } else {
              ZegoCallController().pushToCallWaitingPage();
              // pushToCallWaitingPage();
            }
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('send call invitation failed: $error')),
            );
          });
        }
      } else {
        if (userIDList.length > 1) {
          ZegoCallManager()
              .sendGroupVoiceCallInvitation(userIDList)
              .then((value) {})
              .catchError((error) {});
        } else {
          ZegoCallManager().sendVoiceCallInvitation(roomID!).then((value) {
            final errorInvitees =
                value.info.errorInvitees.map((e) => e.userID).toList();
            if (errorInvitees.contains(roomID)) {
              ZegoCallManager.instance.clearCallData();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('user is not online: $value')),
              );
            } else {
              ZegoCallController().pushToCallWaitingPage();
              // pushToCallWaitingPage();
            }
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('send call invitation failed: $error')),
            );
          });
        }
      }
    }

    sendTextMessage(String message) async {
      count.value++;
      print("conversationID");
      ZIMTextMessage textMessage = ZIMTextMessage(message: message);
      textMessage.senderUserID = userID!;
      ZIMMessageSendConfig sendConfig = ZIMMessageSendConfig();
      _historyZIMMessageList.value.add(textMessage);

      SendTextMsgCell cell = SendTextMsgCell(message: textMessage);
      _historyMessageWidgetList.value.add(cell);
      try {
        ZIMMessageSentResult result = await ZIM.getInstance()!.sendMessage(
            textMessage,
            roomID!,
            ZIMConversationType.peer,
            sendConfig,
            ZIMMessageSendNotification(
                onMessageAttached: ((message) async {})));

        int index = _historyZIMMessageList.value
            .lastIndexWhere((element) => element == textMessage);
        _historyZIMMessageList.value[index] = result.message;
        // SendTextMsgCell cell =
        //     SendTextMsgCell(message: (result.message as ZIMTextMessage));

        // _historyMessageWidgetList.value[index] = cell;
      } on PlatformException catch (onError) {
        log('send error,code:' + onError.code + 'message:' + onError.message!);
        int index = _historyZIMMessageList.value
            .lastIndexWhere((element) => element == textMessage);
        _historyZIMMessageList.value[index].sentStatus =
            ZIMMessageSentStatus.failed;
        SendTextMsgCell cell = SendTextMsgCell(
            message: (_historyZIMMessageList.value[index] as ZIMTextMessage));
        _historyMessageWidgetList.value[index] = cell;
        // queryMoreHistoryMessageWidgetList();
      }
    }

    sendMediaMessage(String? path, ZIMMessageType messageType) async {
      if (path == null || path.isEmpty) {
        log('Error: File path is null or empty');
        return;
      }

      try {
        // Validate the file path
        final file = File(path);
        if (!await file.exists()) {
          log('Error: File does not exist at path $path');
          return;
        }
        // queryMoreHistoryMessageWidgetList();

        // Create media message
        ZIMMediaMessage mediaMessage =
            MsgConverter.mediaMessageFactory(path, messageType);
        mediaMessage.senderUserID = userID!;
        UploadingprogressModel uploadingprogressModel =
            UploadingprogressModel();

        // Create the message cell widget
        Widget sendMsgCell = MsgConverter.sendMediaMessageCellFactory(
            mediaMessage, uploadingprogressModel);

        // Add the media message to the history lists
        _historyZIMMessageList.value.add(mediaMessage);
        _historyMessageWidgetList.value.add(sendMsgCell);

        // Log the file local path
        log('File local path: ${mediaMessage.fileLocalPath}');

        // Set up the notification for media upload progress
        ZIMMediaMessageSendNotification notification =
            ZIMMediaMessageSendNotification(
          onMediaUploadingProgress: (message, currentFileSize, totalFileSize) {
            print("currentFileSize");
            print(currentFileSize);
            print('Upload progress: $currentFileSize / $totalFileSize');
            uploadingprogressModel.uploadingprogress!(
                message, currentFileSize, totalFileSize);
            count.value++;
          },
        );
        count.value++;

        // Send the media message
        ZIMMessageSentResult result = await ZIM.getInstance()!.sendMediaMessage(
              mediaMessage,
              roomID!,
              ZIMConversationType.peer,
              ZIMMessageSendConfig(),
              notification,
            );

        // Update the message list with the result
        int index = _historyZIMMessageList.value.indexOf(mediaMessage);
        Widget resultCell = MsgConverter.sendMediaMessageCellFactory(
            result.message as ZIMMediaMessage, null);
        _historyMessageWidgetList.value[index] = resultCell;

        log('Media message sent successfully');
      } on PlatformException catch (onError) {
        log('Error sending media message: ${onError.message}');
        int index = _historyZIMMessageList.value.last.messageID;
        _historyZIMMessageList.value[index].sentStatus =
            ZIMMessageSentStatus.failed;
        Widget failedCell = MsgConverter.sendMediaMessageCellFactory(
          _historyZIMMessageList.value[index] as ZIMMediaMessage,
          null,
        );
        _historyMessageWidgetList.value[index] = failedCell;
      } catch (error) {
        log('Unexpected error: $error');
      }
      queryMoreHistoryMessageWidgetList();
    }

    useEffect(() {
      registerZIMEvent();

      clearUnReadMessage();
      if (_historyZIMMessageList.value.isEmpty) {
        queryMoreHistoryMessageWidgetList();
      }
      return () {};
      // return () {};
    }, []);

    return Scaffold(
      appBar: BaseAppbar(
        title: "Room Chat",
        actionWidget: [
          IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, videoCallRoute, arguments: roomID);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => HomePage(),
                //     ));
                startCall(ZegoCallType.video);
              },
              icon: Icon(Icons.video_call))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: MsgList(_historyMessageWidgetList.value,
                  loadMoreHistoryMsg: queryMoreHistoryMessageWidgetList)),
          MsgNormalBottomBox(
            sendTextFieldonSubmitted: (message) {
              print("waahaha");
              var dataMap = {
                'summary': "12",
                "message": message,
                "type": "text",
                "time": DateTime.now().millisecondsSinceEpoch
              };
              print(dataMap);
              sendTextMessage(jsonEncode(dataMap));
              queryMoreHistoryMessageWidgetList();
            },
            onCameraIconButtonOnPressed: (path) {
              print("CAMERA");
              sendMediaMessage(path, ZIMMessageType.image);
            },
            onImageIconButtonOnPressed: (path) {
              print("IMAGE");

              sendMediaMessage(path, ZIMMessageType.image);
            },
            onVideoIconButtonOnPressed: (path) {
              print("VIDEO");

              sendMediaMessage(path, ZIMMessageType.video);
            },
          ),
        ],
      ),
    );
  }
}
