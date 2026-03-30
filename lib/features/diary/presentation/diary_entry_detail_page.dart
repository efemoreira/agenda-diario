import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/entities/diary_entry.dart';

class DiaryEntryDetailPage extends StatelessWidget {
  final DiaryEntry entry;

  const DiaryEntryDetailPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('dd/MM/yyyy — HH:mm', 'pt_BR');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          entry.title?.isNotEmpty == true ? entry.title! : 'Sem título',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.schedule, size: 16, color: colors.onSurfaceVariant),
                const SizedBox(width: 6),
                Text(
                  dateFormat.format(entry.createdAt),
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SelectableText(
              entry.content,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
