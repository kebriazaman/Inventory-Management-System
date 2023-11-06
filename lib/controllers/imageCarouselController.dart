import 'package:get/get.dart';
import 'package:pos_fyp/res/assets/image_assets.dart';

class ImageCarouselController extends GetxController {
  var currentIndex = 0.obs;

  final List<String> imageList = [
    ImageAssets.posImage1,
    ImageAssets.posImage2,
    ImageAssets.posImage3,
  ];

  final List<String> textList = [
    'Manage your Store easily',
    'Deal your customer fast.',
    'Be aware about your store\'s information.',
  ];
}
