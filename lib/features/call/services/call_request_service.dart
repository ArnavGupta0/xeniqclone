import 'dart:developer';
import 'package:xeniqclone/services/grpc_service.dart';
import 'package:xeniqclone/src/generated/xeniq.pbgrpc.dart';

class CallRequestService {
  static final CallRequestService _instance = CallRequestService._internal();
  factory CallRequestService() => _instance;
  CallRequestService._internal();

  final ConnectServiceClient _client = GrpcService().connectClient;

  Future<CallResponse> requestCall({
    required String providerId, // Keep for legacy/fallback
    required String providerCode, // New
    required String consumerId,
    required String consumerName,
    required String purpose,
  }) async {
    try {
      final req = CallRequest(
        providerId: providerId, // Backend might use one or other
        providerCode: providerCode, // Priority
        consumerId: consumerId,
        consumerName: consumerName,
        purpose: purpose,
      );
      final response = await _client.requestCall(req);
      log('Call Requested: ${response.success} (Msg: ${response.message})');
      return response;
    } catch (e) {
      log('Request Call Error: $e');
      return CallResponse(success: false, message: 'Network Error: $e');
    }
  }
  Future<AnswerCallResponse> acceptCall({required String callId, required String providerId}) async {
    try {
      final response = await _client.acceptCall(
        AnswerCallRequest(callId: callId, providerId: providerId)
      );
      log('Call Accepted: $callId, SessionID: ${response.sessionId}');
      return response;
    } catch (e) {
      log('Accept Call Error: $e');
      return AnswerCallResponse(success: false, sessionId: '');
    }
  }

  Future<bool> declineCall({required String callId, required String providerId, String reason = "Busy"}) async {
    try {
      final response = await _client.declineCall(
        DeclineCallRequest(callId: callId, providerId: providerId, reason: reason)
      );
      log('Call Declined: $callId');
      return response.success;
    } catch (e) {
      log('Decline Call Error: $e');
      return false;
    }
  }
}
