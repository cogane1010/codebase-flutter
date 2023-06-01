import 'package:brg_management/core/utils/app_color.dart';
import 'package:flutter/material.dart';

import '../../configs/app_localizations.dart';
import '../../configs/router.dart';
import '../../core/utils/screen_util.dart';
import '../../data/local/user_session.dart';
import '../../module/page/user_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final name = UserSession.instance.fullName;
    final urlImage = 'assets/png/brg_icon.png';

    return Drawer(
      child: Material(
        color: AppColor.redBRG,
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(
                  name: name,
                  urlImage: urlImage,
                ),
              )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 0),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!.translate('to_do_list'),
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 0),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!
                        .translate('danh_sach_du_an'),
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 0),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!
                        .translate('duyet_cong_viec'),
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 0),
                  buildMenuItem(
                    text: AppLocalizations.of(context)!
                        .translate('duyet_tien_do'),
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 130),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 10),
                  buildBottomMenuItem(
                    text: AppLocalizations.of(context)!.translate('logout'),
                    icon: Icons.logout,
                    onClicked: () => logout(context, 4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    VoidCallback? onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 20)),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 20, backgroundImage: ExactAssetImage(urlImage)),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
              Spacer(),
              Icon(Icons.add_comment_outlined, color: Colors.white)
            ],
          ),
        ),
      );

  // Widget buildSearchField() {
  //   final color = Colors.white;

  //   return TextField(
  //     style: TextStyle(color: color),
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //       hintText: 'Search',
  //       hintStyle: TextStyle(color: color),
  //       prefixIcon: Icon(Icons.search, color: color),
  //       filled: true,
  //       fillColor: Colors.white12,
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildMenuItem({
    required String text,
    IconData? icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      //leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        ScreenUtils.openScreenWithData(context, AppRouter.todoList,
            {'moduleName': 'project', 'toDoListType': ''});
        break;
      case 1:
        ScreenUtils.openScreenWithData(context, AppRouter.projectListWidget, {
          'moduleName': 'project',
          'toDoListType': 'ProjectPending',
          'isMenu': true
        });
        break;
      case 2:
        ScreenUtils.openScreenWithData(context, AppRouter.taskListWidget, {
          'moduleName': 'project',
          'toDoListType': 'ListProcessingApproval',
          'isMenu': true
        });
        break;
      case 3:
        ScreenUtils.openScreenWithData(context, AppRouter.taskListWidget, {
          'moduleName': 'project',
          'toDoListType': 'ListProgressApproval',
          'isMenu': true
        });
        break;
    }
  }

  void logout(BuildContext context, int index) {
    Navigator.of(context).pop();
    UserSession.instance.token = '';

    ScreenUtils.closeScreen(context);
    ScreenUtils.openScreenAndRemoveUtil(context, AppRouter.login);
    // Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => PeoplePage(),
    //     ));
  }

  Widget buildBottomMenuItem({
    required String text,
    IconData? icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
