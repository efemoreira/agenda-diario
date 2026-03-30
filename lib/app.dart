import 'package:flutter/material.dart';

import 'features/calculator/presentation/calculator_page.dart';
import 'features/diary/presentation/diary_entry_detail_page.dart';
import 'features/diary/presentation/diary_page.dart';
import 'features/diary/presentation/new_entry_page.dart';
import 'shared/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda/Diário',
      theme: AppTheme.dark(),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/diary/detail') {
          return MaterialPageRoute(
            builder: (_) => DiaryEntryDetailPage(
              entry: settings.arguments as dynamic,
            ),
          );
        }
        if (settings.name == '/diary/new') {
          return MaterialPageRoute(builder: (_) => const NewEntryPage());
        }
        return null;
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    CalculatorPage(),
    DiaryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Calculadora',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Diário',
          ),
        ],
      ),
    );
  }
}
