import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xeniqclone/features/session/data/repositories/session_repository_impl.dart';
import 'package:xeniqclone/features/session/domain/repositories/session_repository.dart';

part 'session_provider.g.dart';

@Riverpod(keepAlive: true)
SessionRepository sessionRepository(SessionRepositoryRef ref) {
  return SessionRepositoryImpl();
}

@riverpod
Stream<MediaStream> localStream(LocalStreamRef ref) {
  return ref.watch(sessionRepositoryProvider).localStream;
}

@riverpod
Stream<MediaStream> remoteStream(RemoteStreamRef ref) {
  return ref.watch(sessionRepositoryProvider).remoteStream;
}

@riverpod
Stream<Map<String, dynamic>> sessionEvents(SessionEventsRef ref) {
  return ref.watch(sessionRepositoryProvider).sessionEvents;
}
