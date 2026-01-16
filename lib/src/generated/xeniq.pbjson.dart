///
//  Generated code. Do not modify.
//  source: xeniq.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use commandTypeDescriptor instead')
const CommandType$json = const {
  '1': 'CommandType',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'ROTATE_LEFT', '2': 1},
    const {'1': 'ROTATE_RIGHT', '2': 2},
    const {'1': 'MOVE_FORWARD', '2': 3},
    const {'1': 'MOVE_BACKWARD', '2': 4},
    const {'1': 'POINT_TO_OBJECT', '2': 5},
    const {'1': 'ZOOM_IN', '2': 6},
    const {'1': 'ZOOM_OUT', '2': 7},
    const {'1': 'STOP', '2': 8},
    const {'1': 'GYRO_ORIENTATION', '2': 9},
    const {'1': 'GYRO_RESET', '2': 10},
  ],
};

/// Descriptor for `CommandType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List commandTypeDescriptor = $convert.base64Decode('CgtDb21tYW5kVHlwZRILCgdVTktOT1dOEAASDwoLUk9UQVRFX0xFRlQQARIQCgxST1RBVEVfUklHSFQQAhIQCgxNT1ZFX0ZPUldBUkQQAxIRCg1NT1ZFX0JBQ0tXQVJEEAQSEwoPUE9JTlRfVE9fT0JKRUNUEAUSCwoHWk9PTV9JThAGEgwKCFpPT01fT1VUEAcSCAoEU1RPUBAIEhQKEEdZUk9fT1JJRU5UQVRJT04QCRIOCgpHWVJPX1JFU0VUEAo=');
@$core.Deprecated('Use registerProviderRequestDescriptor instead')
const RegisterProviderRequest$json = const {
  '1': 'RegisterProviderRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'latitude', '3': 3, '4': 1, '5': 1, '10': 'latitude'},
    const {'1': 'longitude', '3': 4, '4': 1, '5': 1, '10': 'longitude'},
  ],
};

/// Descriptor for `RegisterProviderRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerProviderRequestDescriptor = $convert.base64Decode('ChdSZWdpc3RlclByb3ZpZGVyUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZBIjCg1wcm92aWRlcl9jb2RlGAIgASgJUgxwcm92aWRlckNvZGUSGgoIbGF0aXR1ZGUYAyABKAFSCGxhdGl0dWRlEhwKCWxvbmdpdHVkZRgEIAEoAVIJbG9uZ2l0dWRl');
@$core.Deprecated('Use registerProviderResponseDescriptor instead')
const RegisterProviderResponse$json = const {
  '1': 'RegisterProviderResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'provider_code', '3': 3, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `RegisterProviderResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerProviderResponseDescriptor = $convert.base64Decode('ChhSZWdpc3RlclByb3ZpZGVyUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdlEiMKDXByb3ZpZGVyX2NvZGUYAyABKAlSDHByb3ZpZGVyQ29kZQ==');
@$core.Deprecated('Use setAvailabilityRequestDescriptor instead')
const SetAvailabilityRequest$json = const {
  '1': 'SetAvailabilityRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'is_available', '3': 2, '4': 1, '5': 8, '10': 'isAvailable'},
  ],
};

