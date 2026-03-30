import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'features/calculator/presentation/calculator_controller.dart';
import 'features/diary/data/datasources/diary_local_datasource.dart';
import 'features/diary/data/repositories/diary_repository_impl.dart';
import 'features/diary/domain/usecases/create_entry.dart';
import 'features/diary/domain/usecases/delete_entry.dart';
import 'features/diary/domain/usecases/get_all_entries.dart';
import 'features/diary/presentation/diary_controller.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  runApp(const AppProviders());
}

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    final datasource = DiaryLocalDatasourceImpl();
    final repository = DiaryRepositoryImpl(datasource);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorController()),
        ChangeNotifierProvider(
          create: (_) => DiaryController(
            getAllEntries: GetAllEntries(repository),
            createEntry: CreateEntry(repository),
            deleteEntry: DeleteEntry(repository),
          )..loadEntries(),
        ),
      ],
      child: const App(),
    );
  }
}
