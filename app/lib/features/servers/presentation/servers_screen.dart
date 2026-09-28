import 'package:flutter/material.dart';

import '../../../core/theme/netqira_theme.dart';

class ServersScreen extends StatelessWidget {
  const ServersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
      children: [
        Text(
          'Servidores',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 6),
        const Text(
          'Aquí elegiremos el nodo con menor latencia.',
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
            Icons.public_rounded,
            size: 52,
            color: NetqiraTheme.primary,
          ),
        ),
      ],
    );
  }
}
