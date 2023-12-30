import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:pos_fyp/controllers/mobile/side_bar_controller.dart';
import 'package:pos_fyp/res/app_color.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:pos_fyp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final SideBarController sideBarController = Get.put(SideBarController());
    return Scaffold(
      key: sideBarController.key,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              sideBarController.key.currentState?.openDrawer();
            }),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () async {
              ParseUser? user = await ParseUser.currentUser();
              if (user != null) {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                await preferences.remove('email');
                await preferences.remove('password');
                await preferences.remove('isChecked');
                ParseResponse response = await user.logout();
                if (response.success && response.results != null) {
                  Get.offNamed(RouteName.loginScreen);
                  Utils.showSnackBarMessage('Logged out', 'You have successfully logged out', Icons.logout);
                } else {
                  Utils.showSnackBarMessage('Error', response.error!.message, Icons.add_alert);
                }
              }
            },
          )
        ],
      ),
      drawer: SidebarX(
        controller: sideBarController.sidebarXController,
        headerBuilder: (context, extended) => const SizedBox(height: 80, child: Icon(Icons.person)),
        extendedTheme: const SidebarXTheme(width: 200),
        theme: const SidebarXTheme(
            itemTextPadding: EdgeInsets.only(left: 30.0),
            selectedItemTextPadding: EdgeInsets.only(left: 30.0),
            iconTheme: IconThemeData(color: AppColors.blackColor),
            selectedTextStyle: TextStyle(color: AppColors.blackColor),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)))),
        footerDivider: const Divider(color: AppColors.greyColor),
        headerDivider: const Divider(color: AppColors.greyColor),
        items: sideBarController.sidebarItems,
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: sideBarController.sidebarXController,
          builder: (context, child) {
            return sideBarController.screensList[sideBarController.sidebarXController.selectedIndex];
          },
        ),
      ),
    );
  }
}
