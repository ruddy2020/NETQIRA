import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dio/dio.dart';

enum SpeedTestPhase {
  idle,
  selectingServer,
  ping,
  download,
  upload,
  completed,
  failed,
}

class SpeedTestServer {
  const SpeedTestServer({
    required this.name,
    required this.baseUrl,
    required this.downloadPath,
    required this.uploadPath,
    required this.pingPath,
  });

  final String name;
  final String baseUrl;
  final String downloadPath;
  final String uploadPath;
  final String pingPath;
}

class SpeedTestSnapshot {
  const SpeedTestSnapshot({
    required this.phase,
    this.serverName,
    this.currentMbps,
    this.pingMs,
    this.jitterMs,
    this.downloadMbps,
    this.uploadMbps,
    this.progress = 0,
    this.message,
  });

  final SpeedTestPhase phase;
  final String? serverName;
  final double? currentMbps;
  final double? pingMs;
  final double? jitterMs;
  final double? downloadMbps;
  final double? uploadMbps;
  final double progress;
  final String? message;
}

class SpeedTestResult {
  const SpeedTestResult({
    required this.serverName,
    required this.pingMs,
    required this.jitterMs,
    required this.downloadMbps,
    required this.uploadMbps,
  });

  final String serverName;
  final double pingMs;
  final double jitterMs;
  final double downloadMbps;
  final double uploadMbps;
}

abstract final class SpeedTestMath {
  static double average(Iterable<double> values) {
    final list = values.toList(growable: false);
    if (list.isEmpty) return 0;
    return list.reduce((a, b) => a + b) / list.length;
  }

  static double jitter(List<double> pings) {
    if (pings.length < 2) return 0;
    final differences = <double>[];
    for (var i = 1; i < pings.length; i++) {
      differences.add((pings[i] - pings[i - 1]).abs());
    }
    return average(differences);
  }

  static double mbps(int bytes, Duration elapsed) {
    final seconds = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
    if (seconds <= 0) return 0;
    return (bytes * 8) / seconds / 1000000;
  }
}

