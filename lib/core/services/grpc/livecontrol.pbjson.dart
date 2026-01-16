///
//  Generated code. Do not modify.
//  source: livecontrol.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use roleDescriptor instead')
const Role$json = const {
  '1': 'Role',
  '2': const [
    const {'1': 'CONSUMER', '2': 0},
    const {'1': 'PROVIDER', '2': 1},
  ],
};

/// Descriptor for `Role`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roleDescriptor = $convert.base64Decode('CgRSb2xlEgwKCENPTlNVTUVSEAASDAoIUFJPVklERVIQAQ==');
@$core.Deprecated('Use commandTypeDescriptor instead')
const CommandType$json = const {
  '1': 'CommandType',
  '2': const [
    const {'1': 'ROTATE_LEFT', '2': 0},
    const {'1': 'ROTATE_RIGHT', '2': 1},
    const {'1': 'MOVE_FORWARD', '2': 2},
    const {'1': 'MOVE_BACKWARD', '2': 3},
    const {'1': 'POINT_OBJECT', '2': 4},
    const {'1': 'STOP', '2': 5},
  ],
};

/// Descriptor for `CommandType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List commandTypeDescriptor = $convert.base64Decode('CgtDb21tYW5kVHlwZRIPCgtST1RBVEVfTEVGVBAAEhAKDFJPVEFURV9SSUdIVBABEhAKDE1PVkVfRk9SV0FSRBACEhEKDU1PVkVfQkFDS1dBUkQQAxIQCgxQT0lOVF9PQkpFQ1QQBBIICgRTVE9QEAU=');
@$core.Deprecated('Use controlEventDescriptor instead')
const ControlEvent$json = const {
  '1': 'ControlEvent',
  '2': const [
    const {'1': 'call_id', '3': 1, '4': 1, '5': 9, '10': 'callId'},
    const {'1': 'sender_role', '3': 2, '4': 1, '5': 14, '6': '.livecontrol.Role', '10': 'senderRole'},
    const {'1': 'command', '3': 3, '4': 1, '5': 11, '6': '.livecontrol.CommandEvent', '9': 0, '10': 'command'},
    const {'1': 'gyro', '3': 4, '4': 1, '5': 11, '6': '.livecontrol.GyroEvent', '9': 0, '10': 'gyro'},
    const {'1': 'system', '3': 5, '4': 1, '5': 11, '6': '.livecontrol.SystemEvent', '9': 0, '10': 'system'},
  ],
  '8': const [
    const {'1': 'payload'},
  ],
};

/// Descriptor for `ControlEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlEventDescriptor = $convert.base64Decode('CgxDb250cm9sRXZlbnQSFwoHY2FsbF9pZBgBIAEoCVIGY2FsbElkEjIKC3NlbmRlcl9yb2xlGAIgASgOMhEubGl2ZWNvbnRyb2wuUm9sZVIKc2VuZGVyUm9sZRI1Cgdjb21tYW5kGAMgASgLMhkubGl2ZWNvbnRyb2wuQ29tbWFuZEV2ZW50SABSB2NvbW1hbmQSLAoEZ3lybxgEIAEoCzIWLmxpdmVjb250cm9sLkd5cm9FdmVudEgAUgRneXJvEjIKBnN5c3RlbRgFIAEoCzIYLmxpdmVjb250cm9sLlN5c3RlbUV2ZW50SABSBnN5c3RlbUIJCgdwYXlsb2Fk');
@$core.Deprecated('Use commandEventDescriptor instead')
const CommandEvent$json = const {
  '1': 'CommandEvent',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.livecontrol.CommandType', '10': 'type'},
  ],
};

/// Descriptor for `CommandEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandEventDescriptor = $convert.base64Decode('CgxDb21tYW5kRXZlbnQSLAoEdHlwZRgBIAEoDjIYLmxpdmVjb250cm9sLkNvbW1hbmRUeXBlUgR0eXBl');
@$core.Deprecated('Use gyroEventDescriptor instead')
const GyroEvent$json = const {
  '1': 'GyroEvent',
  '2': const [
    const {'1': 'pitch', '3': 1, '4': 1, '5': 2, '10': 'pitch'},
    const {'1': 'yaw', '3': 2, '4': 1, '5': 2, '10': 'yaw'},
    const {'1': 'roll', '3': 3, '4': 1, '5': 2, '10': 'roll'},
    const {'1': 'timestamp', '3': 4, '4': 1, '5': 3, '10': 'timestamp'},
  ],
};

/// Descriptor for `GyroEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gyroEventDescriptor = $convert.base64Decode('CglHeXJvRXZlbnQSFAoFcGl0Y2gYASABKAJSBXBpdGNoEhAKA3lhdxgCIAEoAlIDeWF3EhIKBHJvbGwYAyABKAJSBHJvbGwSHAoJdGltZXN0YW1wGAQgASgDUgl0aW1lc3RhbXA=');
@$core.Deprecated('Use systemEventDescriptor instead')
const SystemEvent$json = const {
  '1': 'SystemEvent',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SystemEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List systemEventDescriptor = $convert.base64Decode('CgtTeXN0ZW1FdmVudBIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');
