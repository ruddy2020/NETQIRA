import 'package:flutter/material.dart';

import '../../../core/theme/netqira_theme.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
      children: [
        Text(
          'Historial',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 6),
        const Text(
          'Tus mediciones se guardarán localmente.',
          style: TextStyle(color: NetqiraTheme.muted),
        ),
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF0D2342)
                : Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.query_stats_rounded,
            size: 52,
            color: NetqiraTheme.primary,
          ),
        ),
      ],
    );
  }
}
