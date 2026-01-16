import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:xeniqclone/core/config/backend_config.dart';
import 'package:xeniqclone/src/generated/xeniq.pbgrpc.dart';

/// Diagnostic interceptor to log EVERY gRPC call
class DiagnosticInterceptor implements ClientInterceptor {
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    debugPrint('🔍 [INTERCEPTOR] Streaming call: ${method.path}');
    return invoker(method, requests, options);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    debugPrint('═══════════════════════════════════════');
    debugPrint('🔍 [INTERCEPTOR] UNARY CALL INTERCEPTED');
    debugPrint('🔍 [INTERCEPTOR] Method: ${method.path}');
    debugPrint('═══════════════════════════════════════');

    final future = invoker(method, request, options);

    future.then((_) {
      debugPrint('✅ [INTERCEPTOR] Call succeeded: ${method.path}');
    }).catchError((error) {
      debugPrint('❌ [INTERCEPTOR] Call failed: ${method.path}');
      debugPrint('❌ [INTERCEPTOR] Error: $error');
      if (error is GrpcError) {
        debugPrint('❌ [INTERCEPTOR] GrpcError code: ${error.code}');
        debugPrint('❌ [INTERCEPTOR] GrpcError message: ${error.message}');
      }
    });

    return future;
  }
}

class GrpcService {
  static final GrpcService _instance = GrpcService._internal();
  factory GrpcService() => _instance;

  late final ClientChannel _channel;

  late final ProviderServiceClient providerClient;
  late final ConnectServiceClient connectClient;
  late final ControlServiceClient controlClient;

  bool _initialized = false;

  GrpcService._internal() {
    debugPrint('▓▓▓ GRPC SERVICE SINGLETON INIT ▓▓▓');
    _initChannel();
  }

  void _initChannel() {
    if (_initialized) return;

    const host = BackendConfig.backendHost;
    const port = BackendConfig.backendPort;

    debugPrint('🎯 TARGET HOST: $host');
    debugPrint('🎯 TARGET PORT: $port');

    if (port != 50051) {
      debugPrint('⚠️ WARNING: Using non-standard port $port');
    }

    _channel = ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    final interceptors = [DiagnosticInterceptor()];

    providerClient = ProviderServiceClient(_channel, interceptors: interceptors);
    connectClient = ConnectServiceClient(_channel, interceptors: interceptors);
    controlClient = ControlServiceClient(_channel, interceptors: interceptors);

    _initialized = true;

    debugPrint('✅ GRPC INITIALIZED: $host:$port');
  }

  /// 🔍 Used by UI to test backend availability
  Future<bool> checkConnectivity() async {
    try {
      await providerClient.listProviders(
        ListProvidersRequest(),
        options: CallOptions(timeout: BackendConfig.connectTimeout),
      );
      debugPrint('✅ Backend reachable');
      return true;
    } catch (e) {
      debugPrint('❌ Backend unreachable: $e');
      return false;
    }
  }

  Future<void> shutdown() async {
    await _channel.shutdown();
  }
}
