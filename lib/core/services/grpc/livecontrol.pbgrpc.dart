///
//  Generated code. Do not modify.
//  source: livecontrol.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'livecontrol.pb.dart' as $0;
export 'livecontrol.pb.dart';

class LiveControlServiceClient extends $grpc.Client {
  static final _$controlStream =
      $grpc.ClientMethod<$0.ControlEvent, $0.ControlEvent>(
          '/livecontrol.LiveControlService/ControlStream',
          ($0.ControlEvent value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.ControlEvent.fromBuffer(value));

  LiveControlServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.ControlEvent> controlStream(
      $async.Stream<$0.ControlEvent> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$controlStream, request, options: options);
  }
}

abstract class LiveControlServiceBase extends $grpc.Service {
  $core.String get $name => 'livecontrol.LiveControlService';

  LiveControlServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ControlEvent, $0.ControlEvent>(
        'ControlStream',
        controlStream,
        true,
        true,
        ($core.List<$core.int> value) => $0.ControlEvent.fromBuffer(value),
        ($0.ControlEvent value) => value.writeToBuffer()));
  }

  $async.Stream<$0.ControlEvent> controlStream(
      $grpc.ServiceCall call, $async.Stream<$0.ControlEvent> request);
}
