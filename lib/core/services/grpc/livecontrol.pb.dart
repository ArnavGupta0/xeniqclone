///
//  Generated code. Do not modify.
//  source: livecontrol.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'livecontrol.pbenum.dart';

export 'livecontrol.pbenum.dart';

enum ControlEvent_Payload {
  command, 
  gyro, 
  system, 
  notSet
}

class ControlEvent extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ControlEvent_Payload> _ControlEvent_PayloadByTag = {
    3 : ControlEvent_Payload.command,
    4 : ControlEvent_Payload.gyro,
    5 : ControlEvent_Payload.system,
    0 : ControlEvent_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ControlEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'livecontrol'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'callId')
    ..e<Role>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderRole', $pb.PbFieldType.OE, defaultOrMaker: Role.CONSUMER, valueOf: Role.valueOf, enumValues: Role.values)
    ..aOM<CommandEvent>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'command', subBuilder: CommandEvent.create)
    ..aOM<GyroEvent>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gyro', subBuilder: GyroEvent.create)
    ..aOM<SystemEvent>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'system', subBuilder: SystemEvent.create)
    ..hasRequiredFields = false
  ;

  ControlEvent._() : super();
  factory ControlEvent({
    $core.String? callId,
    Role? senderRole,
    CommandEvent? command,
    GyroEvent? gyro,
    SystemEvent? system,
  }) {
    final _result = create();
    if (callId != null) {
      _result.callId = callId;
    }
    if (senderRole != null) {
      _result.senderRole = senderRole;
    }
    if (command != null) {
      _result.command = command;
    }
    if (gyro != null) {
      _result.gyro = gyro;
    }
    if (system != null) {
      _result.system = system;
    }
    return _result;
  }
  factory ControlEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlEvent clone() => ControlEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlEvent copyWith(void Function(ControlEvent) updates) => super.copyWith((message) => updates(message as ControlEvent)) as ControlEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ControlEvent create() => ControlEvent._();
  ControlEvent createEmptyInstance() => create();
  static $pb.PbList<ControlEvent> createRepeated() => $pb.PbList<ControlEvent>();
  @$core.pragma('dart2js:noInline')
  static ControlEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ControlEvent>(create);
  static ControlEvent? _defaultInstance;

  ControlEvent_Payload whichPayload() => _ControlEvent_PayloadByTag[$_whichOneof(0)]!;
  void clearPayload() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get callId => $_getSZ(0);
  @$pb.TagNumber(1)
  set callId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCallId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCallId() => clearField(1);

  @$pb.TagNumber(2)
  Role get senderRole => $_getN(1);
  @$pb.TagNumber(2)
  set senderRole(Role v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderRole() => clearField(2);

  @$pb.TagNumber(3)
  CommandEvent get command => $_getN(2);
  @$pb.TagNumber(3)
  set command(CommandEvent v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCommand() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommand() => clearField(3);
  @$pb.TagNumber(3)
  CommandEvent ensureCommand() => $_ensure(2);

  @$pb.TagNumber(4)
  GyroEvent get gyro => $_getN(3);
  @$pb.TagNumber(4)
  set gyro(GyroEvent v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGyro() => $_has(3);
  @$pb.TagNumber(4)
  void clearGyro() => clearField(4);
  @$pb.TagNumber(4)
  GyroEvent ensureGyro() => $_ensure(3);

  @$pb.TagNumber(5)
  SystemEvent get system => $_getN(4);
  @$pb.TagNumber(5)
  set system(SystemEvent v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSystem() => $_has(4);
  @$pb.TagNumber(5)
  void clearSystem() => clearField(5);
  @$pb.TagNumber(5)
  SystemEvent ensureSystem() => $_ensure(4);
}

class CommandEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CommandEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'livecontrol'), createEmptyInstance: create)
    ..e<CommandType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: CommandType.UNKNOWN, valueOf: CommandType.valueOf, enumValues: CommandType.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OF)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zoomDelta', $pb.PbFieldType.OF)
    ..aInt64(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestampMs')
    ..hasRequiredFields = false
  ;

  CommandEvent._() : super();
  factory CommandEvent({
    CommandType? type,
    $core.double? x,
    $core.double? y,
    $core.double? zoomDelta,
    $fixnum.Int64? timestampMs,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    if (zoomDelta != null) {
      _result.zoomDelta = zoomDelta;
    }
    if (timestampMs != null) {
      _result.timestampMs = timestampMs;
    }
    return _result;
  }
  factory CommandEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CommandEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CommandEvent clone() => CommandEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CommandEvent copyWith(void Function(CommandEvent) updates) => super.copyWith((message) => updates(message as CommandEvent)) as CommandEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CommandEvent create() => CommandEvent._();
  CommandEvent createEmptyInstance() => create();
  static $pb.PbList<CommandEvent> createRepeated() => $pb.PbList<CommandEvent>();
  @$core.pragma('dart2js:noInline')
  static CommandEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CommandEvent>(create);
  static CommandEvent? _defaultInstance;

  @$pb.TagNumber(1)
  CommandType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(CommandType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get x => $_getN(1);
  @$pb.TagNumber(2)
  set x($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get y => $_getN(2);
  @$pb.TagNumber(3)
  set y($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get zoomDelta => $_getN(3);
  @$pb.TagNumber(4)
  set zoomDelta($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasZoomDelta() => $_has(3);
  @$pb.TagNumber(4)
  void clearZoomDelta() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get timestampMs => $_getI64(4);
  @$pb.TagNumber(5)
  set timestampMs($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestampMs() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestampMs() => clearField(5);
}

class GyroEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GyroEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'livecontrol'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pitch', $pb.PbFieldType.OF)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'yaw', $pb.PbFieldType.OF)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roll', $pb.PbFieldType.OF)
    ..aInt64(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  GyroEvent._() : super();
  factory GyroEvent({
    $core.double? pitch,
    $core.double? yaw,
    $core.double? roll,
    $fixnum.Int64? timestamp,
  }) {
    final _result = create();
    if (pitch != null) {
      _result.pitch = pitch;
    }
    if (yaw != null) {
      _result.yaw = yaw;
    }
    if (roll != null) {
      _result.roll = roll;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory GyroEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GyroEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GyroEvent clone() => GyroEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GyroEvent copyWith(void Function(GyroEvent) updates) => super.copyWith((message) => updates(message as GyroEvent)) as GyroEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GyroEvent create() => GyroEvent._();
  GyroEvent createEmptyInstance() => create();
  static $pb.PbList<GyroEvent> createRepeated() => $pb.PbList<GyroEvent>();
  @$core.pragma('dart2js:noInline')
  static GyroEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GyroEvent>(create);
  static GyroEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get pitch => $_getN(0);
  @$pb.TagNumber(1)
  set pitch($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPitch() => $_has(0);
  @$pb.TagNumber(1)
  void clearPitch() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get yaw => $_getN(1);
  @$pb.TagNumber(2)
  set yaw($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasYaw() => $_has(1);
  @$pb.TagNumber(2)
  void clearYaw() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get roll => $_getN(2);
  @$pb.TagNumber(3)
  set roll($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRoll() => $_has(2);
  @$pb.TagNumber(3)
  void clearRoll() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);
}

class SystemEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SystemEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'livecontrol'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  SystemEvent._() : super();
  factory SystemEvent({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory SystemEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SystemEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SystemEvent clone() => SystemEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SystemEvent copyWith(void Function(SystemEvent) updates) => super.copyWith((message) => updates(message as SystemEvent)) as SystemEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SystemEvent create() => SystemEvent._();
  SystemEvent createEmptyInstance() => create();
  static $pb.PbList<SystemEvent> createRepeated() => $pb.PbList<SystemEvent>();
  @$core.pragma('dart2js:noInline')
  static SystemEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SystemEvent>(create);
  static SystemEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

