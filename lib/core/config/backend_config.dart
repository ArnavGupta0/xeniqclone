/// Backend Configuration
/// CRITICAL: All gRPC services MUST use these constants
/// 
/// Physical Device Network Setup:
/// - Backend runs on PC at LAN IP: 192.168.1.2

/// - Port: 50051
/// - Both devices MUST be on same Wi-Fi network as PC
class BackendConfig {
  // HARDCODED for physical devices
  static const String backendHost = '192.168.1.6';

  static const int backendPort = 50051;
  
  /// Full backend address (for logging)
  static String get address => '$backendHost:$backendPort';
  
  /// Connection timeout
  static const Duration connectTimeout = Duration(seconds: 3);
  
  /// Retry interval when backend unreachable
  static const Duration retryInterval = Duration(seconds: 5);
}
