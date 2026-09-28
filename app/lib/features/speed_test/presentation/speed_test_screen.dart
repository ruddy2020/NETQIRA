import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/netqira_theme.dart';

class SpeedTestScreen extends StatefulWidget {
  const SpeedTestScreen({super.key});

  @override
  State<SpeedTestScreen> createState() => _SpeedTestScreenState();
}

class _SpeedTestScreenState extends State<SpeedTestScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scanController;
  bool _preparing = false;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  Future<void> _prepareMeasurement() async {
    if (_preparing) return;

    setState(() => _preparing = true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    setState(() => _preparing = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Interfaz de medición lista. El motor real se conectará en la Fase 3.',
        ),
      ),
    );
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F2E55),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 8, color: Color(0xFF2CD6A6)),
                    SizedBox(width: 6),
                    Text(
                      'PREPARADO',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 26),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: math.max(0, constraints.maxHeight - 42),
                ),
                child: Column(
                  children: [
                    const _ServerCard(),
                    const SizedBox(height: 24),
                    AnimatedBuilder(
                      animation: _scanController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _GaugePainter(
                            scanProgress: _scanController.value,
                            preparing: _preparing,
                          ),
                          child: SizedBox(
                            width: 300,
                            height: 230,
                            child: child,
                          ),
                        );
                      },
                      child: _GaugeCenter(preparing: _preparing),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _preparing
                          ? 'Preparando entorno de medición...'
                          : 'Listo para medir',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _preparing
                          ? 'Comprobando la interfaz y el estado inicial.'
                          : 'Los valores permanecerán vacíos hasta conectar el motor real.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.62),
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Row(
                      children: [
                        Expanded(
                          child: _MetricCard(
                            icon: Icons.south_rounded,
                            label: 'Descarga',
                            unit: 'Mbps',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _MetricCard(
                            icon: Icons.north_rounded,
                            label: 'Subida',
                            unit: 'Mbps',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Expanded(
                          child: _MetricCard(
                            icon: Icons.multiple_stop_rounded,
                            label: 'Ping',
                            unit: 'ms',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _MetricCard(
                            icon: Icons.graphic_eq_rounded,
                            label: 'Jitter',
                            unit: 'ms',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _preparing ? null : _prepareMeasurement,
                        style: FilledButton.styleFrom(
                          backgroundColor: NetqiraTheme.primary,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: NetqiraTheme.primary
                              .withValues(alpha: 0.45),
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        icon: _preparing
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.bolt_rounded),
                        label: Text(
                          _preparing ? 'Preparando...' : 'Preparar medición',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Fase 2 · Experiencia visual del Speed Test',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.38),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ServerCard extends StatelessWidget {
  const _ServerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2444),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: const Row(
        children: [
          _RoundIcon(icon: Icons.public_rounded),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Servidor',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Selección automática',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.white38),
        ],
      ),
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: NetqiraTheme.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Icon(icon, size: 19, color: NetqiraTheme.cyan),
    );
  }
}

class _GaugeCenter extends StatelessWidget {
  const _GaugeCenter({required this.preparing});

  final bool preparing;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 220),
            scale: preparing ? 1.08 : 1,
            child: const Icon(
              Icons.speed_rounded,
              color: NetqiraTheme.cyan,
              size: 36,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '--',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Mbps',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.unit,
  });

  final IconData icon;
  final String label;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2444),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          _RoundIcon(icon: icon),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '--',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        unit,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter({required this.scanProgress, required this.preparing});

  final double scanProgress;
  final bool preparing;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.63);
    final radius = math.min(size.width * 0.42, size.height * 0.72);
    final rect = Rect.fromCircle(center: center, radius: radius);

    const startAngle = math.pi * 0.78;
    const sweepAngle = math.pi * 1.44;

    final basePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, basePaint);

    final activePaint = Paint()
      ..shader = const LinearGradient(
        colors: [NetqiraTheme.primary, NetqiraTheme.cyan],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round;

    final scanLength = preparing ? 0.34 : 0.18;
    final normalizedStart = scanProgress * (1 - scanLength);
    canvas.drawArc(
      rect,
      startAngle + (sweepAngle * normalizedStart),
      sweepAngle * scanLength,
      false,
      activePaint,
    );

    final tickPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.16)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i <= 12; i++) {
      final progress = i / 12;
      final angle = startAngle + (sweepAngle * progress);
      final outer = Offset(
        center.dx + math.cos(angle) * (radius + 17),
        center.dy + math.sin(angle) * (radius + 17),
      );
      final inner = Offset(
        center.dx + math.cos(angle) * (radius + 10),
        center.dy + math.sin(angle) * (radius + 10),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.scanProgress != scanProgress ||
        oldDelegate.preparing != preparing;
  }
}
