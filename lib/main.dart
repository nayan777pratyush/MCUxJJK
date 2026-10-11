import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'data/fusion_data.dart';
import 'models/fusion_model.dart';
import 'screens/home_screen.dart';
import 'screens/builder_screen.dart';
import 'screens/result_screen.dart';
import 'screens/saved_screen.dart';
import 'widgets/bottom_nav_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.voidBg,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const McuJjkFusionApp());
}

class McuJjkFusionApp extends StatelessWidget {
  const McuJjkFusionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCU × JJK Fusion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.voidBg,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.tertiaryContainer,
        ),
      ),
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;
  FusionCharacter _currentFusion = FusionData.infiniteSorcerer;
  final List<FusionCharacter> _savedFusions = List.from(FusionData.defaultSavedFusions);

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onSelectFusion(FusionCharacter fusion) {
    setState(() {
      _currentFusion = fusion;
    });
  }

  void _onSaveCurrentFusion() {
    setState(() {
      if (!_savedFusions.any((f) => f.id == _currentFusion.id)) {
        _savedFusions.insert(0, _currentFusion);
      }
    });
  }

  void _onDeleteFusion(String id) {
    setState(() {
      _savedFusions.removeWhere((f) => f.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBg,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: IndexedStack(
            index: _currentIndex,
            children: [
              HomeScreen(
                onNavigate: _onTabSelected,
                onSelectFusion: _onSelectFusion,
              ),
              BuilderScreen(
                onNavigate: _onTabSelected,
                onGenerateFusion: (generated) {
                  _onSelectFusion(generated);
                },
              ),
              ResultScreen(
                fusion: _currentFusion,
                onNavigate: _onTabSelected,
                onSaveFusion: _onSaveCurrentFusion,
              ),
              SavedScreen(
                savedFusions: _savedFusions,
                onNavigate: _onTabSelected,
                onSelectFusion: _onSelectFusion,
                onDeleteFusion: _onDeleteFusion,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Center(
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: OccultBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onTabSelected,
          ),
        ),
      ),
    );
  }
}
