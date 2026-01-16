///
//  Generated code. Do not modify.
//  source: xeniq.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class CommandType extends $pb.ProtobufEnum {
  static const CommandType UNKNOWN = CommandType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const CommandType ROTATE_LEFT = CommandType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROTATE_LEFT');
  static const CommandType ROTATE_RIGHT = CommandType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ROTATE_RIGHT');
  static const CommandType MOVE_FORWARD = CommandType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOVE_FORWARD');
  static const CommandType MOVE_BACKWARD = CommandType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MOVE_BACKWARD');
  static const CommandType POINT_TO_OBJECT = CommandType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'POINT_TO_OBJECT');
  static const CommandType ZOOM_IN = CommandType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZOOM_IN');
  static const CommandType ZOOM_OUT = CommandType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ZOOM_OUT');
  static const CommandType STOP = CommandType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'STOP');
  static const CommandType GYRO_ORIENTATION = CommandType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GYRO_ORIENTATION');
  static const CommandType GYRO_RESET = CommandType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GYRO_RESET');

  static const $core.List<CommandType> values = <CommandType> [
    UNKNOWN,
    ROTATE_LEFT,
    ROTATE_RIGHT,
    MOVE_FORWARD,
    MOVE_BACKWARD,
    POINT_TO_OBJECT,
    ZOOM_IN,
    ZOOM_OUT,
    STOP,
    GYRO_ORIENTATION,
    GYRO_RESET,
  ];

  static final $core.Map<$core.int, CommandType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CommandType? valueOf($core.int value) => _byValue[value];

  const CommandType._($core.int v, $core.String n) : super(v, n);
}

