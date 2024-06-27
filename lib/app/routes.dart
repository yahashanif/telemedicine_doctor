import 'package:flutter/material.dart';

import '../pages/call/waiting_page.dart';
import '../pages/chat/list_chat_page/list_chat_page.dart';
import '../pages/chat/room_chat/room_chat_page.dart';
import '../pages/login/login_page.dart';
import '../pages/main_page.dart';
import '../pages/splash/splash_screen.dart';
import '../zego_sdk_manager.dart';

const splashRoute = '/';
const mainRoute = '/main';
const loginRoute = '/login';
const listChatRoute = '/list-chat';
const roomChatRoute = '/room-chat';
const videoCallRoute = '/video-call';

class AppRoute {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
            builder: (context) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: const SplashScreen()));
      case loginRoute:
        return MaterialPageRoute(
            builder: (context) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: LoginPage()));
      case mainRoute:
        return MaterialPageRoute(
            builder: (context) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: const MainPage()));
      case listChatRoute:
        return MaterialPageRoute(
            builder: (context) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: const ListPageChat()));
      case roomChatRoute:
        return MaterialPageRoute(
            builder: (context) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: const RoomChatPage()));
      case videoCallRoute:
        ZegoCallData? argumen;
        return MaterialPageRoute(
            builder: (context) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: CallWaitingPage(callData: argumen!)));
      default:
        return MaterialPageRoute(
            builder: (context) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: const Scaffold()));
    }
  }
}
