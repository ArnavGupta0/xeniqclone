// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionRepositoryHash() => r'86666805ab5e78194b48ef318ee04bb11368a1cc';

/// See also [sessionRepository].
@ProviderFor(sessionRepository)
final sessionRepositoryProvider = Provider<SessionRepository>.internal(
  sessionRepository,
  name: r'sessionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionRepositoryRef = ProviderRef<SessionRepository>;
String _$localStreamHash() => r'080f80c1acd53abdcae0855f6e2411a0de5e1c52';

/// See also [localStream].
@ProviderFor(localStream)
final localStreamProvider = AutoDisposeStreamProvider<MediaStream>.internal(
  localStream,
  name: r'localStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocalStreamRef = AutoDisposeStreamProviderRef<MediaStream>;
String _$remoteStreamHash() => r'0fdd48eb0b6c5883a709701f58c8662973b9834e';

/// See also [remoteStream].
@ProviderFor(remoteStream)
final remoteStreamProvider = AutoDisposeStreamProvider<MediaStream>.internal(
  remoteStream,
  name: r'remoteStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remoteStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteStreamRef = AutoDisposeStreamProviderRef<MediaStream>;
String _$sessionEventsHash() => r'a3c5cb9a291c002da89696057d1cb66b1a0173cb';

/// See also [sessionEvents].
@ProviderFor(sessionEvents)
final sessionEventsProvider =
    AutoDisposeStreamProvider<Map<String, dynamic>>.internal(
      sessionEvents,
      name: r'sessionEventsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sessionEventsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionEventsRef = AutoDisposeStreamProviderRef<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
