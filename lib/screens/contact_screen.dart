import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  // Social media links
  final String linkedinUrl = 'https://linkedin.com/in/hamdynashat';
  final String instagramUrl = 'https://instagram.com/its7amdon';
  final String telegramUrl = 'https://t.me/Its7amdon';

  // Function to launch URL
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff9fafb),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "تواصل معنا",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoBold',
              color: Colors.black,
              fontSize: 20.sp,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios, color: Color(0xFF374151)),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            children: [
              // Header section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Profile picture with CircleAvatar
                    Container(
                      width: 84.w, // Slightly larger to accommodate border
                      height: 84.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF3B82F6).withOpacity(0.3),
                            blurRadius: 10.r,
                            offset: Offset(0, 4.h),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2.w), // Border thickness
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundImage: AssetImage(
                            'lib/images/profile_picture.jpg',
                          ),
                          // Change this to your image path
                          backgroundColor: Colors.grey[200],
                          onBackgroundImageError: (exception, stackTrace) {
                            // Fallback if image fails to load
                            print('Failed to load profile image: $exception');
                          },
                          child: Container(), // Empty child to show image
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Developer name
                    Text(
                      "حمدي نشأت",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'NotoBold',
                        color: Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Developer title
                    Text(
                      "مطور التطبيق",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Noto',
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Contact message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10.r,
                      offset: Offset(0, 2.h),
                    ),
                  ],
                ),
                child: Text(
                  "يسعدني التواصل معك! تابعني على منصات التواصل الاجتماعي أو راسلني مباشرة",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Noto',
                    color: Color(0xFF374151),
                    height: 1.5,
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              // Social media buttons
              Column(
                children: [
                  _buildSocialButton(
                    icon: Icons.work,
                    label: "LinkedIn",
                    subtitle: "linkedin.com/in/hamdynashat",
                    color: Color(0xFF0077B5),
                    onTap: () => _launchUrl(linkedinUrl),
                  ),

                  SizedBox(height: 16.h),

                  _buildSocialButton(
                    icon: Icons.camera_alt,
                    label: "Instagram",
                    subtitle: "@its7amdon",
                    color: Color(0xFFE4405F),
                    onTap: () => _launchUrl(instagramUrl),
                  ),

                  SizedBox(height: 16.h),

                  _buildSocialButton(
                    icon: Icons.telegram,
                    label: "Telegram",
                    subtitle: "@Its7amdon",
                    color: Color(0xFF0088CC),
                    onTap: () => _launchUrl(telegramUrl),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // Footer
              Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Text(
                      "صُنع بحب ❤️",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Noto',
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "تطبيق تسابيح - للذكر والتسبيح",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontFamily: 'Noto',
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, size: 24.w, color: color),
            ),

            SizedBox(width: 16.w),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Noto',
                      color: Color(0xFF111827),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Noto',
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(Icons.arrow_forward_ios, size: 16.w, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }
}
