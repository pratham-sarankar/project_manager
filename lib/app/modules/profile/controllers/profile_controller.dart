import 'package:get/get.dart';
import 'package:project_manager/app/data/repositories/user_repository.dart';

class ProfileController extends GetxController {
  late RxString photoUrl;
  @override
  void onInit() {
    photoUrl = (UserRepository.instance.currentUser?.photoURL ??
            'https://i.stack.imgur.com/34AD2.jpg')
        .obs;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
