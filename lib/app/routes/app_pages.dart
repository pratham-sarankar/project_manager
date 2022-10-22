import 'package:get/get.dart';
import 'package:project_manager/app/modules/tasks/task_details/bindings/task_details_binding.dart';
import 'package:project_manager/app/modules/tasks/task_details/views/task_details_view.dart';

import '../data/repositories/user_repository.dart';
import '../modules/auth/get_started/bindings/get_started_binding.dart';
import '../modules/auth/get_started/views/get_started_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/otp/bindings/otp_binding.dart';
import '../modules/auth/otp/views/otp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/projects/add_project/bindings/add_project_binding.dart';
import '../modules/projects/add_project/views/add_project_view.dart';
import '../modules/projects/project/bindings/project_binding.dart';
import '../modules/projects/project/views/project_view.dart';
import '../modules/projects/project_details/bindings/project_details_binding.dart';
import '../modules/projects/project_details/views/project_details_view.dart';
import '../modules/projects/project_priorities/bindings/project_priorities_binding.dart';
import '../modules/projects/project_priorities/views/project_priorities_view.dart';
import '../modules/projects/project_statuses/bindings/project_statuses_binding.dart';
import '../modules/projects/project_statuses/views/project_statuses_view.dart';
import '../modules/tasks/add_task/bindings/add_task_binding.dart';
import '../modules/tasks/add_task/views/add_task_view.dart';
import '../modules/tasks/task_priorities/bindings/task_priorities_binding.dart';
import '../modules/tasks/task_priorities/views/task_priorities_view.dart';
import '../modules/tasks/task_status/bindings/task_status_binding.dart';
import '../modules/tasks/task_status/views/task_status_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static final INITIAL = Routes.PROJECT;
  static final INITIAL =
      UserRepository.instance.isLoggedIn ? Routes.HOME : Routes.GET_STARTED;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GET_STARTED,
      page: () => const GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PROJECT,
      page: () => const AddProjectView(),
      binding: AddProjectBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT,
      page: () => const ProjectView(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TASK,
      page: () => const AddTaskView(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT_DETAILS,
      page: () => const ProjectDetailsView(),
      binding: ProjectDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT_PRIORITIES,
      page: () => const ProjectPrioritiesView(),
      binding: ProjectPrioritiesBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT_STATUSES,
      page: () => const ProjectStatusesView(),
      binding: ProjectStatusesBinding(),
    ),
    GetPage(
      name: _Paths.TASK_STATUS,
      page: () => const TaskStatusView(),
      binding: TaskStatusBinding(),
    ),
    GetPage(
      name: _Paths.TASK_PRIORITIES,
      page: () => const TaskPrioritiesView(),
      binding: TaskPrioritiesBinding(),
    ),
    GetPage(
      name: _Paths.TASK_DETAILS,
      page: () => const TaskDetailsView(),
      binding: TaskDetailsBinding(),
    ),
  ];
}
