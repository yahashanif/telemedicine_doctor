import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_zim/zego_zim.dart';

import '../../model/user_model.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>(
    (ref) => LoginNotifier(ref: ref));

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref ref;
  LoginNotifier({required this.ref}) : super(LoginInitial());

  void login({required String username, required String userID}) async {
    ZIMUserInfo userInfo = ZIMUserInfo();
    state = LoginLoading();

    ZIMLoginConfig config = ZIMLoginConfig();
    config.token = '';
    config.userName = username;
    await ZIM.getInstance()!.login(userID, config);
    log('success');
    UserModel.shared().userInfo = userInfo;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userInfo.userID);
    await prefs.setString('userName', userInfo.userName);

    state = LoginSuccess();
  }
}

// 1.State
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {}

class BaseRepositoryException implements Exception {
  final String message;
  BaseRepositoryException({
    required this.message,
  });
}