class NetqiraSpeedTestEngine {
  NetqiraSpeedTestEngine({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 8),
              receiveTimeout: const Duration(seconds: 18),
              sendTimeout: const Duration(seconds: 18),
              followRedirects: false,
              validateStatus: (status) =>
                  status != null && status >= 200 && status < 300,
              headers: const {
                'Cache-Control': 'no-cache',
                'Pragma': 'no-cache',
                'User-Agent': 'NETQIRA/1.0 Android Speed Test',
              },
            ),
          );

  final Dio _dio;

  // Puntos publicados en la lista oficial de LibreSpeed.
  // En una fase posterior esta lista se cargará dinámicamente.
  static const List<SpeedTestServer> servers = [
    SpeedTestServer(
      name: 'Los Angeles · Clouvider',
      baseUrl: 'https://la.speedtest.clouvider.net/backend',
      downloadPath: 'garbage.php',
      uploadPath: 'empty.php',
      pingPath: 'empty.php',
    ),
    SpeedTestServer(
      name: 'Las Vegas · Sharktech',
      baseUrl: 'https://lasspeed.sharktech.net',
      downloadPath: 'backend/garbage.php',
      uploadPath: 'backend/empty.php',
      pingPath: 'backend/empty.php',
    ),
    SpeedTestServer(
      name: 'Virginia · OVH',
      baseUrl: 'https://speed.riverside.rocks',
      downloadPath: 'garbage.php',
      uploadPath: 'empty.php',
      pingPath: 'empty.php',
    ),
  ];

  Future<SpeedTestResult> run({
    required void Function(SpeedTestSnapshot snapshot) onProgress,
  }) async {
    try {
      onProgress(
        const SpeedTestSnapshot(
          phase: SpeedTestPhase.selectingServer,
          message: 'Seleccionando servidor por latencia…',
        ),
      );

      final server = await _selectBestServer();

      onProgress(
        SpeedTestSnapshot(
          phase: SpeedTestPhase.ping,
          serverName: server.name,
          message: 'Midiendo ping y jitter…',
        ),
      );

      final pings = await _measurePings(
        server,
        count: 8,
        onSample: (samples) {
          final ping = SpeedTestMath.average(samples);
          final jitter = SpeedTestMath.jitter(samples);
          onProgress(
            SpeedTestSnapshot(
              phase: SpeedTestPhase.ping,
              serverName: server.name,
              pingMs: ping,
              jitterMs: jitter,
              progress: samples.length / 8,
              message: 'Midiendo ping y jitter…',
            ),
          );
        },
      );

      final pingMs = SpeedTestMath.average(pings);
      final jitterMs = SpeedTestMath.jitter(pings);

      onProgress(
        SpeedTestSnapshot(
          phase: SpeedTestPhase.download,
          serverName: server.name,
          pingMs: pingMs,
          jitterMs: jitterMs,
          message: 'Midiendo descarga real…',
        ),
      );

      final downloadMbps = await _measureDownload(
        server,
        onProgress: (value, progress) {
          onProgress(
            SpeedTestSnapshot(
              phase: SpeedTestPhase.download,
              serverName: server.name,
              currentMbps: value,
              pingMs: pingMs,
              jitterMs: jitterMs,
              downloadMbps: value,
              progress: progress,
              message: 'Midiendo descarga real…',
            ),
          );
        },
      );

      onProgress(
        SpeedTestSnapshot(
          phase: SpeedTestPhase.upload,
          serverName: server.name,
          pingMs: pingMs,
          jitterMs: jitterMs,
          downloadMbps: downloadMbps,
          message: 'Midiendo subida real…',
        ),
      );

      final uploadMbps = await _measureUpload(
        server,
        onProgress: (value, progress) {
          onProgress(
            SpeedTestSnapshot(
              phase: SpeedTestPhase.upload,
              serverName: server.name,
              currentMbps: value,
              pingMs: pingMs,
              jitterMs: jitterMs,
              downloadMbps: downloadMbps,
              uploadMbps: value,
              progress: progress,
              message: 'Midiendo subida real…',
            ),
          );
        },
      );

      final result = SpeedTestResult(
        serverName: server.name,
        pingMs: pingMs,
        jitterMs: jitterMs,
        downloadMbps: downloadMbps,
        uploadMbps: uploadMbps,
      );

      onProgress(
        SpeedTestSnapshot(
          phase: SpeedTestPhase.completed,
          serverName: result.serverName,
          currentMbps: result.downloadMbps,
          pingMs: result.pingMs,
          jitterMs: result.jitterMs,
          downloadMbps: result.downloadMbps,
          uploadMbps: result.uploadMbps,
          progress: 1,
          message: 'Prueba completada',
        ),
      );

      return result;
    } on DioException catch (error) {
      throw StateError(_friendlyDioError(error));
    } catch (error) {
      if (error is StateError) rethrow;
      throw StateError('No se pudo completar la medición: $error');
    }
  }

  Future<SpeedTestServer> _selectBestServer() async {
    SpeedTestServer? bestServer;
    var bestLatency = double.infinity;

    for (final server in servers) {
      try {
        final probe = await _singlePing(server);
        if (probe < bestLatency) {
          bestLatency = probe;
          bestServer = server;
        }
      } catch (_) {
        // Si un nodo no responde, continuamos con los demás.
      }
    }

    if (bestServer == null) {
      throw StateError(
        'No se pudo contactar ningún servidor de medición. '
        'Revisa tu conexión e inténtalo nuevamente.',
      );
    }

    return bestServer;
  }

  Future<List<double>> _measurePings(
    SpeedTestServer server, {
    required int count,
    required void Function(List<double> samples) onSample,
  }) async {
    final samples = <double>[];

    for (var i = 0; i < count; i++) {
      samples.add(await _singlePing(server));
      onSample(List<double>.unmodifiable(samples));
      await Future<void>.delayed(const Duration(milliseconds: 90));
    }

    return samples;
  }

  Future<double> _singlePing(SpeedTestServer server) async {
    final uri = _buildUri(server, server.pingPath, {
      'cors': 'true',
      'cacheBust': DateTime.now().microsecondsSinceEpoch.toString(),
    });

    final stopwatch = Stopwatch()..start();
    await _dio.getUri<List<int>>(
      uri,
      options: Options(responseType: ResponseType.bytes),
    );
    stopwatch.stop();

    return stopwatch.elapsedMicroseconds / 1000;
  }

  Future<double> _measureDownload(
    SpeedTestServer server, {
    required void Function(double mbps, double progress) onProgress,
  }) async {
    const chunkSizeMb = 12;
    final uri = _buildUri(server, server.downloadPath, {
      'ckSize': chunkSizeMb.toString(),
      'cors': 'true',
      'cacheBust': DateTime.now().microsecondsSinceEpoch.toString(),
    });

    final stopwatch = Stopwatch()..start();
    var bytes = 0;
    const expectedBytes = chunkSizeMb * 1024 * 1024;

    final response = await _dio.getUri<ResponseBody>(
      uri,
      options: Options(responseType: ResponseType.stream),
    );

    final body = response.data;
    if (body == null) {
      throw StateError('El servidor no devolvió datos de descarga.');
    }

    await for (final chunk in body.stream) {
      bytes += chunk.length;
      final value = SpeedTestMath.mbps(bytes, stopwatch.elapsed);
      final progress = math.min(1.0, bytes / expectedBytes);
      onProgress(value, progress);
    }

    stopwatch.stop();

    if (bytes < 64 * 1024) {
      throw StateError(
        'La respuesta de descarga fue demasiado pequeña para medir velocidad.',
      );
    }

    return SpeedTestMath.mbps(bytes, stopwatch.elapsed);
  }

  Future<double> _measureUpload(
    SpeedTestServer server, {
    required void Function(double mbps, double progress) onProgress,
  }) async {
    const uploadBytes = 6 * 1024 * 1024;
    final payload = Uint8List(uploadBytes);

    final uri = _buildUri(server, server.uploadPath, {
      'cors': 'true',
      'cacheBust': DateTime.now().microsecondsSinceEpoch.toString(),
    });

    final stopwatch = Stopwatch()..start();

    await _dio.postUri<List<int>>(
      uri,
      data: payload,
      options: Options(
        responseType: ResponseType.bytes,
        contentType: 'application/octet-stream',
      ),
      onSendProgress: (sent, total) {
        final value = SpeedTestMath.mbps(sent, stopwatch.elapsed);
        final progress = total > 0 ? sent / total : sent / uploadBytes;
        onProgress(value, progress.clamp(0.0, 1.0).toDouble());
      },
    );

    stopwatch.stop();
    return SpeedTestMath.mbps(uploadBytes, stopwatch.elapsed);
  }

  Uri _buildUri(
    SpeedTestServer server,
    String path,
    Map<String, String> query,
  ) {
    final base = server.baseUrl.endsWith('/')
        ? server.baseUrl.substring(0, server.baseUrl.length - 1)
        : server.baseUrl;
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;

    return Uri.parse('$base/$cleanPath').replace(queryParameters: query);
  }

  String _friendlyDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'La conexión con el servidor tardó demasiado. Intenta nuevamente.';
      case DioExceptionType.connectionError:
        return 'No fue posible conectar con el servidor de medición.';
      case DioExceptionType.badResponse:
        return 'El servidor de medición respondió con un error.';
      case DioExceptionType.cancel:
        return 'La medición fue cancelada.';
      case DioExceptionType.badCertificate:
        return 'No se pudo validar la conexión segura del servidor.';
      case DioExceptionType.unknown:
        return 'Ocurrió un problema de red durante la medición.';
      default:
        return 'Ocurrió un problema de red durante la medición.';
    }
  }
}
