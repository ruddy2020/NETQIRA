import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/netqira_theme.dart';
import '../../history/data/netqira_history_repository.dart';
import '../data/netqira_speed_test_engine.dart';

class SpeedTestScreen extends StatefulWidget {
  const SpeedTestScreen({super.key});

  @override
  State<SpeedTestScreen> createState() => _SpeedTestScreenState();
}

class _SpeedTestScreenState extends State<SpeedTestScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scanController;
  late final NetqiraSpeedTestEngine _engine;

  SpeedTestSnapshot _snapshot = const SpeedTestSnapshot(
    phase: SpeedTestPhase.idle,
    message: 'Listo para medir',
  );

  bool _running = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _engine = NetqiraSpeedTestEngine();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  Future<void> _runTest() async {
    if (_running) return;

    setState(() {
      _running = true;
      _error = null;
      _snapshot = const SpeedTestSnapshot(
        phase: SpeedTestPhase.selectingServer,
        message: 'Seleccionando servidorâ€¦',
      );
    });

    try {
      await _engine.run(
        onProgress: (snapshot) {
          if (!mounted) return;
          setState(() => _snapshot = snapshot);
        },
      );
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.toString().replaceFirst('Bad state: ', '');
        _snapshot = SpeedTestSnapshot(
          phase: SpeedTestPhase.failed,
          message: _error,
        );
      });
    } finally {
      if (mounted) {
        setState(() => _running = false);
      }
    }
  }

  String get _statusLabel {
    switch (_snapshot.phase) {
      case SpeedTestPhase.idle:
        return 'PREPARADO';
      case SpeedTestPhase.selectingServer:
        return 'SERVIDOR';
      case SpeedTestPhase.ping:
        return 'PING';
      case SpeedTestPhase.download:
        return 'DESCARGA';
      case SpeedTestPhase.upload:
        return 'SUBIDA';
      case SpeedTestPhase.completed:
        return 'COMPLETADO';
      case SpeedTestPhase.failed:
        return 'ERROR';
    }
  }

  double? get _gaugeValue {
    switch (_snapshot.phase) {
      case SpeedTestPhase.ping:
        return _snapshot.pingMs;
      case SpeedTestPhase.download:
      case SpeedTestPhase.upload:
      case SpeedTestPhase.completed:
        return _snapshot.currentMbps ??
            _snapshot.downloadMbps ??
            _snapshot.uploadMbps;
      case SpeedTestPhase.idle:
      case SpeedTestPhase.selectingServer:
      case SpeedTestPhase.failed:
        return null;
    }
  }

  String get _gaugeUnit =>
      _snapshot.phase == SpeedTestPhase.ping ? 'ms' : 'Mbps';

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
              child: _StatusPill(
                label: _statusLabel,
                error: _snapshot.phase == SpeedTestPhase.failed,
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
                    _ServerCard(serverName: _snapshot.serverName),
                    const SizedBox(height: 24),
                    AnimatedBuilder(
                      animation: _scanController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _GaugePainter(
                            scanProgress: _scanController.value,
                            running: _running,
                            phaseProgress: _snapshot.progress,
                          ),
                          child: SizedBox(
                            width: 300,
                            height: 230,
                            child: child,
                          ),
                        );
                      },
                      child: _GaugeCenter(
                        value: _gaugeValue,
                        unit: _gaugeUnit,
                        running: _running,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _snapshot.message ?? 'Listo para medir',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _error == null
                            ? Colors.white
                            : const Color(0xFFFF8792),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _error == null
                          ? 'NETQIRA mide trÃ¡fico real contra un servidor compatible con LibreSpeed.'
                          : 'Puedes reintentar cuando tu conexiÃ³n estÃ© disponible.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.58),
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _MetricCard(
                            icon: Icons.south_rounded,
                            label: 'Descarga',
                            value: _snapshot.downloadMbps,
                            unit: 'Mbps',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _MetricCard(
                            icon: Icons.north_rounded,
                            label: 'Subida',
                            value: _snapshot.uploadMbps,
                            unit: 'Mbps',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _MetricCard(
                            icon: Icons.multiple_stop_rounded,
                            label: 'Ping',
                            value: _snapshot.pingMs,
                            unit: 'ms',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _MetricCard(
                            icon: Icons.graphic_eq_rounded,
                            label: 'Jitter',
                            value: _snapshot.jitterMs,
                            unit: 'ms',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _running ? null : _runTest,
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
                        icon: _running
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
                          _running
                              ? 'Midiendoâ€¦'
                              : _snapshot.phase == SpeedTestPhase.completed
                              ? 'Repetir prueba'
                              : 'Iniciar prueba real',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Fase 3 Â· Motor real de red',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.36),
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

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.error});

  final String label;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final color = error ? const Color(0xFFFF6C7A) : const Color(0xFF2CD6A6);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F2E55),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServerCard extends StatelessWidget {
  const _ServerCard({required this.serverName});

  final String? serverName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2444),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          const _RoundIcon(icon: Icons.public_rounded),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Servidor',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  serverName ?? 'SelecciÃ³n automÃ¡tica',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.bolt_rounded, color: NetqiraTheme.cyan, size: 18),
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
  const _GaugeCenter({
    required this.value,
    required this.unit,
    required this.running,
  });

  final double? value;
  final String unit;
  final bool running;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 220),
            scale: running ? 1.08 : 1,
            child: const Icon(
              Icons.speed_rounded,
              color: NetqiraTheme.cyan,
              size: 36,
            ),
          ),
          const SizedBox(height: 6),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Text(
              value == null ? '--' : _formatValue(value!),
              key: ValueKey(value?.toStringAsFixed(1)),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            unit,
            style: const TextStyle(
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
    required this.value,
    required this.unit,
  });

  final IconData icon;
  final String label;
  final double? value;
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
                    Flexible(
                      child: Text(
                        value == null ? '--' : _formatValue(value!),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
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

String _formatValue(double value) {
  if (value >= 100) return value.toStringAsFixed(0);
  if (value >= 10) return value.toStringAsFixed(1);
  return value.toStringAsFixed(2);
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter({
    required this.scanProgress,
    required this.running,
    required this.phaseProgress,
  });

  final double scanProgress;
  final bool running;
  final double phaseProgress;

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

    if (running) {
      final progress = phaseProgress.clamp(0.06, 1.0);
      canvas.drawArc(
        rect,
        startAngle,
        sweepAngle * progress,
        false,
        activePaint,
      );

      final glowPaint = Paint()
        ..color = NetqiraTheme.cyan.withValues(alpha: 0.55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;

      final cursor = scanProgress * 0.12;
      canvas.drawArc(
        rect,
        startAngle + (sweepAngle * math.max(0, progress - cursor - 0.04)),
        sweepAngle * 0.04,
        false,
        glowPaint,
      );
    }

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
        oldDelegate.running != running ||
        oldDelegate.phaseProgress != phaseProgress;
  }
}
