import 'package:flutter/material.dart';

import '../../../core/theme/netqira_theme.dart';
import '../../speed_test/presentation/speed_test_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      children: [
        const _Header(),
        const SizedBox(height: 22),
        _Hero(
          onStart: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const SpeedTestScreen()),
          ),
        ),
        const SizedBox(height: 18),
        const _QuickActions(),
        const SizedBox(height: 26),
        _SectionTitle('Estado de tu conexión'),
        const SizedBox(height: 12),
        const _StatusCard(),
        const SizedBox(height: 26),
        _SectionTitle('Mediciones recientes'),
        const SizedBox(height: 12),
        const _EmptyHistory(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [NetqiraTheme.primary, NetqiraTheme.cyan],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.network_check_rounded, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NETQIRA',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const Text(
                'Mide. Entiende. Mejora.',
                style: TextStyle(color: NetqiraTheme.muted, fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: () {},
          icon: const Icon(Icons.tune_rounded),
        ),
      ],
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF116CF7), Color(0xFF0B4DCE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: NetqiraTheme.primary.withValues(alpha: 0.24),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.speed_rounded,
              color: Colors.white,
              size: 31,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Prueba tu Internet',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mide velocidad, latencia y estabilidad con una experiencia clara.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: onStart,
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: NetqiraTheme.primary,
            ),
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Iniciar prueba'),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    const data = [
      (Icons.wifi_tethering_rounded, 'Red'),
      (Icons.speed_rounded, 'Medir'),
      (Icons.insights_rounded, 'Análisis'),
    ];

    return Row(
      children: [
        for (var i = 0; i < data.length; i++) ...[
          Expanded(
            child: _Card(
              child: Column(
                children: [
                  Icon(data[i].$1, color: NetqiraTheme.primary),
                  const SizedBox(height: 8),
                  Text(
                    data[i].$2,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
          if (i != data.length - 1) const SizedBox(width: 10),
        ],
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard();

  @override
  Widget build(BuildContext context) {
    return const _Card(
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            color: Color(0xFF17A67A),
            size: 34,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Listo para medir',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 4),
                Text(
                  'Aún no se ha ejecutado una medición en este dispositivo.',
                  style: TextStyle(color: NetqiraTheme.muted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    return const _Card(
      child: Row(
        children: [
          Icon(Icons.history_rounded, color: NetqiraTheme.primary, size: 34),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              'Tu historial aparecerá después de la primera prueba.',
              style: TextStyle(color: NetqiraTheme.muted),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF0D2342) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: dark
              ? Colors.white.withValues(alpha: 0.06)
              : const Color(0xFFE5ECF5),
        ),
      ),
      child: child,
    );
  }
}
