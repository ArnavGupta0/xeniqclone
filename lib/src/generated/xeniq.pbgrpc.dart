///
//  Generated code. Do not modify.
//  source: xeniq.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'xeniq.pb.dart' as $0;
export 'xeniq.pb.dart';

class ProviderServiceClient extends $grpc.Client {
  static final _$registerProvider = $grpc.ClientMethod<
          $0.RegisterProviderRequest, $0.RegisterProviderResponse>(
      '/xeniq.ProviderService/RegisterProvider',
      ($0.RegisterProviderRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.RegisterProviderResponse.fromBuffer(value));
  static final _$setAvailability =
      $grpc.ClientMethod<$0.SetAvailabilityRequest, $0.SetAvailabilityResponse>(
          '/xeniq.ProviderService/SetAvailability',
          ($0.SetAvailabilityRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.SetAvailabilityResponse.fromBuffer(value));
  static final _$listProviders =
      $grpc.ClientMethod<$0.ListProvidersRequest, $0.ListProvidersResponse>(
          '/xeniq.ProviderService/ListProviders',
          ($0.ListProvidersRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListProvidersResponse.fromBuffer(value));
  static final _$searchProvider =
      $grpc.ClientMethod<$0.SearchRequest, $0.SearchResponse>(
          '/xeniq.ProviderService/SearchProvider',
          ($0.SearchRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SearchResponse.fromBuffer(value));

  ProviderServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.RegisterProviderResponse> registerProvider(
      $0.RegisterProviderRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$registerProvider, request, options: options);
  }

  $grpc.ResponseFuture<$0.SetAvailabilityResponse> setAvailability(
      $0.SetAvailabilityRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setAvailability, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListProvidersResponse> listProviders(
      $0.ListProvidersRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listProviders, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchResponse> searchProvider(
      $0.SearchRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$searchProvider, request, options: options);
  }
}

abstract class ProviderServiceBase extends $grpc.Service {
  $core.String get $name => 'xeniq.ProviderService';

  ProviderServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RegisterProviderRequest,
            $0.RegisterProviderResponse>(
        'RegisterProvider',
        registerProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RegisterProviderRequest.fromBuffer(value),
        ($0.RegisterProviderResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SetAvailabilityRequest,
            $0.SetAvailabilityResponse>(
        'SetAvailability',
        setAvailability_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SetAvailabilityRequest.fromBuffer(value),
        ($0.SetAvailabilityResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListProvidersRequest, $0.ListProvidersResponse>(
            'ListProviders',
            listProviders_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.ListProvidersRequest.fromBuffer(value),
            ($0.ListProvidersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchRequest, $0.SearchResponse>(
        'SearchProvider',
        searchProvider_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SearchRequest.fromBuffer(value),
        ($0.SearchResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.RegisterProviderResponse> registerProvider_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RegisterProviderRequest> request) async {
    return registerProvider(call, await request);
  }

  $async.Future<$0.SetAvailabilityResponse> setAvailability_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.SetAvailabilityRequest> request) async {
    return setAvailability(call, await request);
  }

  $async.Future<$0.ListProvidersResponse> listProviders_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListProvidersRequest> request) async {
    return listProviders(call, await request);
  }

  $async.Future<$0.SearchResponse> searchProvider_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SearchRequest> request) async {
    return searchProvider(call, await request);
  }

  $async.Future<$0.RegisterProviderResponse> registerProvider(
      $grpc.ServiceCall call, $0.RegisterProviderRequest request);
  $async.Future<$0.SetAvailabilityResponse> setAvailability(
      $grpc.ServiceCall call, $0.SetAvailabilityRequest request);
  $async.Future<$0.ListProvidersResponse> listProviders(
      $grpc.ServiceCall call, $0.ListProvidersRequest request);
  $async.Future<$0.SearchResponse> searchProvider(
      $grpc.ServiceCall call, $0.SearchRequest request);
}

class ConnectServiceClient extends $grpc.Client {
  static final _$streamIncomingCalls =
      $grpc.ClientMethod<$0.IncomingCallsRequest, $0.IncomingCallEvent>(
          '/xeniq.ConnectService/StreamIncomingCalls',
          ($0.IncomingCallsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.IncomingCallEvent.fromBuffer(value));
  static final _$requestCall =
      $grpc.ClientMethod<$0.CallRequest, $0.CallResponse>(
          '/xeniq.ConnectService/RequestCall',
          ($0.CallRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.CallResponse.fromBuffer(value));
  static final _$acceptCall =
      $grpc.ClientMethod<$0.AnswerCallRequest, $0.AnswerCallResponse>(
          '/xeniq.ConnectService/AcceptCall',
          ($0.AnswerCallRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AnswerCallResponse.fromBuffer(value));
  static final _$declineCall =
      $grpc.ClientMethod<$0.DeclineCallRequest, $0.DeclineCallResponse>(
          '/xeniq.ConnectService/DeclineCall',
          ($0.DeclineCallRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeclineCallResponse.fromBuffer(value));
  static final _$streamConnection =
      $grpc.ClientMethod<$0.ConnectionEvent, $0.ConnectionEvent>(
          '/xeniq.ConnectService/StreamConnection',
          ($0.ConnectionEvent value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ConnectionEvent.fromBuffer(value));

  ConnectServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.IncomingCallEvent> streamIncomingCalls(
      $0.IncomingCallsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$streamIncomingCalls, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.CallResponse> requestCall($0.CallRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$requestCall, request, options: options);
  }

  $grpc.ResponseFuture<$0.AnswerCallResponse> acceptCall(
      $0.AnswerCallRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$acceptCall, request, options: options);
  }

  $grpc.ResponseFuture<$0.DeclineCallResponse> declineCall(
      $0.DeclineCallRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$declineCall, request, options: options);
  }

  $grpc.ResponseStream<$0.ConnectionEvent> streamConnection(
      $async.Stream<$0.ConnectionEvent> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamConnection, request, options: options);
  }
}

abstract class ConnectServiceBase extends $grpc.Service {
  $core.String get $name => 'xeniq.ConnectService';

  ConnectServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.IncomingCallsRequest, $0.IncomingCallEvent>(
            'StreamIncomingCalls',
            streamIncomingCalls_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.IncomingCallsRequest.fromBuffer(value),
            ($0.IncomingCallEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CallRequest, $0.CallResponse>(
        'RequestCall',
        requestCall_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CallRequest.fromBuffer(value),
        ($0.CallResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AnswerCallRequest, $0.AnswerCallResponse>(
        'AcceptCall',
        acceptCall_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AnswerCallRequest.fromBuffer(value),
        ($0.AnswerCallResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DeclineCallRequest, $0.DeclineCallResponse>(
            'DeclineCall',
            declineCall_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.DeclineCallRequest.fromBuffer(value),
            ($0.DeclineCallResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConnectionEvent, $0.ConnectionEvent>(
        'StreamConnection',
        streamConnection,
        true,
        true,
        ($core.List<$core.int> value) => $0.ConnectionEvent.fromBuffer(value),
        ($0.ConnectionEvent value) => value.writeToBuffer()));
  }

  $async.Stream<$0.IncomingCallEvent> streamIncomingCalls_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.IncomingCallsRequest> request) async* {
    yield* streamIncomingCalls(call, await request);
  }

  $async.Future<$0.CallResponse> requestCall_Pre(
      $grpc.ServiceCall call, $async.Future<$0.CallRequest> request) async {
    return requestCall(call, await request);
  }

  $async.Future<$0.AnswerCallResponse> acceptCall_Pre($grpc.ServiceCall call,
      $async.Future<$0.AnswerCallRequest> request) async {
    return acceptCall(call, await request);
  }

  $async.Future<$0.DeclineCallResponse> declineCall_Pre($grpc.ServiceCall call,
      $async.Future<$0.DeclineCallRequest> request) async {
    return declineCall(call, await request);
  }

  $async.Stream<$0.IncomingCallEvent> streamIncomingCalls(
      $grpc.ServiceCall call, $0.IncomingCallsRequest request);
  $async.Future<$0.CallResponse> requestCall(
      $grpc.ServiceCall call, $0.CallRequest request);
  $async.Future<$0.AnswerCallResponse> acceptCall(
      $grpc.ServiceCall call, $0.AnswerCallRequest request);
  $async.Future<$0.DeclineCallResponse> declineCall(
      $grpc.ServiceCall call, $0.DeclineCallRequest request);
  $async.Stream<$0.ConnectionEvent> streamConnection(
      $grpc.ServiceCall call, $async.Stream<$0.ConnectionEvent> request);
}

class ControlServiceClient extends $grpc.Client {
  static final _$streamControl =
      $grpc.ClientMethod<$0.ControlEvent, $0.ControlEvent>(
          '/xeniq.ControlService/StreamControl',
          ($0.ControlEvent value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.ControlEvent.fromBuffer(value));

  ControlServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.ControlEvent> streamControl(
      $async.Stream<$0.ControlEvent> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamControl, request, options: options);
  }
}

abstract class ControlServiceBase extends $grpc.Service {
  $core.String get $name => 'xeniq.ControlService';

  ControlServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ControlEvent, $0.ControlEvent>(
        'StreamControl',
        streamControl,
        true,
        true,
        ($core.List<$core.int> value) => $0.ControlEvent.fromBuffer(value),
        ($0.ControlEvent value) => value.writeToBuffer()));
  }

  $async.Stream<$0.ControlEvent> streamControl(
      $grpc.ServiceCall call, $async.Stream<$0.ControlEvent> request);
}
