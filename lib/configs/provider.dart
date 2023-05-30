import 'package:brg_management/module/ToDoList/ViewModel/todolist_vm.dart';
import 'package:brg_management/module/authen/change_password/view_model/change_password_vm.dart';
import 'package:brg_management/module/authen/sign_in/view_model/sign_in_vm.dart';
import 'package:brg_management/module/edit_profile/view_model/edit_profile_vm.dart';
import 'package:brg_management/module/authen/login/view_model/login_view_model.dart';
import 'package:brg_management/module/dashboard/view_model/dashboard_view_model.dart';
import 'package:brg_management/module/register_membership/view_model/register_membership_vm.dart';
import 'package:brg_management/module/settings/viewmodel/setting_vm.dart';
import 'package:brg_management/module/splash/view_model/splash_vm.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider;
import 'package:provider/single_child_widget.dart' show SingleChildWidget;

import '../module/home/view_model/home_vm.dart';
import '../module/project_list/view_model/project_list_vm.dart';
import '../module/project_list/view_model/task_list_vm.dart';

class AppProvider {
  static List<SingleChildWidget> _getAllProvider() {
    return [
      ChangeNotifierProvider<LoginViewModel>(
        create: (context) => LoginViewModel(),
      ),
      ChangeNotifierProvider<DashBoardViewModel>(
        create: (context) => DashBoardViewModel(),
      ),
      ChangeNotifierProvider<SettingsViewModel>(
        create: (context) => SettingsViewModel(),
      ),
      ChangeNotifierProvider<ChangePasswordViewModel>(
        create: (context) => ChangePasswordViewModel(),
      ),
      ChangeNotifierProvider<RegisterMemberShipViewModel>(
        create: (context) => RegisterMemberShipViewModel(),
      ),
      ChangeNotifierProvider<EditProfileViewModel>(
        create: (context) => EditProfileViewModel(),
      ),
      ChangeNotifierProvider<SignInViewModel>(
        create: (context) => SignInViewModel(),
      ),
      ChangeNotifierProvider<SplashViewModel>(
        create: (context) => SplashViewModel(),
      ),
      ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
      ),
      ChangeNotifierProvider<TodoListViewModel>(
        create: (context) => TodoListViewModel(),
      ),
      ChangeNotifierProvider<ProjectListViewModel>(
        create: (context) => ProjectListViewModel(),
      ),
      ChangeNotifierProvider<ProjectListViewModel>(
        create: (context) => ProjectListViewModel(),
      ),
      ChangeNotifierProvider<TaskListViewModel>(
        create: (context) => TaskListViewModel(),
      ),
    ];
  }

  static List<SingleChildWidget> getAll() => _getAllProvider();
}
