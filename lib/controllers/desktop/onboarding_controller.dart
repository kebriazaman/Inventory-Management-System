import 'package:get/get.dart';
import 'package:pos_fyp/res/app_text/app_text.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';
import 'package:pos_fyp/res/routes/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  var currentPageIndex = 0.obs;
  final RxList<String> _imageList = [
    ImageAssets.posImage1,
    ImageAssets.posImage2,
    ImageAssets.posImage3,
  ].obs;
  final RxList<String> _titlesList = [
    AppText.onboardTitle1,
    AppText.onboardTitle2,
    AppText.onboardTitle3,
  ].obs;
  final RxList<String> _subtitlesList = [
    AppText.onboardPara1,
    AppText.onboardPara2,
    AppText.onboardPara3,
  ].obs;
  RxList<String> get getImageList => _imageList;
  RxList<String> get getTitlesList => _titlesList;
  RxList<String> get getSubtitlesList => _subtitlesList;

  void nextPage() async {
    if (currentPageIndex.value == _imageList.length - 1) {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setBool('showOnboardScreen', true);
      Get.offNamed(RouteName.loginScreen);
    } else {
      currentPageIndex += 1;
    }
  }
}
