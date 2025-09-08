import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tasabee7/screens/menu_screen.dart';

class Ta7meedScreen extends StatefulWidget {
  const Ta7meedScreen({Key? key}) : super(key: key);

  @override
  State<Ta7meedScreen> createState() => _Ta7meedScreenState();
}

class _Ta7meedScreenState extends State<Ta7meedScreen> {
  // State variables
  int counter = 0;
  int currentTa7meedIndex = 0;
  int werdCounter = 0;

  // List of different ta7meeds (praises)
  final List<String> ta7meeds = [
    "الحمد لله",
    "الحمد لله رب العالمين",
    "الحمد لله على كل حال",
    "الحمد لله الذي بنعمته تتم الصالحات",
    "الحمد لله عدد ما خلق",
    "الحمد لله ملء السماوات وملء الأرض",
    "الحمد لله كما ينبغي لجلال وجهه وعظيم سلطانه",
    "اللهم لك الحمد كما تحب وترضى",
  ];

  @override
  void initState() {
    super.initState();
    _loadData(); // Load saved data when screen starts
  }

  // Load counter and ta7meed index from SharedPreferences
  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('ta7meed_counter') ?? 0;
      currentTa7meedIndex = prefs.getInt('ta7meed_index') ?? 0;
    });
  }

  // Save counter and ta7meed index to SharedPreferences
  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('ta7meed_counter', counter);
    await prefs.setInt('ta7meed_index', currentTa7meedIndex);
  }

  // Increment counter and save
  void incrementCounter() {
    setState(() {
      counter++;
      werdCounter++;
    });
    _saveData();
  }

  // Go to next ta7meed and save
  void nextTa7meed() {
    setState(() {
      currentTa7meedIndex = (currentTa7meedIndex + 1) % ta7meeds.length;
    });
    _saveData();
  }

  // Go to previous ta7meed and save
  void previousTa7meed() {
    setState(() {
      currentTa7meedIndex =
          (currentTa7meedIndex - 1 + ta7meeds.length) % ta7meeds.length;
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

          // Main content with ta7meed display
          Expanded(child: _buildMainContent()),

          // Footer with controls and counter
          _buildFooter(),
        ],
      ),
    ),
    );
  }

  // Main content with gradient container and ta7meed text
  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Container(
          width: double.infinity,
          height: 256,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF34D399)], // Green gradient for praise
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
                ta7meeds[currentTa7meedIndex],
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
              _buildNavButton(Icons.chevron_left, previousTa7meed),

              // Main ta7meed button
              _buildMainButton(),

              // Next button
              _buildNavButton(Icons.chevron_right, nextTa7meed),
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

  // Main ta7meed button
  Widget _buildMainButton() {
    return GestureDetector(
      onTap: incrementCounter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981), // Green color matching the gradient
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