/// Descriptor for `SetAvailabilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setAvailabilityRequestDescriptor = $convert.base64Decode('ChZTZXRBdmFpbGFiaWxpdHlSZXF1ZXN0Eh8KC3Byb3ZpZGVyX2lkGAEgASgJUgpwcm92aWRlcklkEiEKDGlzX2F2YWlsYWJsZRgCIAEoCFILaXNBdmFpbGFibGU=');
@$core.Deprecated('Use setAvailabilityResponseDescriptor instead')
const SetAvailabilityResponse$json = const {
  '1': 'SetAvailabilityResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `SetAvailabilityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setAvailabilityResponseDescriptor = $convert.base64Decode('ChdTZXRBdmFpbGFiaWxpdHlSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEiMKDXByb3ZpZGVyX2NvZGUYAiABKAlSDHByb3ZpZGVyQ29kZQ==');
@$core.Deprecated('Use listProvidersRequestDescriptor instead')
const ListProvidersRequest$json = const {
  '1': 'ListProvidersRequest',
};

/// Descriptor for `ListProvidersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listProvidersRequestDescriptor = $convert.base64Decode('ChRMaXN0UHJvdmlkZXJzUmVxdWVzdA==');
@$core.Deprecated('Use listProvidersResponseDescriptor instead')
const ListProvidersResponse$json = const {
  '1': 'ListProvidersResponse',
  '2': const [
    const {'1': 'providers', '3': 1, '4': 3, '5': 11, '6': '.xeniq.ProviderStatusEvent', '10': 'providers'},
  ],
};

/// Descriptor for `ListProvidersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listProvidersResponseDescriptor = $convert.base64Decode('ChVMaXN0UHJvdmlkZXJzUmVzcG9uc2USOAoJcHJvdmlkZXJzGAEgAygLMhoueGVuaXEuUHJvdmlkZXJTdGF0dXNFdmVudFIJcHJvdmlkZXJz');
@$core.Deprecated('Use searchRequestDescriptor instead')
const SearchRequest$json = const {
  '1': 'SearchRequest',
  '2': const [
    const {'1': 'provider_code', '3': 1, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `SearchRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchRequestDescriptor = $convert.base64Decode('Cg1TZWFyY2hSZXF1ZXN0EiMKDXByb3ZpZGVyX2NvZGUYASABKAlSDHByb3ZpZGVyQ29kZQ==');
@$core.Deprecated('Use searchResponseDescriptor instead')
const SearchResponse$json = const {
  '1': 'SearchResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'provider_id', '3': 3, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'is_available', '3': 4, '4': 1, '5': 8, '10': 'isAvailable'},
  ],
};

/// Descriptor for `SearchResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchResponseDescriptor = $convert.base64Decode('Cg5TZWFyY2hSZXNwb25zZRIYCgdzdWNjZXNzGAEgASgIUgdzdWNjZXNzEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USHwoLcHJvdmlkZXJfaWQYAyABKAlSCnByb3ZpZGVySWQSIQoMaXNfYXZhaWxhYmxlGAQgASgIUgtpc0F2YWlsYWJsZQ==');
@$core.Deprecated('Use providerStatusEventDescriptor instead')
const ProviderStatusEvent$json = const {
  '1': 'ProviderStatusEvent',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'provider_code', '3': 2, '4': 1, '5': 9, '10': 'providerCode'},
    const {'1': 'is_available', '3': 3, '4': 1, '5': 8, '10': 'isAvailable'},
    const {'1': 'latitude', '3': 4, '4': 1, '5': 1, '10': 'latitude'},
    const {'1': 'longitude', '3': 5, '4': 1, '5': 1, '10': 'longitude'},
    const {'1': 'timestamp', '3': 6, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `ProviderStatusEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List providerStatusEventDescriptor = $convert.base64Decode('ChNQcm92aWRlclN0YXR1c0V2ZW50Eh8KC3Byb3ZpZGVyX2lkGAEgASgJUgpwcm92aWRlcklkEiMKDXByb3ZpZGVyX2NvZGUYAiABKAlSDHByb3ZpZGVyQ29kZRIhCgxpc19hdmFpbGFibGUYAyABKAhSC2lzQXZhaWxhYmxlEhoKCGxhdGl0dWRlGAQgASgBUghsYXRpdHVkZRIcCglsb25naXR1ZGUYBSABKAFSCWxvbmdpdHVkZRIcCgl0aW1lc3RhbXAYBiABKANSCXRpbWVzdGFtcA==');
@$core.Deprecated('Use incomingCallsRequestDescriptor instead')
const IncomingCallsRequest$json = const {
  '1': 'IncomingCallsRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
  ],
};

/// Descriptor for `IncomingCallsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incomingCallsRequestDescriptor = $convert.base64Decode('ChRJbmNvbWluZ0NhbGxzUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZA==');
@$core.Deprecated('Use incomingCallEventDescriptor instead')
const IncomingCallEvent$json = const {
  '1': 'IncomingCallEvent',
  '2': const [
    const {'1': 'call_id', '3': 1, '4': 1, '5': 9, '10': 'callId'},
    const {'1': 'consumer_id', '3': 2, '4': 1, '5': 9, '10': 'consumerId'},
    const {'1': 'consumer_name', '3': 3, '4': 1, '5': 9, '10': 'consumerName'},
    const {'1': 'purpose', '3': 4, '4': 1, '5': 9, '10': 'purpose'},
  ],
};

/// Descriptor for `IncomingCallEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List incomingCallEventDescriptor = $convert.base64Decode('ChFJbmNvbWluZ0NhbGxFdmVudBIXCgdjYWxsX2lkGAEgASgJUgZjYWxsSWQSHwoLY29uc3VtZXJfaWQYAiABKAlSCmNvbnN1bWVySWQSIwoNY29uc3VtZXJfbmFtZRgDIAEoCVIMY29uc3VtZXJOYW1lEhgKB3B1cnBvc2UYBCABKAlSB3B1cnBvc2U=');
@$core.Deprecated('Use callRequestDescriptor instead')
const CallRequest$json = const {
  '1': 'CallRequest',
  '2': const [
    const {'1': 'provider_id', '3': 1, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'consumer_id', '3': 2, '4': 1, '5': 9, '10': 'consumerId'},
    const {'1': 'consumer_name', '3': 3, '4': 1, '5': 9, '10': 'consumerName'},
    const {'1': 'purpose', '3': 4, '4': 1, '5': 9, '10': 'purpose'},
    const {'1': 'provider_code', '3': 5, '4': 1, '5': 9, '10': 'providerCode'},
  ],
};

/// Descriptor for `CallRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List callRequestDescriptor = $convert.base64Decode('CgtDYWxsUmVxdWVzdBIfCgtwcm92aWRlcl9pZBgBIAEoCVIKcHJvdmlkZXJJZBIfCgtjb25zdW1lcl9pZBgCIAEoCVIKY29uc3VtZXJJZBIjCg1jb25zdW1lcl9uYW1lGAMgASgJUgxjb25zdW1lck5hbWUSGAoHcHVycG9zZRgEIAEoCVIHcHVycG9zZRIjCg1wcm92aWRlcl9jb2RlGAUgASgJUgxwcm92aWRlckNvZGU=');
@$core.Deprecated('Use callResponseDescriptor instead')
const CallResponse$json = const {
  '1': 'CallResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'call_id', '3': 2, '4': 1, '5': 9, '10': 'callId'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `CallResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List callResponseDescriptor = $convert.base64Decode('CgxDYWxsUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIXCgdjYWxsX2lkGAIgASgJUgZjYWxsSWQSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZQ==');
@$core.Deprecated('Use answerCallRequestDescriptor instead')
const AnswerCallRequest$json = const {
  '1': 'AnswerCallRequest',
  '2': const [
    const {'1': 'call_id', '3': 1, '4': 1, '5': 9, '10': 'callId'},
    const {'1': 'provider_id', '3': 2, '4': 1, '5': 9, '10': 'providerId'},
  ],
};

/// Descriptor for `AnswerCallRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List answerCallRequestDescriptor = $convert.base64Decode('ChFBbnN3ZXJDYWxsUmVxdWVzdBIXCgdjYWxsX2lkGAEgASgJUgZjYWxsSWQSHwoLcHJvdmlkZXJfaWQYAiABKAlSCnByb3ZpZGVySWQ=');
@$core.Deprecated('Use answerCallResponseDescriptor instead')
const AnswerCallResponse$json = const {
  '1': 'AnswerCallResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
    const {'1': 'session_id', '3': 2, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `AnswerCallResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List answerCallResponseDescriptor = $convert.base64Decode('ChJBbnN3ZXJDYWxsUmVzcG9uc2USGAoHc3VjY2VzcxgBIAEoCFIHc3VjY2VzcxIdCgpzZXNzaW9uX2lkGAIgASgJUglzZXNzaW9uSWQ=');
@$core.Deprecated('Use declineCallRequestDescriptor instead')
const DeclineCallRequest$json = const {
  '1': 'DeclineCallRequest',
  '2': const [
    const {'1': 'call_id', '3': 1, '4': 1, '5': 9, '10': 'callId'},
    const {'1': 'provider_id', '3': 2, '4': 1, '5': 9, '10': 'providerId'},
    const {'1': 'reason', '3': 3, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `DeclineCallRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineCallRequestDescriptor = $convert.base64Decode('ChJEZWNsaW5lQ2FsbFJlcXVlc3QSFwoHY2FsbF9pZBgBIAEoCVIGY2FsbElkEh8KC3Byb3ZpZGVyX2lkGAIgASgJUgpwcm92aWRlcklkEhYKBnJlYXNvbhgDIAEoCVIGcmVhc29u');
@$core.Deprecated('Use declineCallResponseDescriptor instead')
const DeclineCallResponse$json = const {
  '1': 'DeclineCallResponse',
  '2': const [
    const {'1': 'success', '3': 1, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `DeclineCallResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List declineCallResponseDescriptor = $convert.base64Decode('ChNEZWNsaW5lQ2FsbFJlc3BvbnNlEhgKB3N1Y2Nlc3MYASABKAhSB3N1Y2Nlc3M=');
@$core.Deprecated('Use connectionEventDescriptor instead')
const ConnectionEvent$json = const {
  '1': 'ConnectionEvent',
  '2': const [
    const {'1': 'call_id', '3': 1, '4': 1, '5': 9, '10': 'callId'},
    const {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'receiver_id', '3': 3, '4': 1, '5': 9, '10': 'receiverId'},
    const {'1': 'ice', '3': 6, '4': 1, '5': 11, '6': '.xeniq.IceCandidate', '9': 0, '10': 'ice'},
    const {'1': 'sdp', '3': 7, '4': 1, '5': 11, '6': '.xeniq.SessionDescription', '9': 0, '10': 'sdp'},
    const {'1': 'end', '3': 8, '4': 1, '5': 11, '6': '.xeniq.EndCall', '9': 0, '10': 'end'},
  ],
  '8': const [
    const {'1': 'payload'},
  ],
};

/// Descriptor for `ConnectionEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionEventDescriptor = $convert.base64Decode('Cg9Db25uZWN0aW9uRXZlbnQSFwoHY2FsbF9pZBgBIAEoCVIGY2FsbElkEhsKCXNlbmRlcl9pZBgCIAEoCVIIc2VuZGVySWQSHwoLcmVjZWl2ZXJfaWQYAyABKAlSCnJlY2VpdmVySWQSJwoDaWNlGAYgASgLMhMueGVuaXEuSWNlQ2FuZGlkYXRlSABSA2ljZRItCgNzZHAYByABKAsyGS54ZW5pcS5TZXNzaW9uRGVzY3JpcHRpb25IAFIDc2RwEiIKA2VuZBgIIAEoCzIOLnhlbmlxLkVuZENhbGxIAFIDZW5kQgkKB3BheWxvYWQ=');
@$core.Deprecated('Use iceCandidateDescriptor instead')
const IceCandidate$json = const {
  '1': 'IceCandidate',
  '2': const [
    const {'1': 'candidate', '3': 1, '4': 1, '5': 9, '10': 'candidate'},
    const {'1': 'sdp_mid', '3': 2, '4': 1, '5': 9, '10': 'sdpMid'},
    const {'1': 'sdp_m_line_index', '3': 3, '4': 1, '5': 5, '10': 'sdpMLineIndex'},
  ],
};

/// Descriptor for `IceCandidate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List iceCandidateDescriptor = $convert.base64Decode('CgxJY2VDYW5kaWRhdGUSHAoJY2FuZGlkYXRlGAEgASgJUgljYW5kaWRhdGUSFwoHc2RwX21pZBgCIAEoCVIGc2RwTWlkEicKEHNkcF9tX2xpbmVfaW5kZXgYAyABKAVSDXNkcE1MaW5lSW5kZXg=');
@$core.Deprecated('Use sessionDescriptionDescriptor instead')
const SessionDescription$json = const {
  '1': 'SessionDescription',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'sdp', '3': 2, '4': 1, '5': 9, '10': 'sdp'},
  ],
};

/// Descriptor for `SessionDescription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptionDescriptor = $convert.base64Decode('ChJTZXNzaW9uRGVzY3JpcHRpb24SEgoEdHlwZRgBIAEoCVIEdHlwZRIQCgNzZHAYAiABKAlSA3NkcA==');
@$core.Deprecated('Use endCallDescriptor instead')
const EndCall$json = const {
  '1': 'EndCall',
  '2': const [
    const {'1': 'reason', '3': 1, '4': 1, '5': 9, '10': 'reason'},
  ],
};

/// Descriptor for `EndCall`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endCallDescriptor = $convert.base64Decode('CgdFbmRDYWxsEhYKBnJlYXNvbhgBIAEoCVIGcmVhc29u');
@$core.Deprecated('Use controlEventDescriptor instead')
const ControlEvent$json = const {
  '1': 'ControlEvent',
  '2': const [
    const {'1': 'call_id', '3': 1, '4': 1, '5': 9, '10': 'callId'},
    const {'1': 'sender_id', '3': 2, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'command', '3': 3, '4': 1, '5': 11, '6': '.xeniq.CameraCommand', '9': 0, '10': 'command'},
    const {'1': 'gyro', '3': 4, '4': 1, '5': 11, '6': '.xeniq.GyroData', '9': 0, '10': 'gyro'},
    const {'1': 'ack', '3': 5, '4': 1, '5': 11, '6': '.xeniq.ControlAck', '9': 0, '10': 'ack'},
  ],
  '8': const [
    const {'1': 'payload'},
  ],
};

/// Descriptor for `ControlEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlEventDescriptor = $convert.base64Decode('CgxDb250cm9sRXZlbnQSFwoHY2FsbF9pZBgBIAEoCVIGY2FsbElkEhsKCXNlbmRlcl9pZBgCIAEoCVIIc2VuZGVySWQSMAoHY29tbWFuZBgDIAEoCzIULnhlbmlxLkNhbWVyYUNvbW1hbmRIAFIHY29tbWFuZBIlCgRneXJvGAQgASgLMg8ueGVuaXEuR3lyb0RhdGFIAFIEZ3lybxIlCgNhY2sYBSABKAsyES54ZW5pcS5Db250cm9sQWNrSABSA2Fja0IJCgdwYXlsb2Fk');
@$core.Deprecated('Use cameraCommandDescriptor instead')
const CameraCommand$json = const {
  '1': 'CameraCommand',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.xeniq.CommandType', '10': 'type'},
    const {'1': 'value', '3': 2, '4': 1, '5': 2, '10': 'value'},
    const {'1': 'yaw', '3': 3, '4': 1, '5': 2, '10': 'yaw'},
    const {'1': 'pitch', '3': 4, '4': 1, '5': 2, '10': 'pitch'},
  ],
};

/// Descriptor for `CameraCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cameraCommandDescriptor = $convert.base64Decode('Cg1DYW1lcmFDb21tYW5kEiYKBHR5cGUYASABKA4yEi54ZW5pcS5Db21tYW5kVHlwZVIEdHlwZRIUCgV2YWx1ZRgCIAEoAlIFdmFsdWUSEAoDeWF3GAMgASgCUgN5YXcSFAoFcGl0Y2gYBCABKAJSBXBpdGNo');
@$core.Deprecated('Use gyroDataDescriptor instead')
const GyroData$json = const {
  '1': 'GyroData',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 2, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 2, '10': 'y'},
    const {'1': 'z', '3': 3, '4': 1, '5': 2, '10': 'z'},
    const {'1': 'roll', '3': 4, '4': 1, '5': 2, '10': 'roll'},
    const {'1': 'pitch', '3': 5, '4': 1, '5': 2, '10': 'pitch'},
    const {'1': 'yaw', '3': 6, '4': 1, '5': 2, '10': 'yaw'},
  ],
};

/// Descriptor for `GyroData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gyroDataDescriptor = $convert.base64Decode('CghHeXJvRGF0YRIMCgF4GAEgASgCUgF4EgwKAXkYAiABKAJSAXkSDAoBehgDIAEoAlIBehISCgRyb2xsGAQgASgCUgRyb2xsEhQKBXBpdGNoGAUgASgCUgVwaXRjaBIQCgN5YXcYBiABKAJSA3lhdw==');
@$core.Deprecated('Use controlAckDescriptor instead')
const ControlAck$json = const {
  '1': 'ControlAck',
  '2': const [
    const {'1': 'command_id', '3': 1, '4': 1, '5': 9, '10': 'commandId'},
    const {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
  ],
};

/// Descriptor for `ControlAck`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlAckDescriptor = $convert.base64Decode('CgpDb250cm9sQWNrEh0KCmNvbW1hbmRfaWQYASABKAlSCWNvbW1hbmRJZBIYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNz');
