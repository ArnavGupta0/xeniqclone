///
//  Generated code. Do not modify.
//  source: xeniq.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'xeniq.pbenum.dart';

export 'xeniq.pbenum.dart';

class RegisterProviderRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterProviderRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerCode')
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'longitude', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  RegisterProviderRequest._() : super();
  factory RegisterProviderRequest({
    $core.String? providerId,
    $core.String? providerCode,
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (providerCode != null) {
      _result.providerCode = providerCode;
    }
    if (latitude != null) {
      _result.latitude = latitude;
    }
    if (longitude != null) {
      _result.longitude = longitude;
    }
    return _result;
  }
  factory RegisterProviderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterProviderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterProviderRequest clone() => RegisterProviderRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterProviderRequest copyWith(void Function(RegisterProviderRequest) updates) => super.copyWith((message) => updates(message as RegisterProviderRequest)) as RegisterProviderRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterProviderRequest create() => RegisterProviderRequest._();
  RegisterProviderRequest createEmptyInstance() => create();
  static $pb.PbList<RegisterProviderRequest> createRepeated() => $pb.PbList<RegisterProviderRequest>();
  @$core.pragma('dart2js:noInline')
  static RegisterProviderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterProviderRequest>(create);
  static RegisterProviderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get latitude => $_getN(2);
  @$pb.TagNumber(3)
  set latitude($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLatitude() => $_has(2);
  @$pb.TagNumber(3)
  void clearLatitude() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get longitude => $_getN(3);
  @$pb.TagNumber(4)
  set longitude($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLongitude() => $_has(3);
  @$pb.TagNumber(4)
  void clearLongitude() => clearField(4);
}

class RegisterProviderResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterProviderResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerCode')
    ..hasRequiredFields = false
  ;

  RegisterProviderResponse._() : super();
  factory RegisterProviderResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? providerCode,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (providerCode != null) {
      _result.providerCode = providerCode;
    }
    return _result;
  }
  factory RegisterProviderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterProviderResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterProviderResponse clone() => RegisterProviderResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterProviderResponse copyWith(void Function(RegisterProviderResponse) updates) => super.copyWith((message) => updates(message as RegisterProviderResponse)) as RegisterProviderResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterProviderResponse create() => RegisterProviderResponse._();
  RegisterProviderResponse createEmptyInstance() => create();
  static $pb.PbList<RegisterProviderResponse> createRepeated() => $pb.PbList<RegisterProviderResponse>();
  @$core.pragma('dart2js:noInline')
  static RegisterProviderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterProviderResponse>(create);
  static RegisterProviderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get providerCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderCode() => clearField(3);
}

class SetAvailabilityRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetAvailabilityRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAvailable')
    ..hasRequiredFields = false
  ;

  SetAvailabilityRequest._() : super();
  factory SetAvailabilityRequest({
    $core.String? providerId,
    $core.bool? isAvailable,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (isAvailable != null) {
      _result.isAvailable = isAvailable;
    }
    return _result;
  }
  factory SetAvailabilityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetAvailabilityRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetAvailabilityRequest clone() => SetAvailabilityRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetAvailabilityRequest copyWith(void Function(SetAvailabilityRequest) updates) => super.copyWith((message) => updates(message as SetAvailabilityRequest)) as SetAvailabilityRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetAvailabilityRequest create() => SetAvailabilityRequest._();
  SetAvailabilityRequest createEmptyInstance() => create();
  static $pb.PbList<SetAvailabilityRequest> createRepeated() => $pb.PbList<SetAvailabilityRequest>();
  @$core.pragma('dart2js:noInline')
  static SetAvailabilityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetAvailabilityRequest>(create);
  static SetAvailabilityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isAvailable => $_getBF(1);
  @$pb.TagNumber(2)
  set isAvailable($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsAvailable() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsAvailable() => clearField(2);
}

class SetAvailabilityResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SetAvailabilityResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerCode')
    ..hasRequiredFields = false
  ;

  SetAvailabilityResponse._() : super();
  factory SetAvailabilityResponse({
    $core.bool? success,
    $core.String? providerCode,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (providerCode != null) {
      _result.providerCode = providerCode;
    }
    return _result;
  }
  factory SetAvailabilityResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetAvailabilityResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetAvailabilityResponse clone() => SetAvailabilityResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetAvailabilityResponse copyWith(void Function(SetAvailabilityResponse) updates) => super.copyWith((message) => updates(message as SetAvailabilityResponse)) as SetAvailabilityResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SetAvailabilityResponse create() => SetAvailabilityResponse._();
  SetAvailabilityResponse createEmptyInstance() => create();
  static $pb.PbList<SetAvailabilityResponse> createRepeated() => $pb.PbList<SetAvailabilityResponse>();
  @$core.pragma('dart2js:noInline')
  static SetAvailabilityResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetAvailabilityResponse>(create);
  static SetAvailabilityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderCode() => clearField(2);
}

class ListProvidersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListProvidersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  ListProvidersRequest._() : super();
  factory ListProvidersRequest() => create();
  factory ListProvidersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListProvidersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListProvidersRequest clone() => ListProvidersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListProvidersRequest copyWith(void Function(ListProvidersRequest) updates) => super.copyWith((message) => updates(message as ListProvidersRequest)) as ListProvidersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListProvidersRequest create() => ListProvidersRequest._();
  ListProvidersRequest createEmptyInstance() => create();
  static $pb.PbList<ListProvidersRequest> createRepeated() => $pb.PbList<ListProvidersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListProvidersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListProvidersRequest>(create);
  static ListProvidersRequest? _defaultInstance;
}

class ListProvidersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListProvidersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..pc<ProviderStatusEvent>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providers', $pb.PbFieldType.PM, subBuilder: ProviderStatusEvent.create)
    ..hasRequiredFields = false
  ;

  ListProvidersResponse._() : super();
  factory ListProvidersResponse({
    $core.Iterable<ProviderStatusEvent>? providers,
  }) {
    final _result = create();
    if (providers != null) {
      _result.providers.addAll(providers);
    }
    return _result;
  }
  factory ListProvidersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListProvidersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListProvidersResponse clone() => ListProvidersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListProvidersResponse copyWith(void Function(ListProvidersResponse) updates) => super.copyWith((message) => updates(message as ListProvidersResponse)) as ListProvidersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListProvidersResponse create() => ListProvidersResponse._();
  ListProvidersResponse createEmptyInstance() => create();
  static $pb.PbList<ListProvidersResponse> createRepeated() => $pb.PbList<ListProvidersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListProvidersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListProvidersResponse>(create);
  static ListProvidersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ProviderStatusEvent> get providers => $_getList(0);
}

class SearchRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerCode')
    ..hasRequiredFields = false
  ;

  SearchRequest._() : super();
  factory SearchRequest({
    $core.String? providerCode,
  }) {
    final _result = create();
    if (providerCode != null) {
      _result.providerCode = providerCode;
    }
    return _result;
  }
  factory SearchRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchRequest clone() => SearchRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchRequest copyWith(void Function(SearchRequest) updates) => super.copyWith((message) => updates(message as SearchRequest)) as SearchRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchRequest create() => SearchRequest._();
  SearchRequest createEmptyInstance() => create();
  static $pb.PbList<SearchRequest> createRepeated() => $pb.PbList<SearchRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchRequest>(create);
  static SearchRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerCode => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerCode($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderCode() => clearField(1);
}

class SearchResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SearchResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAvailable')
    ..hasRequiredFields = false
  ;

  SearchResponse._() : super();
  factory SearchResponse({
    $core.bool? success,
    $core.String? message,
    $core.String? providerId,
    $core.bool? isAvailable,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (message != null) {
      _result.message = message;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (isAvailable != null) {
      _result.isAvailable = isAvailable;
    }
    return _result;
  }
  factory SearchResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SearchResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SearchResponse clone() => SearchResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SearchResponse copyWith(void Function(SearchResponse) updates) => super.copyWith((message) => updates(message as SearchResponse)) as SearchResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SearchResponse create() => SearchResponse._();
  SearchResponse createEmptyInstance() => create();
  static $pb.PbList<SearchResponse> createRepeated() => $pb.PbList<SearchResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SearchResponse>(create);
  static SearchResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get providerId => $_getSZ(2);
  @$pb.TagNumber(3)
  set providerId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProviderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearProviderId() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isAvailable => $_getBF(3);
  @$pb.TagNumber(4)
  set isAvailable($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsAvailable() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsAvailable() => clearField(4);
}

class ProviderStatusEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ProviderStatusEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerCode')
    ..aOB(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'isAvailable')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'longitude', $pb.PbFieldType.OD)
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..hasRequiredFields = false
  ;

  ProviderStatusEvent._() : super();
  factory ProviderStatusEvent({
    $core.String? providerId,
    $core.String? providerCode,
    $core.bool? isAvailable,
    $core.double? latitude,
    $core.double? longitude,
    $fixnum.Int64? timestamp,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (providerCode != null) {
      _result.providerCode = providerCode;
    }
    if (isAvailable != null) {
      _result.isAvailable = isAvailable;
    }
    if (latitude != null) {
      _result.latitude = latitude;
    }
    if (longitude != null) {
      _result.longitude = longitude;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    return _result;
  }
  factory ProviderStatusEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProviderStatusEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProviderStatusEvent clone() => ProviderStatusEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProviderStatusEvent copyWith(void Function(ProviderStatusEvent) updates) => super.copyWith((message) => updates(message as ProviderStatusEvent)) as ProviderStatusEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ProviderStatusEvent create() => ProviderStatusEvent._();
  ProviderStatusEvent createEmptyInstance() => create();
  static $pb.PbList<ProviderStatusEvent> createRepeated() => $pb.PbList<ProviderStatusEvent>();
  @$core.pragma('dart2js:noInline')
  static ProviderStatusEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProviderStatusEvent>(create);
  static ProviderStatusEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerCode($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isAvailable => $_getBF(2);
  @$pb.TagNumber(3)
  set isAvailable($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsAvailable() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsAvailable() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get latitude => $_getN(3);
  @$pb.TagNumber(4)
  set latitude($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLatitude() => $_has(3);
  @$pb.TagNumber(4)
  void clearLatitude() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get longitude => $_getN(4);
  @$pb.TagNumber(5)
  set longitude($core.double v) { $_setDouble(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLongitude() => $_has(4);
  @$pb.TagNumber(5)
  void clearLongitude() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get timestamp => $_getI64(5);
  @$pb.TagNumber(6)
  set timestamp($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => clearField(6);
}

class IncomingCallsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IncomingCallsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..hasRequiredFields = false
  ;

  IncomingCallsRequest._() : super();
  factory IncomingCallsRequest({
    $core.String? providerId,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    return _result;
  }
  factory IncomingCallsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IncomingCallsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IncomingCallsRequest clone() => IncomingCallsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IncomingCallsRequest copyWith(void Function(IncomingCallsRequest) updates) => super.copyWith((message) => updates(message as IncomingCallsRequest)) as IncomingCallsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IncomingCallsRequest create() => IncomingCallsRequest._();
  IncomingCallsRequest createEmptyInstance() => create();
  static $pb.PbList<IncomingCallsRequest> createRepeated() => $pb.PbList<IncomingCallsRequest>();
  @$core.pragma('dart2js:noInline')
  static IncomingCallsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IncomingCallsRequest>(create);
  static IncomingCallsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);
}

class IncomingCallEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IncomingCallEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'callId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'consumerId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'consumerName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purpose')
    ..hasRequiredFields = false
  ;

  IncomingCallEvent._() : super();
  factory IncomingCallEvent({
    $core.String? callId,
    $core.String? consumerId,
    $core.String? consumerName,
    $core.String? purpose,
  }) {
    final _result = create();
    if (callId != null) {
      _result.callId = callId;
    }
    if (consumerId != null) {
      _result.consumerId = consumerId;
    }
    if (consumerName != null) {
      _result.consumerName = consumerName;
    }
    if (purpose != null) {
      _result.purpose = purpose;
    }
    return _result;
  }
  factory IncomingCallEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IncomingCallEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IncomingCallEvent clone() => IncomingCallEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IncomingCallEvent copyWith(void Function(IncomingCallEvent) updates) => super.copyWith((message) => updates(message as IncomingCallEvent)) as IncomingCallEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IncomingCallEvent create() => IncomingCallEvent._();
  IncomingCallEvent createEmptyInstance() => create();
  static $pb.PbList<IncomingCallEvent> createRepeated() => $pb.PbList<IncomingCallEvent>();
  @$core.pragma('dart2js:noInline')
  static IncomingCallEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IncomingCallEvent>(create);
  static IncomingCallEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get callId => $_getSZ(0);
  @$pb.TagNumber(1)
  set callId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCallId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCallId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get consumerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set consumerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConsumerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConsumerId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get consumerName => $_getSZ(2);
  @$pb.TagNumber(3)
  set consumerName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConsumerName() => $_has(2);
  @$pb.TagNumber(3)
  void clearConsumerName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get purpose => $_getSZ(3);
  @$pb.TagNumber(4)
  set purpose($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPurpose() => $_has(3);
  @$pb.TagNumber(4)
  void clearPurpose() => clearField(4);
}

class CallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CallRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'consumerId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'consumerName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'purpose')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerCode')
    ..hasRequiredFields = false
  ;

  CallRequest._() : super();
  factory CallRequest({
    $core.String? providerId,
    $core.String? consumerId,
    $core.String? consumerName,
    $core.String? purpose,
    $core.String? providerCode,
  }) {
    final _result = create();
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (consumerId != null) {
      _result.consumerId = consumerId;
    }
    if (consumerName != null) {
      _result.consumerName = consumerName;
    }
    if (purpose != null) {
      _result.purpose = purpose;
    }
    if (providerCode != null) {
      _result.providerCode = providerCode;
    }
    return _result;
  }
  factory CallRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CallRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CallRequest clone() => CallRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CallRequest copyWith(void Function(CallRequest) updates) => super.copyWith((message) => updates(message as CallRequest)) as CallRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CallRequest create() => CallRequest._();
  CallRequest createEmptyInstance() => create();
  static $pb.PbList<CallRequest> createRepeated() => $pb.PbList<CallRequest>();
  @$core.pragma('dart2js:noInline')
  static CallRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CallRequest>(create);
  static CallRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get consumerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set consumerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConsumerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConsumerId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get consumerName => $_getSZ(2);
  @$pb.TagNumber(3)
  set consumerName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConsumerName() => $_has(2);
  @$pb.TagNumber(3)
  void clearConsumerName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get purpose => $_getSZ(3);
  @$pb.TagNumber(4)
  set purpose($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPurpose() => $_has(3);
  @$pb.TagNumber(4)
  void clearPurpose() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get providerCode => $_getSZ(4);
  @$pb.TagNumber(5)
  set providerCode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProviderCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearProviderCode() => clearField(5);
}

class CallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CallResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'callId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CallResponse._() : super();
  factory CallResponse({
    $core.bool? success,
    $core.String? callId,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (callId != null) {
      _result.callId = callId;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CallResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CallResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CallResponse clone() => CallResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CallResponse copyWith(void Function(CallResponse) updates) => super.copyWith((message) => updates(message as CallResponse)) as CallResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CallResponse create() => CallResponse._();
  CallResponse createEmptyInstance() => create();
  static $pb.PbList<CallResponse> createRepeated() => $pb.PbList<CallResponse>();
  @$core.pragma('dart2js:noInline')
  static CallResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CallResponse>(create);
  static CallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get callId => $_getSZ(1);
  @$pb.TagNumber(2)
  set callId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCallId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCallId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class AnswerCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnswerCallRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'callId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..hasRequiredFields = false
  ;

  AnswerCallRequest._() : super();
  factory AnswerCallRequest({
    $core.String? callId,
    $core.String? providerId,
  }) {
    final _result = create();
    if (callId != null) {
      _result.callId = callId;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    return _result;
  }
  factory AnswerCallRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnswerCallRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnswerCallRequest clone() => AnswerCallRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnswerCallRequest copyWith(void Function(AnswerCallRequest) updates) => super.copyWith((message) => updates(message as AnswerCallRequest)) as AnswerCallRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AnswerCallRequest create() => AnswerCallRequest._();
  AnswerCallRequest createEmptyInstance() => create();
  static $pb.PbList<AnswerCallRequest> createRepeated() => $pb.PbList<AnswerCallRequest>();
  @$core.pragma('dart2js:noInline')
  static AnswerCallRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnswerCallRequest>(create);
  static AnswerCallRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get callId => $_getSZ(0);
  @$pb.TagNumber(1)
  set callId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCallId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCallId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderId() => clearField(2);
}

class AnswerCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnswerCallResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  AnswerCallResponse._() : super();
  factory AnswerCallResponse({
    $core.bool? success,
    $core.String? sessionId,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    if (sessionId != null) {
      _result.sessionId = sessionId;
    }
    return _result;
  }
  factory AnswerCallResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnswerCallResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnswerCallResponse clone() => AnswerCallResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnswerCallResponse copyWith(void Function(AnswerCallResponse) updates) => super.copyWith((message) => updates(message as AnswerCallResponse)) as AnswerCallResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AnswerCallResponse create() => AnswerCallResponse._();
  AnswerCallResponse createEmptyInstance() => create();
  static $pb.PbList<AnswerCallResponse> createRepeated() => $pb.PbList<AnswerCallResponse>();
  @$core.pragma('dart2js:noInline')
  static AnswerCallResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnswerCallResponse>(create);
  static AnswerCallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSessionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionId() => clearField(2);
}

class DeclineCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeclineCallRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'callId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'providerId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  DeclineCallRequest._() : super();
  factory DeclineCallRequest({
    $core.String? callId,
    $core.String? providerId,
    $core.String? reason,
  }) {
    final _result = create();
    if (callId != null) {
      _result.callId = callId;
    }
    if (providerId != null) {
      _result.providerId = providerId;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory DeclineCallRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeclineCallRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeclineCallRequest clone() => DeclineCallRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeclineCallRequest copyWith(void Function(DeclineCallRequest) updates) => super.copyWith((message) => updates(message as DeclineCallRequest)) as DeclineCallRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeclineCallRequest create() => DeclineCallRequest._();
  DeclineCallRequest createEmptyInstance() => create();
  static $pb.PbList<DeclineCallRequest> createRepeated() => $pb.PbList<DeclineCallRequest>();
  @$core.pragma('dart2js:noInline')
  static DeclineCallRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineCallRequest>(create);
  static DeclineCallRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get callId => $_getSZ(0);
  @$pb.TagNumber(1)
  set callId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCallId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCallId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get providerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProviderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearProviderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearReason() => clearField(3);
}

class DeclineCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeclineCallResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  DeclineCallResponse._() : super();
  factory DeclineCallResponse({
    $core.bool? success,
  }) {
    final _result = create();
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory DeclineCallResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeclineCallResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeclineCallResponse clone() => DeclineCallResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeclineCallResponse copyWith(void Function(DeclineCallResponse) updates) => super.copyWith((message) => updates(message as DeclineCallResponse)) as DeclineCallResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeclineCallResponse create() => DeclineCallResponse._();
  DeclineCallResponse createEmptyInstance() => create();
  static $pb.PbList<DeclineCallResponse> createRepeated() => $pb.PbList<DeclineCallResponse>();
  @$core.pragma('dart2js:noInline')
  static DeclineCallResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineCallResponse>(create);
  static DeclineCallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => clearField(1);
}

enum ConnectionEvent_Payload {
  ice, 
  sdp, 
  end, 
  notSet
}

class ConnectionEvent extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ConnectionEvent_Payload> _ConnectionEvent_PayloadByTag = {
    6 : ConnectionEvent_Payload.ice,
    7 : ConnectionEvent_Payload.sdp,
    8 : ConnectionEvent_Payload.end,
    0 : ConnectionEvent_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectionEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..oo(0, [6, 7, 8])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'callId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'receiverId')
    ..aOM<IceCandidate>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ice', subBuilder: IceCandidate.create)
    ..aOM<SessionDescription>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sdp', subBuilder: SessionDescription.create)
    ..aOM<EndCall>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'end', subBuilder: EndCall.create)
    ..hasRequiredFields = false
  ;

  ConnectionEvent._() : super();
  factory ConnectionEvent({
    $core.String? callId,
    $core.String? senderId,
    $core.String? receiverId,
    IceCandidate? ice,
    SessionDescription? sdp,
    EndCall? end,
  }) {
    final _result = create();
    if (callId != null) {
      _result.callId = callId;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (receiverId != null) {
      _result.receiverId = receiverId;
    }
    if (ice != null) {
      _result.ice = ice;
    }
    if (sdp != null) {
      _result.sdp = sdp;
    }
    if (end != null) {
      _result.end = end;
    }
    return _result;
  }
  factory ConnectionEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectionEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectionEvent clone() => ConnectionEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectionEvent copyWith(void Function(ConnectionEvent) updates) => super.copyWith((message) => updates(message as ConnectionEvent)) as ConnectionEvent; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectionEvent create() => ConnectionEvent._();
  ConnectionEvent createEmptyInstance() => create();
  static $pb.PbList<ConnectionEvent> createRepeated() => $pb.PbList<ConnectionEvent>();
  @$core.pragma('dart2js:noInline')
  static ConnectionEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectionEvent>(create);
  static ConnectionEvent? _defaultInstance;

  ConnectionEvent_Payload whichPayload() => _ConnectionEvent_PayloadByTag[$_whichOneof(0)]!;
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
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get receiverId => $_getSZ(2);
  @$pb.TagNumber(3)
  set receiverId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReceiverId() => $_has(2);
  @$pb.TagNumber(3)
  void clearReceiverId() => clearField(3);

  @$pb.TagNumber(6)
  IceCandidate get ice => $_getN(3);
  @$pb.TagNumber(6)
  set ice(IceCandidate v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasIce() => $_has(3);
  @$pb.TagNumber(6)
  void clearIce() => clearField(6);
  @$pb.TagNumber(6)
  IceCandidate ensureIce() => $_ensure(3);

  @$pb.TagNumber(7)
  SessionDescription get sdp => $_getN(4);
  @$pb.TagNumber(7)
  set sdp(SessionDescription v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasSdp() => $_has(4);
  @$pb.TagNumber(7)
  void clearSdp() => clearField(7);
  @$pb.TagNumber(7)
  SessionDescription ensureSdp() => $_ensure(4);

  @$pb.TagNumber(8)
  EndCall get end => $_getN(5);
  @$pb.TagNumber(8)
  set end(EndCall v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasEnd() => $_has(5);
  @$pb.TagNumber(8)
  void clearEnd() => clearField(8);
  @$pb.TagNumber(8)
  EndCall ensureEnd() => $_ensure(5);
}

class IceCandidate extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'IceCandidate', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'candidate')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sdpMid')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sdpMLineIndex', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  IceCandidate._() : super();
  factory IceCandidate({
    $core.String? candidate,
    $core.String? sdpMid,
    $core.int? sdpMLineIndex,
  }) {
    final _result = create();
    if (candidate != null) {
      _result.candidate = candidate;
    }
    if (sdpMid != null) {
      _result.sdpMid = sdpMid;
    }
    if (sdpMLineIndex != null) {
      _result.sdpMLineIndex = sdpMLineIndex;
    }
    return _result;
  }
  factory IceCandidate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IceCandidate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IceCandidate clone() => IceCandidate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IceCandidate copyWith(void Function(IceCandidate) updates) => super.copyWith((message) => updates(message as IceCandidate)) as IceCandidate; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static IceCandidate create() => IceCandidate._();
  IceCandidate createEmptyInstance() => create();
  static $pb.PbList<IceCandidate> createRepeated() => $pb.PbList<IceCandidate>();
  @$core.pragma('dart2js:noInline')
  static IceCandidate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IceCandidate>(create);
  static IceCandidate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get candidate => $_getSZ(0);
  @$pb.TagNumber(1)
  set candidate($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCandidate() => $_has(0);
  @$pb.TagNumber(1)
  void clearCandidate() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sdpMid => $_getSZ(1);
  @$pb.TagNumber(2)
  set sdpMid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSdpMid() => $_has(1);
  @$pb.TagNumber(2)
  void clearSdpMid() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get sdpMLineIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set sdpMLineIndex($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSdpMLineIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearSdpMLineIndex() => clearField(3);
}

class SessionDescription extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SessionDescription', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sdp')
    ..hasRequiredFields = false
  ;

  SessionDescription._() : super();
  factory SessionDescription({
    $core.String? type,
    $core.String? sdp,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (sdp != null) {
      _result.sdp = sdp;
    }
    return _result;
  }
  factory SessionDescription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SessionDescription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SessionDescription clone() => SessionDescription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SessionDescription copyWith(void Function(SessionDescription) updates) => super.copyWith((message) => updates(message as SessionDescription)) as SessionDescription; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SessionDescription create() => SessionDescription._();
  SessionDescription createEmptyInstance() => create();
  static $pb.PbList<SessionDescription> createRepeated() => $pb.PbList<SessionDescription>();
  @$core.pragma('dart2js:noInline')
  static SessionDescription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SessionDescription>(create);
  static SessionDescription? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sdp => $_getSZ(1);
  @$pb.TagNumber(2)
  set sdp($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSdp() => $_has(1);
  @$pb.TagNumber(2)
  void clearSdp() => clearField(2);
}

class EndCall extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EndCall', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  EndCall._() : super();
  factory EndCall({
    $core.String? reason,
  }) {
    final _result = create();
    if (reason != null) {
      _result.reason = reason;
    }
    return _result;
  }
  factory EndCall.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EndCall.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EndCall clone() => EndCall()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EndCall copyWith(void Function(EndCall) updates) => super.copyWith((message) => updates(message as EndCall)) as EndCall; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EndCall create() => EndCall._();
  EndCall createEmptyInstance() => create();
  static $pb.PbList<EndCall> createRepeated() => $pb.PbList<EndCall>();
  @$core.pragma('dart2js:noInline')
  static EndCall getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EndCall>(create);
  static EndCall? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reason => $_getSZ(0);
  @$pb.TagNumber(1)
  set reason($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasReason() => $_has(0);
  @$pb.TagNumber(1)
  void clearReason() => clearField(1);
}

enum ControlEvent_Payload {
  command, 
  gyro, 
  ack, 
  state, 
  notSet
}

class ControlEvent extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, ControlEvent_Payload> _ControlEvent_PayloadByTag = {
    3 : ControlEvent_Payload.command,
    4 : ControlEvent_Payload.gyro,
    5 : ControlEvent_Payload.ack,
    6 : ControlEvent_Payload.state,
    0 : ControlEvent_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ControlEvent', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'callId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..aOM<CameraCommand>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'command', subBuilder: CameraCommand.create)
    ..aOM<GyroData>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gyro', subBuilder: GyroData.create)
    ..aOM<ControlAck>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ack', subBuilder: ControlAck.create)
    ..aOM<CameraState>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'state', subBuilder: CameraState.create)
    ..hasRequiredFields = false
  ;

  ControlEvent._() : super();
  factory ControlEvent({
    $core.String? callId,
    $core.String? senderId,
    CameraCommand? command,
    GyroData? gyro,
    ControlAck? ack,
    CameraState? state,
  }) {
    final _result = create();
    if (callId != null) {
      _result.callId = callId;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (command != null) {
      _result.command = command;
    }
    if (gyro != null) {
      _result.gyro = gyro;
    }
    if (ack != null) {
      _result.ack = ack;
    }
    if (state != null) {
      _result.state = state;
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
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(2)
  set senderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderId() => clearField(2);

  @$pb.TagNumber(3)
  CameraCommand get command => $_getN(2);
  @$pb.TagNumber(3)
  set command(CameraCommand v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCommand() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommand() => clearField(3);
  @$pb.TagNumber(3)
  CameraCommand ensureCommand() => $_ensure(2);

  @$pb.TagNumber(4)
  GyroData get gyro => $_getN(3);
  @$pb.TagNumber(4)
  set gyro(GyroData v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGyro() => $_has(3);
  @$pb.TagNumber(4)
  void clearGyro() => clearField(4);
  @$pb.TagNumber(4)
  GyroData ensureGyro() => $_ensure(3);

  @$pb.TagNumber(5)
  ControlAck get ack => $_getN(4);
  @$pb.TagNumber(5)
  set ack(ControlAck v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasAck() => $_has(4);
  @$pb.TagNumber(5)
  void clearAck() => clearField(5);
  @$pb.TagNumber(5)
  ControlAck ensureAck() => $_ensure(4);

  @$pb.TagNumber(6)
  CameraState get state => $_getN(5);
  @$pb.TagNumber(6)
  set state(CameraState v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasState() => $_has(5);
  @$pb.TagNumber(6)
  void clearState() => clearField(6);
  @$pb.TagNumber(6)
  CameraState ensureState() => $_ensure(5);
}

class CameraState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CameraState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'zoomLevel', $pb.PbFieldType.OF)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'anchorX', $pb.PbFieldType.OF)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'anchorY', $pb.PbFieldType.OF)
    ..e<ControlModeType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: ControlModeType.CONTROL_MODE_BUTTON, valueOf: ControlModeType.valueOf, enumValues: ControlModeType.values)
    ..hasRequiredFields = false
  ;

  CameraState._() : super();
  factory CameraState({
    $core.double? zoomLevel,
    $core.double? anchorX,
    $core.double? anchorY,
    ControlModeType? mode,
  }) {
    final _result = create();
    if (zoomLevel != null) {
      _result.zoomLevel = zoomLevel;
    }
    if (anchorX != null) {
      _result.anchorX = anchorX;
    }
    if (anchorY != null) {
      _result.anchorY = anchorY;
    }
    if (mode != null) {
      _result.mode = mode;
    }
    return _result;
  }
  factory CameraState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraState clone() => CameraState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraState copyWith(void Function(CameraState) updates) => super.copyWith((message) => updates(message as CameraState)) as CameraState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraState create() => CameraState._();
  CameraState createEmptyInstance() => create();
  static $pb.PbList<CameraState> createRepeated() => $pb.PbList<CameraState>();
  @$core.pragma('dart2js:noInline')
  static CameraState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraState>(create);
  static CameraState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get zoomLevel => $_getN(0);
  @$pb.TagNumber(1)
  set zoomLevel($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasZoomLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearZoomLevel() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get anchorX => $_getN(1);
  @$pb.TagNumber(2)
  set anchorX($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAnchorX() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnchorX() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get anchorY => $_getN(2);
  @$pb.TagNumber(3)
  set anchorY($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAnchorY() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnchorY() => clearField(3);

  @$pb.TagNumber(4)
  ControlModeType get mode => $_getN(3);
  @$pb.TagNumber(4)
  set mode(ControlModeType v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMode() => $_has(3);
  @$pb.TagNumber(4)
  void clearMode() => clearField(4);
}

class CameraCommand extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CameraCommand', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..e<CommandType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: CommandType.UNKNOWN, valueOf: CommandType.valueOf, enumValues: CommandType.values)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  CameraCommand._() : super();
  factory CameraCommand({
    CommandType? type,
    $core.double? value,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory CameraCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CameraCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CameraCommand clone() => CameraCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CameraCommand copyWith(void Function(CameraCommand) updates) => super.copyWith((message) => updates(message as CameraCommand)) as CameraCommand; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CameraCommand create() => CameraCommand._();
  CameraCommand createEmptyInstance() => create();
  static $pb.PbList<CameraCommand> createRepeated() => $pb.PbList<CameraCommand>();
  @$core.pragma('dart2js:noInline')
  static CameraCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CameraCommand>(create);
  static CameraCommand? _defaultInstance;

  @$pb.TagNumber(1)
  CommandType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(CommandType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => clearField(2);
}

class GyroData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GyroData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OF)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OF)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'z', $pb.PbFieldType.OF)
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roll', $pb.PbFieldType.OF)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pitch', $pb.PbFieldType.OF)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'yaw', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  GyroData._() : super();
  factory GyroData({
    $core.double? x,
    $core.double? y,
    $core.double? z,
    $core.double? roll,
    $core.double? pitch,
    $core.double? yaw,
  }) {
    final _result = create();
    if (x != null) {
      _result.x = x;
    }
    if (y != null) {
      _result.y = y;
    }
    if (z != null) {
      _result.z = z;
    }
    if (roll != null) {
      _result.roll = roll;
    }
    if (pitch != null) {
      _result.pitch = pitch;
    }
    if (yaw != null) {
      _result.yaw = yaw;
    }
    return _result;
  }
  factory GyroData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GyroData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GyroData clone() => GyroData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GyroData copyWith(void Function(GyroData) updates) => super.copyWith((message) => updates(message as GyroData)) as GyroData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GyroData create() => GyroData._();
  GyroData createEmptyInstance() => create();
  static $pb.PbList<GyroData> createRepeated() => $pb.PbList<GyroData>();
  @$core.pragma('dart2js:noInline')
  static GyroData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GyroData>(create);
  static GyroData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get x => $_getN(0);
  @$pb.TagNumber(1)
  set x($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get y => $_getN(1);
  @$pb.TagNumber(2)
  set y($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get z => $_getN(2);
  @$pb.TagNumber(3)
  set z($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasZ() => $_has(2);
  @$pb.TagNumber(3)
  void clearZ() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get roll => $_getN(3);
  @$pb.TagNumber(4)
  set roll($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRoll() => $_has(3);
  @$pb.TagNumber(4)
  void clearRoll() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get pitch => $_getN(4);
  @$pb.TagNumber(5)
  set pitch($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPitch() => $_has(4);
  @$pb.TagNumber(5)
  void clearPitch() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get yaw => $_getN(5);
  @$pb.TagNumber(6)
  set yaw($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasYaw() => $_has(5);
  @$pb.TagNumber(6)
  void clearYaw() => clearField(6);
}

class ControlAck extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ControlAck', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'xeniq'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'commandId')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'success')
    ..hasRequiredFields = false
  ;

  ControlAck._() : super();
  factory ControlAck({
    $core.String? commandId,
    $core.bool? success,
  }) {
    final _result = create();
    if (commandId != null) {
      _result.commandId = commandId;
    }
    if (success != null) {
      _result.success = success;
    }
    return _result;
  }
  factory ControlAck.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlAck.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlAck clone() => ControlAck()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlAck copyWith(void Function(ControlAck) updates) => super.copyWith((message) => updates(message as ControlAck)) as ControlAck; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ControlAck create() => ControlAck._();
  ControlAck createEmptyInstance() => create();
  static $pb.PbList<ControlAck> createRepeated() => $pb.PbList<ControlAck>();
  @$core.pragma('dart2js:noInline')
  static ControlAck getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ControlAck>(create);
  static ControlAck? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get commandId => $_getSZ(0);
  @$pb.TagNumber(1)
  set commandId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCommandId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommandId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => clearField(2);
}

