import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasabee7/screens/home_screen.dart';
import 'package:tasabee7/screens/isteghfar_screen.dart';
import 'package:tasabee7/screens/ta7meed_screen.dart';
import 'package:tasabee7/screens/takbeer_screen.dart';
import 'package:tasabee7/screens/tasbee7_screen.dart';
import 'package:tasabee7/utils/menu_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int totCounter = 0;

  @override
  void initState() {
    super.initState();
    _loadTotCounter();
  }

  // Load total counter from SharedPreferences by summing all individual counters
  _loadTotCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      int isteghfarCounter = prefs.getInt('isteghfar_counter') ?? 0;
      int ta7meedCounter = prefs.getInt('ta7meed_counter') ?? 0;
      int tasbee7Counter = prefs.getInt('counter') ?? 0; // Note: tasbee7 uses 'counter' key
      int takbeerCounter = prefs.getInt('takbeer_counter') ?? 0;

      totCounter = isteghfarCounter + ta7meedCounter + tasbee7Counter + takbeerCounter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "اختر نوع الذكر",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoBold',
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Color(0xfff8fafc),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => Ta7meedScreen()),
                    ).then((_) => _loadTotCounter()); // Refresh counter when returning
                  },
                  child: MenuButton(
                    color: Color(0xffe0f2fe),
                    text: "تحميد",
                    fSize: 28,
                    fFamily: 'Noto',
                    height: 140,
                    width: 140,
                    fWeight: FontWeight.bold,
                    fColor: Color(0xff3d99f5),
                  ),
                ),
                SizedBox(width: 15.w),
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => Tasbee7Screen()),
                    ).then((_) => _loadTotCounter()); // Refresh counter when returning
                  },
                  child: MenuButton(
                    color: Color(0xff3d99f5),
                    text: "تسبيح",
                    fSize: 28,
                    fFamily: 'Noto',
                    height: 140,
                    width: 140,
                    fWeight: FontWeight.bold,
                    fColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => IsteghfarScreen(),
                      ),
                    ).then((_) => _loadTotCounter()); // Refresh counter when returning
                  },
                  child: MenuButton(
                    color: Color(0xff3d99f5),
                    text: "استغفار",
                    fSize: 28,
                    fFamily: 'Noto',
                    height: 140,
                    width: 140,
                    fWeight: FontWeight.bold,
                    fColor: Colors.white,
                  ),
                ),
                SizedBox(width: 15.w),
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (builder) => TakbeerScreen()),
                    ).then((_) => _loadTotCounter()); // Refresh counter when returning
                  },
                  child: MenuButton(
                    color: Color(0xffe0f2fe),
                    text: "تكبير",
                    fSize: 28,
                    fFamily: 'Noto',
                    height: 140,
                    width: 140,
                    fWeight: FontWeight.bold,
                    fColor: Color(0xff3d99f5),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            Text(
              "عداد الذكر: $totCounter",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Noto',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}