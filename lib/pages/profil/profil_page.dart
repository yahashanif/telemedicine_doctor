import 'package:flutter/material.dart';

import '../../app/constant.dart';
import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../zego_sdk_manager.dart';
import 'card_menu_profile.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppbar(title: "Profil"),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: getActualX(x: defaultMargin, context: context)),
        children: [
          SizedBox(
            height: getActualY(y: defaultMargin, context: context),
          ),
          Container(
            height: getActualY(context: context, y: 100),
            child: Center(
              child: Container(
                height: getActualY(context: context, y: 120),
                width: getActualX(context: context, x: 120),
                decoration: BoxDecoration(
                    color: netralColor30,
                    // image:
                    //     DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.person,
                  size: getActualY(y: 50, context: context),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: getActualY(context: context, y: 8),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getActualX(context: context, x: 32)),
                child: Text(
                  ZEGOSDKManager().currentUser!.userName,
                  maxLines: 2,
                  style: textLargeMedium(context: context).copyWith(
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              SizedBox(
                height: getActualY(context: context, y: defaultMargin),
              ),
              CardMenu(
                onTap: () {
                  // Navigator.pushNamed(context, helpRoute);
                },
                icon: Icons.help,
                title: "Help",
              ),
              CardMenu(
                onTap: () {},
                icon: Icons.settings,
                title: "Setting",
              ),
              CardMenu(
                onTap: () {
                  ZEGOSDKManager().disconnectUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, loginRoute, (route) => false);
                  // Navigator.pushNamed(context, helpRoute);
                },
                icon: Icons.logout,
                title: "Logout",
              ),
            ],
          )
        ],
      ),
    );
  }
}
