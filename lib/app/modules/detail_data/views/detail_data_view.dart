import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:spisymobile_test/app/config/constant.dart';
import 'package:spisymobile_test/app/config/function_utils.dart';
import 'package:spisymobile_test/app/controllers/database_controller.dart';
import 'package:spisymobile_test/app/global_components/default_form_field.dart';
import 'package:spisymobile_test/app/global_components/default_text.dart';
import 'package:spisymobile_test/app/modules/detail_data/controllers/detail_data_cubit.dart';
import 'package:uuid/uuid.dart';

import '../../../data_models/user_model.dart';
import '../controllers/detail_data_controller.dart';

class DetailDataView extends GetView<DetailDataController> {
  const DetailDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(DetailDataController());
    logKey('di view', controller.arg.value);
    // var arg = Get.arguments();
    // logKey('arg', arg);
    // print(arg);

    // final initData = UserModel.init();
    final detailDataCubit = DetailDataCubit(controller.arg.value);
    return Scaffold(
      floatingActionButton: Obx(
        () => Visibility(
          visible: !controller.isEdit.value,
          replacement: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(
                  Icons.edit,
                ),
                onPressed: () async {
                  final id = detailDataCubit.state.uuid;
                  await controller.dbController.updateUser(detailDataCubit.state);
                  await controller.dbController.getAllUsers(refreshList: true);
                  Get.back();
                },
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                child: Icon(Icons.delete),
                onPressed: () async {
                  final id = detailDataCubit.state.uuid;
                  await controller.dbController.deleteUser(id);
                  await controller.dbController.getAllUsers(refreshList: true);
                  Get.back();
                  logKey('id', id);
                },
              ),
            ],
          ),
          child: FloatingActionButton(
            child: const Icon(
              Icons.save,
            ),
            onPressed: () async {
              final data = detailDataCubit.state;
              if (controller.isEdit.value) {
                return;
              }
              final uuid = Uuid().v4();
              data.uuid = uuid;
              await controller.dbController.createUser(data: data);
              await controller.dbController.getAllUsers(refreshList: true);
              Get.back(
                result: true,
              );
              // final data = detailDataCubit.state.toJson();
            },
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('DetailDataView'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            BlocConsumer<DetailDataCubit, UserModel>(
              bloc: detailDataCubit,
              listener: (context, state) {},
              builder: (context, state) {
                logKey('state name', state.toJson());
                return DefaultFormField(
                  hint: 'Name',
                  initialValue: state.name,
                  onChanged: (v) {
                    logKey('onChanged', v);
                    detailDataCubit.onChangedName(v);
                  },
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: BlocConsumer<DetailDataCubit, UserModel>(
                    bloc: detailDataCubit,
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    buildWhen: (a, b) {
                      logKey('prev', a.toJson());
                      logKey('after', a.toJson());
                      return true;
                    },
                    builder: (context, state) {
                      return BlocConsumer<DetailDataCubit, UserModel>(
                        bloc: detailDataCubit,
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () async {
                              final res = await Get.dialog(
                                DatePickerDialog(
                                  firstDate: DateTime(1945, 17, 8),
                                  lastDate: DateTime.now(),
                                  initialDate: state.birthDate,
                                ),
                              );
                              logKey('res datepicker', res);
                              if (isEmpty(res)) {
                                return;
                              }
                              detailDataCubit.changeBirthDate(res);
                            },
                            child: AbsorbPointer(
                              child: DefaultFormField(
                                hint: dateFormater(
                                  state.birthDate,
                                  dateFormat: 'dd MMMM yyyy',
                                ),
                                enabled: false,
                                onChanged: (v) {},
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Container(
                    child: BlocConsumer<DetailDataCubit, UserModel>(
                      bloc: detailDataCubit,
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return DefaultFormField(
                          hint: 'Age : ${state.age}',
                          enabled: false,
                          onChanged: (v) {},
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: BlocBuilder<DetailDataCubit, UserModel>(
                    bloc: detailDataCubit,
                    builder: (context, state) {
                      return DropdownButton(
                        padding: EdgeInsets.zero,
                        borderRadius: kDefaultBorderRadius10,
                        value: state.gender,
                        items: [
                          DropdownMenuItem(
                            child: DefText('Male').normal,
                            value: true,
                          ),
                          DropdownMenuItem(
                            child: DefText('Female').normal,
                            value: false,
                          )
                        ],
                        onChanged: (v) {
                          detailDataCubit.changeGender(v!);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            BlocConsumer<DetailDataCubit, UserModel>(
              bloc: detailDataCubit,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return DefaultFormField(
                  hint: 'Address',
                  initialValue: state.address,
                  onChanged: (v) {
                    detailDataCubit.onChangedAddres(v);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
