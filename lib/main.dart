// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:nytimes/features/news_detail/news_detail_view_model.dart';
import 'package:provider/provider.dart';
import 'features/home/home_page.dart';
import 'features/home/home_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //: const Size(375, 812),
      // minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<HomeViewModel>(
                create: (_) => HomeViewModel()),
            ChangeNotifierProvider<NewsDetailViewModel>(
                create: (_) => NewsDetailViewModel()),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'satoshi-regular',
            ),
            home: const HomePage(),
          ),
        );
      },
    );
  }
}
