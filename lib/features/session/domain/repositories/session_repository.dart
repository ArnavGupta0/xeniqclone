import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract class SessionRepository {
  Stream<MediaStream> get localStream;
  Stream<MediaStream> get remoteStream;
  Stream<Map<String, dynamic>> get sessionEvents; // For commands/gestures

  Future<String> createSession(String userId); // Returns session ID
  Future<void> joinSession(String sessionId);
  Future<void> endSession();
  
  Future<void> rotateCamera(); // Provider only
  Future<void> toggleMute();
  
  // Camera zoom (Provider only)
  Future<void> applyZoom(double delta);
  Future<void> setZoomLevel(double level); // Absolute zoom control
  
  // Gestures (Consumer -> Provider)
  Future<void> sendGestureCommand(Map<String, dynamic> command);
  
  // Auto call termination callback
  void setOnCallEndedCallback(VoidCallback callback);
}
