// import 'package:get/get.dart';
// import 'package:pos_fyp/repo/login_repository/login_repository.dart';
// import 'package:pos_fyp/utils/utils.dart';
//
// class LoginController extends GetxController {
//   var _api = LoginRepository();
//   var isLoading = false.obs;
//
//   void loginApi() {
//     isLoading.value = true;
//
//     Map data = {
//       'email': '',
//       'password': '',
//     };
//
//     _api.loginApi(data).then(
//       (value) {
//         isLoading.value = false;
//         Utils.showSnackBarMessage('Login', 'Login Sucessfully');
//       },
//     ).onError(
//       (error, stackTrace) {
//         isLoading.value = false;
//         Utils.showSnackBarMessage('Error', error.toString());
//       },
//     );
//   }
// }
