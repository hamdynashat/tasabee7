import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tasabee7/screens/menu_screen.dart';

class IsteghfarScreen extends StatefulWidget {
  const IsteghfarScreen({Key? key}) : super(key: key);

  @override
  State<IsteghfarScreen> createState() => _IsteghfarScreenState();
}

class _IsteghfarScreenState extends State<IsteghfarScreen> {
  // State variables
  int counter = 0;
  int currentIsteghfarIndex = 0;
  int werdCounter = 0;
  // List of different isteghfar (seeking forgiveness)
  final List<String> isteghfars = [
    "أستغفر الله",
    "أستغفر الله العظيم",
    "أستغفر الله وأتوب إليه",
    "اللهم اغفر لي ذنبي كله",
    "اللهم إني ظلمت نفسي فاغفر لي",
    "اللهم اغفر لي ما قدمت وما أخرت",
    "أستغفر الله الذي لا إله إلا هو الحي القيوم وأتوب إليه",
    "سبحانك اللهم وبحمدك، أستغفرك وأتوب إليك",
    "رب اغفر لي وتب عليّ إنك أنت التواب الرحيم",
    "اللهم إني أستغفرك من كل ذنب عظيم",
    "اللهم اجعلني من التوابين، واجعلني من المتطهرين",
    "اللهم إني أعوذ بك من ذنب يحبس الرزق",
    "اللهم إني أستغفرك وأتوب إليك إنك أنت الغفور الرحيم",
    "رب اغفر لي ولوالدي وللمؤمنين يوم يقوم الحساب",
    "اللهم اغسلني من خطاياي بالماء والثلج والبرد",
  ];

  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data when screen starts
  }

  // Load counter and isteghfar index from SharedPreferences
  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('isteghfar_counter') ?? 0;
      currentIsteghfarIndex = prefs.getInt('isteghfar_index') ?? 0;
    });
  }

  // Save counter and isteghfar index to SharedPreferences
  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('isteghfar_counter', counter);
    await prefs.setInt('isteghfar_index', currentIsteghfarIndex);
  }

  // Increment counter and save
  void incrementCounter() {
    setState(() {
      counter++;
      werdCounter++;
    });
    _saveData();
  }

  // Go to next isteghfar and save
  void nextIsteghfar() {
    setState(() {
      currentIsteghfarIndex = (currentIsteghfarIndex + 1) % isteghfars.length;
    });
    _saveData();
  }

  // Go to previous isteghfar and save
  void previousIsteghfar() {
    setState(() {
      currentIsteghfarIndex =
          (currentIsteghfarIndex - 1 + isteghfars.length) % isteghfars.length;
    });
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with back button

          // Main content with isteghfar display
          Expanded(child: _buildMainContent()),

          // Footer with controls and counter
          _buildFooter(),
        ],
      ),
    ),
    );
  }

  // Main content with gradient container and isteghfar text
  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Container(
          width: double.infinity,
          height: 256,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFEF4444), Color(0xFFF87171)], // Red gradient for forgiveness
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: AutoSizeText(
                isteghfars[currentIsteghfarIndex],
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto'
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                maxLines: 3,
                minFontSize: 24,
                maxFontSize: 72,
                stepGranularity: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Footer with navigation buttons, main button, and counter
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Control buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              _buildNavButton(Icons.chevron_left, previousIsteghfar),

              // Main isteghfar button
              _buildMainButton(),

              // Next button
              _buildNavButton(Icons.chevron_right, nextIsteghfar),
            ],
          ),

          const SizedBox(height: 32),

          // Counter display
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'العداد: ',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 18,
                    fontFamily: 'Noto',
                  ),
                ),
                TextSpan(
                  text: '$counter',
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Noto',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Navigation button (previous/next)
  Widget _buildNavButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 32, color: const Color(0xFF6B7280)),
        padding: const EdgeInsets.all(16),
      ),
    );
  }

  // Main isteghfar button
  Widget _buildMainButton() {
    return GestureDetector(
      onTap: incrementCounter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444), // Red color matching the gradient
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          '$werdCounter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Noto',
          ),
        ),
      ),
    );
  }
}