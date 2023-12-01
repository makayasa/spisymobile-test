import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:spisymobile_test/app/bloc/list_users_cubit.dart';
import 'package:spisymobile_test/app/config/global_bindings.dart';

import 'app/modules/detail_data/controllers/detail_data_cubit.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en_US');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListUsersCubit(),
        ),
        // BlocProvider(
        //   create: (context) => DetailDataCubit(),
        // ),
      ],
      child: GetMaterialApp(
        title: "Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        initialBinding: GlobalBindings(),
      ),
    ),
  );
}
