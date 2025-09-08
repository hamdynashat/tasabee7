import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  Map<String, bool> unlockedAchievements = {};
  Map<String, int> counters = {};

  // Achievement milestones
  final List<int> milestones = [100, 1000, 5000, 10000, 20000, 50000, 100000, 500000, 1000000];

  // Achievement data structure
  final Map<String, Map<String, dynamic>> achievementTypes = {
    'tasbee7': {
      'name': 'التسبيح',
      'color': Color(0xFF3B82F6),
      'counterKey': 'counter',
    },
    'takbeer': {
      'name': 'التكبير',
      'color': Color(0xFF8B5CF6),
      'counterKey': 'takbeer_counter',
    },
    'ta7meed': {
      'name': 'التحميد',
      'color': Color(0xFF10B981),
      'counterKey': 'ta7meed_counter',
    },
    'isteghfar': {
      'name': 'الاستغفار',
      'color': Color(0xFFEF4444),
      'counterKey': 'isteghfar_counter',
    },
    'total': {
      'name': 'الإجمالي',
      'color': Color(0xFFF59E0B),
      'counterKey': 'total_counter',
    },
  };

  // Unique achievement names for each type and milestone
  final Map<String, Map<int, String>> achievementNames = {
    'tasbee7': {
      100: 'بداية النور',
      1000: 'محبٌ للتسبيح',
      5000: 'لسان ذاكر',
      10000: 'لسانٌ منوَّر',
      20000: 'قلبٌ منزَّه',
      50000: 'روحٌ نقية',
      100000: 'دائمُ التسبيح',
      500000: 'بحرُ التسبيح',
      1000000: 'تاجُ المسبحين',
    },
    'takbeer': {
      100: 'بداية التعظيم',
      1000: 'لسانٌ مكبِّر',
      5000: 'عبدٌ معظِّم',
      10000: 'روحٌ مكبِّرة',
      20000: 'رايةُ التعظيم',
      50000: 'سابق بالتكبير',
      100000: 'رايةُ المجد',
      500000: 'عزمُ الأبطال',
      1000000: 'تاجُ المكبرين',
    },
    'ta7meed': {
      100: 'بداية الشكر',
      1000: 'لسانُ الحامد',
      5000: 'قلبٌ شاكر',
      10000: 'روحٌ حامدة',
      20000: 'من أهل الحمد',
      50000: 'محبُ الحمد',
      100000: 'حامل الحمد',
      500000: 'بحر الشكر',
      1000000: 'تاجُ الحامدين',
    },
    'isteghfar': {
      100: 'بدايةُ الغفران',
      1000: 'طالبُ الصفح',
      5000: 'قلبٌ تائب',
      10000: 'روحٌ منكسرة',
      20000: 'عبدٌ مستغفر',
      50000: 'من أهلِ الإنابة',
      100000: 'روحٌ نقَّاءة',
      500000: 'بحرُ الاستغفار',
      1000000: 'تاجُ المستغفرين',
    },
    'total': {
      100: 'بداية النور',
      1000: 'محب الذِكر',
      5000: 'لسان ذاكر',
      10000: 'قلبٌ خاشع',
      20000: 'روحٌ مطمئنة',
      50000: 'سابق بالخيرات',
      100000: 'رصيد الجنة',
      500000: 'باغِ الفردوس',
      1000000: 'تاج الذاكرين',
    },
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadCounters();
    await _loadAchievements();
    _checkAndUnlockAchievements();
  }

  Future<void> _loadCounters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counters['counter'] = prefs.getInt('counter') ?? 0;
      counters['takbeer_counter'] = prefs.getInt('takbeer_counter') ?? 0;
      counters['ta7meed_counter'] = prefs.getInt('ta7meed_counter') ?? 0;
      counters['isteghfar_counter'] = prefs.getInt('isteghfar_counter') ?? 0;

      // Calculate total
      counters['total_counter'] = (counters['counter'] ?? 0) +
          (counters['takbeer_counter'] ?? 0) +
          (counters['ta7meed_counter'] ?? 0) +
          (counters['isteghfar_counter'] ?? 0);
    });
  }

  Future<void> _loadAchievements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (String type in achievementTypes.keys) {
        for (int milestone in milestones) {
          String key = 'achievement_${type}_$milestone';
          unlockedAchievements[key] = prefs.getBool(key) ?? false;
        }
      }
    });
  }

  Future<void> _checkAndUnlockAchievements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasNewAchievements = false;

    for (String type in achievementTypes.keys) {
      String counterKey = achievementTypes[type]!['counterKey'];
      int currentCount = counters[counterKey] ?? 0;

      for (int milestone in milestones) {
        String achievementKey = 'achievement_${type}_$milestone';

        if (currentCount >= milestone && !(unlockedAchievements[achievementKey] ?? false)) {
          setState(() {
            unlockedAchievements[achievementKey] = true;
          });
          await prefs.setBool(achievementKey, true);
          hasNewAchievements = true;
        }
      }
    }

    if (hasNewAchievements) {
      _showNewAchievementDialog();
    }
  }

  void _showNewAchievementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '🎉 إنجاز جديد!',
          style: TextStyle(
            fontFamily: 'NotoBold',
            fontSize: 20.sp,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'تهانينا! لقد حققت إنجازاً جديداً',
          style: TextStyle(
            fontFamily: 'Noto',
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'رائع!',
              style: TextStyle(fontFamily: 'Noto'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    // Format numbers with comma separators for better readability
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
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
            'الإنجازات',
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
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statistics card
              _buildStatsCard(),
              SizedBox(height: 24.h),

              // Achievement sections for each type
              for (String type in achievementTypes.keys) ...[
                _buildAchievementSection(type),
                SizedBox(height: 20.h),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3B82F6).withOpacity(0.3),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'إحصائياتك',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'NotoBold',
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('التسبيح', counters['counter'] ?? 0, Color(0xFF3B82F6)),
              _buildStatItem('التكبير', counters['takbeer_counter'] ?? 0, Color(0xFF8B5CF6)),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('التحميد', counters['ta7meed_counter'] ?? 0, Color(0xFF10B981)),
              _buildStatItem('الاستغفار', counters['isteghfar_counter'] ?? 0, Color(0xFFEF4444)),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Color(0xFFF59E0B), size: 20.w),
                SizedBox(width: 8.w),
                Text(
                  'المجموع: ${_formatNumber(counters['total_counter'] ?? 0)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoBold',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, int count, Color color) {
    return Column(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Icon(
            Icons.circle,
            color: color,
            size: 20.w,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12.sp,
            fontFamily: 'Noto',
          ),
        ),
        Text(
          _formatNumber(count),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Noto',
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementSection(String type) {
    final typeData = achievementTypes[type]!;
    final typeName = typeData['name'];
    final typeColor = typeData['color'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: typeColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'إنجازات $typeName',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoBold',
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.85,
          ),
          itemCount: milestones.length,
          itemBuilder: (context, index) {
            return _buildAchievementCard(type, milestones[index], typeColor);
          },
        ),
      ],
    );
  }

  Widget _buildAchievementCard(String type, int milestone, Color color) {
    String achievementKey = 'achievement_${type}_$milestone';
    bool isUnlocked = unlockedAchievements[achievementKey] ?? false;
    String counterKey = achievementTypes[type]!['counterKey'];
    int currentCount = counters[counterKey] ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isUnlocked ? color.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isUnlocked ? color.withOpacity(0.1) : Colors.black.withOpacity(0.05),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Achievement icon
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: isUnlocked ? color.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                isUnlocked ? Icons.emoji_events : Icons.lock,
                size: 20.w,
                color: isUnlocked ? color : Colors.grey,
              ),
            ),

            // Achievement name
            Text(
              achievementNames[type]?[milestone] ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'NotoBold',
                color: isUnlocked ? Color(0xFF111827) : Colors.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            // Progress
            Text(
              isUnlocked
                  ? '✓ مكتمل'
                  : '${_formatNumber(currentCount)} / ${_formatNumber(milestone)}',
              style: TextStyle(
                fontSize: 10.sp,
                fontFamily: 'Noto',
                color: isUnlocked ? color : Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),

            // Progress bar (only for locked achievements)
            if (!isUnlocked)
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: LinearProgressIndicator(
                  value: currentCount / milestone,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 4.h,
                ),
              ),
          ],
        ),
      ),
    );
  }
}