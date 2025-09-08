import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasabee7/screens/achievements_screen.dart';
import 'package:tasabee7/screens/menu_screen.dart';
import 'package:tasabee7/screens/contact_screen.dart'; // Add this import
import 'package:tasabee7/utils/menu_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff9fafb),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "أهلًا بك في تسابيح",
              style: TextStyle(fontSize: 30, fontFamily: 'NotoBold'),
            ),
            SizedBox(height: 20.h),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => MenuScreen()),
                  );
                },
                child: MenuButton(
                  color: Color(0xff3b82f6),
                  text: "ابدأ",
                  fSize: 26,
                  fFamily: "Noto",
                  height: 150,
                  width: 150,
                  fWeight: FontWeight.bold,
                  fColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => AchievementsScreen()),
                );
              },
              child: Container(
                height: 40.h,
                width: 100.w,
                child: Center(
                  child: Text(
                    "الإنجازات",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontSize: 16,
                      color: Color(0xff3b82f6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.fromBorderSide(
                    BorderSide(color: Color(0xff3b82f6)),
                  ),
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
            ),
            SizedBox(height: 15.h), // Space between buttons
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => ContactScreen()),
                );
              },
              child: Container(
                height: 40.h,
                width: 120.w, // Slightly wider for the longer text
                child: Center(
                  child: Text(
                    "تواصل معنا",
                    style: TextStyle(
                      fontFamily: 'Noto',
                      fontSize: 16,
                      color: Color(0xff10b981), // Green color to differentiate
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.fromBorderSide(
                    BorderSide(color: Color(0xff10b981)), // Green border
                  ),
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
            ),
            SizedBox(width: double.infinity.w),
          ],
        ),
      ),
    );
  }
}
