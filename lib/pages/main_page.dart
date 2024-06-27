import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app/constant.dart';
import '../app/theme.dart';
import 'chat/list_chat_page/list_chat_page.dart';
import 'profil/profil_page.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = useState(0);
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(offset: Offset(1, 0))], color: Colors.white),
        height: getActualY(y: 60, context: context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                selectedPage.value = 0;
              },
              icon: Icon(
                Icons.home,
                color:
                    selectedPage.value == 0 ? primaryMainColor : netralColor40,
              ),
            ),
            IconButton(
              onPressed: () {
                selectedPage.value = 1;
              },
              icon: Icon(
                Icons.person,
                color:
                    selectedPage.value == 1 ? primaryMainColor : netralColor40,
              ),
            )
          ],
        ),
      ),
      body: selectedPage.value == 0 ? ListPageChat() : ProfilPage(),
    );
  }
}
