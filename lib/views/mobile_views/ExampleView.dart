// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pos_fyp/controllers/example_controller.dart';
// import 'package:pos_fyp/data/app_exceptions.dart';
// import 'package:pos_fyp/data/response/status.dart';
// import 'package:pos_fyp/res/components/general_exception_widget.dart';

// class ExampleView extends StatelessWidget {
//   const ExampleView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return GeneralExceptionWidget();
//     final exampleController = Get.put(ExampleViewController());
//     return Scaffold(
//       body: SafeArea(
//         child: Obx(
//           () {
//             switch (exampleController.requestStatus.value) {
//               case Status.LOADING:
//                 print('loading');
//                 return const Center(child: CircularProgressIndicator());
//               case Status.COMPLETED:
//                 return ListView.builder(
//                   itemCount: exampleController.userList.value.data!.length,
//                   itemBuilder: (context, index) {
//                     print(index);
//                     return ListTile(
//                       title: Text(exampleController.userList.value.data![index].firstName!),
//                       subtitle: Text(exampleController.userList.value.data![index].email!),
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(exampleController.userList.value.data![index].avatar!),
//                       ),
//                       trailing: Text(exampleController.userList.value.data![index].id.toString()),
//                     );
//                   },
//                 );
//               case Status.ERROR:
//                 return Center(
//                   child: Text(
//                     InternetException('').toString(),
//                   ),
//                 );
//               default:
//                 return const Center(child: Text('No Value returned'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
