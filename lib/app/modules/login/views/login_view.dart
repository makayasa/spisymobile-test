import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:spisymobile_test/app/config/constant.dart';
import 'package:spisymobile_test/app/config/function_utils.dart';
import 'package:spisymobile_test/app/global_components/default_text.dart';
import 'package:spisymobile_test/app/modules/login/controllers/login_cubit.dart';
import 'package:spisymobile_test/app/routes/app_pages.dart';

import '../../../global_components/default_button.dart';
import '../../../global_components/default_form_field.dart';
import '../controllers/login_controller.dart';

// class LoginView extends GetView<LoginController> {
//   const LoginView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('LoginView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'LoginView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = LoginCubit();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            DefaultFormField(
              initialValue: kDefaultUsername,
              onChanged: (v) {
                loginCubit.onChangedUsername(v);
              },
              hint: 'Username',
            ),
            SizedBox(height: 20),
            DefaultFormField(
              masText: true,
              initialValue: kDefaultPssword,
              onChanged: (v) {
                loginCubit.onChangePassword(v);
              },
              hint: 'Password',
            ),
            SizedBox(height: 20),
            BlocConsumer<LoginCubit, Map>(
              bloc: loginCubit,
              listener: (context, state) {},
              builder: (context, state) {
                return DefaultButton(
                  text: 'Login',
                  onTap: () {
                    if (isEmpty(state['username']) || isEmpty(isEmpty)) {
                      Get.defaultDialog(middleText: 'Username dan password tidak boleh kosong');
                      return;
                    }
                    if (state['username'] != kDefaultUsername && state['password'] != kDefaultPssword) {
                      Get.defaultDialog(
                        middleText: 'Username atau password salah'
                      );
                      return;
                    }
                    Get.offNamed(Routes.HOME);
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
