import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'diary_controller.dart';
import 'widgets/diary_entry_card.dart';
import 'widgets/empty_diary_state.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diário')),
      body: Consumer<DiaryController>(
        builder: (context, ctrl, _) {
          if (ctrl.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (ctrl.status == DiaryStatus.error) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(ctrl.errorMessage ?? 'Erro desconhecido'),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: ctrl.loadEntries,
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }
          if (ctrl.entries.isEmpty) {
            return const EmptyDiaryState();
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: ctrl.entries.length,
            itemBuilder: (context, index) {
              final entry = ctrl.entries[index];
              return DiaryEntryCard(
                entry: entry,
                onTap: () => Navigator.pushNamed(
                  context,
                  '/diary/detail',
                  arguments: entry,
                ),
                onDelete: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Excluir entrada'),
                      content:
                          const Text('Deseja remover esta entrada do diário?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context, true),
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            foregroundColor:
                                Theme.of(context).colorScheme.onError,
                          ),
                          child: const Text('Excluir'),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true && entry.id != null) {
                    ctrl.removeEntry(entry.id!);
                  }
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/diary/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
