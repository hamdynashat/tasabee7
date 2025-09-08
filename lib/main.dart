import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasabee7/screens/home_screen.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen(),
    builder: (ctx, child) {
      ScreenUtil.init(ctx);
      return child!;
    },
    );
  }
}

