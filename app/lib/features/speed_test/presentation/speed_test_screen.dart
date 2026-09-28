import 'package:flutter/material.dart';

import '../../../core/theme/netqira_theme.dart';

class SpeedTestScreen extends StatelessWidget {
  const SpeedTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NetqiraTheme.navy,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Prueba de Internet',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: NetqiraTheme.cyan, width: 14),
                  boxShadow: [
                    BoxShadow(
                      color: NetqiraTheme.cyan.withValues(alpha: 0.15),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.speed_rounded,
                      color: NetqiraTheme.cyan,
                      size: 42,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '--',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text('Mbps', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Motor de medición pendiente',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Esta fase no genera velocidades ficticias.',
                style: TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              const Row(
                children: [
                  Expanded(child: _Metric('Descarga')),
                  SizedBox(width: 10),
                  Expanded(child: _Metric('Subida')),
                  SizedBox(width: 10),
                  Expanded(child: _Metric('Ping')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white60, fontSize: 11),
          ),
          const SizedBox(height: 6),
          const Text(
            '--',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
