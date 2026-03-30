import 'package:flutter/material.dart';

class EmptyDiaryState extends StatelessWidget {
  const EmptyDiaryState({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.book_outlined,
            size: 80,
            color: colors.onSurfaceVariant.withOpacity(0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma entrada ainda',
            style: TextStyle(
              fontSize: 18,
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Toque no + para criar sua primeira entrada.',
            style: TextStyle(
              fontSize: 14,
              color: colors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
