import 'package:brg_management/data/local/user_session.dart';
import 'package:brg_management/module/ToDoList/Screen/todolist_screen.dart';
import 'package:brg_management/module/authen/change_password/screen/change_password_screen.dart';
import 'package:brg_management/module/authen/login/screen/login_screen.dart';
import 'package:brg_management/module/authen/sign_in/screen/sign_in_screen.dart';
import 'package:brg_management/module/dashboard/screen/dashboard_screen.dart';
import 'package:brg_management/module/edit_profile/screen/edit_profile_screen.dart';
import 'package:brg_management/module/register_membership/screen/register_membership_screen.dart';
import 'package:brg_management/module/settings/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/utils/isEmpty.dart';
import '../core/utils/screen_util.dart';
import '../module/project_list/screen/approve_adjust_project_screen.dart';
import '../module/project_list/screen/approve_detail_project_screen.dart';
import '../module/project_list/screen/detail_project_screen.dart';
import '../module/project_list/screen/detail_project_task_screen.dart';
import '../module/project_list/screen/detail_task_screen.dart';
import '../module/project_list/screen/project_list_widget.dart';
import '../module/project_list/screen/task_list_widget.dart';

class AppRouter {
  static String demo = '/demo';
  static String login = '/login';
  static String dashboard = '/dashboard';
  static String setting = '/settings';
  static String changePassword = '/changePassword';
  static String notification = '/notification';
  static String registerMemberShip = '/registerMemberShip';
  static String editProfile = '/editProfile';
  static String detailProject = '/detailProject';
  static String detailTask = '/detailTask';
  static String detailProjectTask = '/detailProjectTask';
  static String signIn = '/signIn';
  static String todoList = '/todoList';
  static String projectListWidget = '/projectListWidget';
  static String taskListWidget = '/taskListWidget';
  static String itemTaskWidget = '/itemTaskWidget';
  static String detailTaskWidget = '/detailTaskWidget';
  static String adjustProjectWidget = '/adjustProjectWidget';

  static final Map<String, WidgetBuilder> appRouter = {};

  static void configRouter() {
    /// example
    appRouter[login] = (ctx) => LoginScreen();
    appRouter[dashboard] = (ctx) => DashBoardScreen();
    appRouter[setting] = (ctx) => SettingsScreen();
    appRouter[changePassword] = (ctx) => ChangePasswordScreen();
    appRouter[registerMemberShip] = (ctx) => RegisterMemberShipScreen();
    appRouter[editProfile] = (ctx) => EditProfileScreen();
    appRouter[signIn] = (ctx) => SignInScreen();
    appRouter[todoList] = (ctx) => TodoListScreen();
    appRouter[projectListWidget] = (ctx) => ProjectListWidget();
    appRouter[detailProject] = (ctx) => DetailProjectScreen();
    appRouter[detailTask] = (ctx) => DetailProjectTasikScreen();
    appRouter[detailProjectTask] = (ctx) => DetailTaskScreen();
    appRouter[taskListWidget] = (ctx) => TaskListWidget();
    appRouter[detailTaskWidget] = (ctx) => ApproveDetailProjectScreen();
    appRouter[adjustProjectWidget] = (ctx) => ApproveAdjustProjectScreen();
  }

  static void inAppRouting() {
    BuildContext context = Get.context!;
    // ScreenUtils.openScreenAndRemoveUtil(context, AppRouter.login);

    if (!isEmpty(UserSession.instance.token)) {
      Navigator.of(Get.context!).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => DashBoardScreen(
                    indexPage: 2,
                  )),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(Get.context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }

    // UserViewModel userVm = Provider.of<UserViewModel>(context, listen: false);
    // if (userVm.isLoggedIn()) {
    //   String routeName = userVm.inAppRouting['route_name'];
    //   if (routeName == 'car_detail') {
    //     CarCarpla car = userVm.inAppRouting['car'];
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => Login(
    //             car: car,
    //           ), settings: RouteSettings(name: '/$routeName')
    //       ),
    //     );
    //   }
    //   // clear in app routing = {}
    //   // NOTE: be careful because in app routing will be clear before navigator push
    //   userVm.inAppRouting = {};
    // }
  }

  static void silentRouting(Map<dynamic, dynamic> routing) {
    if (routing['task_name'] == 'a_channel') {
      // register success event

      // TODO: set user auto login to storage here

      Navigator.of(Get.context!).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => DashBoardScreen(
                    indexPage: 2,
                  )),
          (Route<dynamic> route) => false);
    } else if (routing['task_name'] == 'a_channel_2') {
      // fail to create marketplace user

    } else if (routing['task_name'] == 'a_channel_3') {
      ScreenUtils.openScreenAndRemoveUtil(Get.context!, AppRouter.login);
    }
  }
}
