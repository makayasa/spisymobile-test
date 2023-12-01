import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:spisymobile_test/app/bloc/list_users_cubit.dart';
import 'package:spisymobile_test/app/config/constant.dart';
import 'package:spisymobile_test/app/controllers/database_controller.dart';
import 'package:spisymobile_test/app/data_models/user_model.dart';
import 'package:spisymobile_test/app/global_components/default_button.dart';
import 'package:spisymobile_test/app/global_components/default_text.dart';
import 'package:spisymobile_test/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Get.toNamed(Routes.DETAIL_DATA);
        },
      ),
      body: Column(
        children: [
          TabBar(
            controller: controller.tabController,
            tabs: [
              Tab(
                child: Center(
                  child: Container(
                    child: DefText('Tab 1').normal,
                  ),
                ),
              ),
              Tab(
                child: Center(
                  child: Container(
                    child: DefText('Tab 2').normal,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: [
                BlocConsumer<ListUsersCubit, List<UserModel>>(
                  bloc: context.read<ListUsersCubit>(),
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 10),
                        itemCount: state.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: kDefaultBorderRadius10,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DefText(
                                      state[index].name,
                                    ).normal,
                                    SizedBox(height: 5),
                                    DefText(
                                      state[index].address.toString(),
                                    ).normal,
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                  ),
                                  onPressed: () {
                                    Get.toNamed(
                                      Routes.DETAIL_DATA,
                                      arguments: {
                                        'is_edit': true,
                                        'data': state[index],
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Container(
                  child: Center(
                    // child: DefText('ini tab 2').large,
                    child: DefaultButton(
                      text: 'Logout',
                      onTap: () {
                        Get.defaultDialog(
                          textConfirm: 'Ok',
                          middleText: 'Anda yakin ingin logout ?',
                          onConfirm: () {
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          textCancel: 'Cancel',
                          onCancel: () {
                            Get.back();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('HomeView'),
//         centerTitle: true,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final c = Get.find<DatabaseController>();
//           // c.dropTable();
//           await c.dummyInsert();
//           c.getAllUsers();
//         },
//       ),
//       body: TabBar(
//         tabs: [
//           Tab(
//             child: Center(
//               child: Container(
//                 child: DefText('Tab 1').normal,
//               ),
//             ),
//           ),
//           Tab(
//             child: Center(
//               child: Container(
//                 child: DefText('Tab 2').normal,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
