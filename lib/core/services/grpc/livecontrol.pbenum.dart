///
//  Generated code. Do not modify.
//  source: livecontrol.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Role extends $pb.ProtobufEnum {
  static const Role CONSUMER = Role._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CONSUMER');
  static const Role PROVIDER = Role._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PROVIDER');

  static const $core.List<Role> values = <Role> [
    CONSUMER,
    PROVIDER,
  ];

  static final $core.Map<$core.int, Role> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Role? valueOf($core.int value) => _byValue[value];

  const Role._($core.int v, $core.String n) : super(v, n);
}

class CommandType extends $pb.ProtobufEnum {
  static const CommandType UNKNOWN = CommandType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const CommandType ROTATE_LEFT = CommandType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROTATE_LEFT');
  static const CommandType ROTATE_RIGHT = CommandType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROTATE_RIGHT');
  static const CommandType MOVE_FORWARD = CommandType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOVE_FORWARD');
  static const CommandType MOVE_BACKWARD = CommandType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOVE_BACKWARD');
  static const CommandType POINT_OBJECT = CommandType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'POINT_OBJECT');
  static const CommandType STOP = CommandType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STOP');
  static const CommandType ZOOM_IN = CommandType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZOOM_IN');
  static const CommandType ZOOM_OUT = CommandType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZOOM_OUT');
  static const CommandType ZOOM_DELTA = CommandType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZOOM_DELTA');

  static const $core.List<CommandType> values = <CommandType> [
    UNKNOWN,
    ROTATE_LEFT,
    ROTATE_RIGHT,
    MOVE_FORWARD,
    MOVE_BACKWARD,
    POINT_OBJECT,
    STOP,
    ZOOM_IN,
    ZOOM_OUT,
    ZOOM_DELTA,
  ];

  static final $core.Map<$core.int, CommandType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CommandType? valueOf($core.int value) => _byValue[value];

  const CommandType._($core.int v, $core.String n) : super(v, n);
}

