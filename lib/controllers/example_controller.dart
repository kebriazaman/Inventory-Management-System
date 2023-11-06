// import 'package:get/get.dart';
// import 'package:pos_fyp/data/response/status.dart';
// import 'package:pos_fyp/models/user_list_model.dart';
// import 'package:pos_fyp/repo/example_view_repository.dart';

// class ExampleViewController extends GetxController {
//   final _apiService = ExampleViewRepository();

//   final requestStatus = Status.LOADING.obs;
//   final userList = UserListModel().obs;

//   void setRequestStatus(Status status) => requestStatus.value = status;
//   void setUserList(UserListModel userListModel) => userList.value = userListModel;

//   @override
//   void onInit() {
//     super.onInit();
//     userListApi();
//   }

//   void userListApi() {
//     _apiService.userApi().then((value) {
//       setRequestStatus(Status.COMPLETED);
//       setUserList(value);
//     }).onError((error, stackTrace) {
//       setRequestStatus(Status.ERROR);
//     });
//   }
// }
