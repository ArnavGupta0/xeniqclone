
// --- MANUALLY ADDED MESSAGES due to protoc failure ---

class RegisterProviderRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RegisterProviderRequest', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOS(1, 'providerId')
    ..aOS(2, 'providerCode')
    ..a<$core.double>(3, 'latitude', $pb.PbFieldType.OD)
    ..a<$core.double>(4, 'longitude', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  RegisterProviderRequest._() : super();
  factory RegisterProviderRequest({
    $core.String? providerId,
    $core.String? providerCode,
    $core.double? latitude,
    $core.double? longitude,
  }) {
    final _result = create();
    if (providerId != null) _result.providerId = providerId;
    if (providerCode != null) _result.providerCode = providerCode;
    if (latitude != null) _result.latitude = latitude;
    if (longitude != null) _result.longitude = longitude;
    return _result;
  }
  factory RegisterProviderRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterProviderRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RegisterProviderRequest clone() => RegisterProviderRequest()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static RegisterProviderRequest create() => RegisterProviderRequest._();
  static $pb.PbList<RegisterProviderRequest> createRepeated() => $pb.PbList<RegisterProviderRequest>();
  static RegisterProviderRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterProviderRequest>(create);
  static RegisterProviderRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  
  @$pb.TagNumber(2)
  $core.String get providerCode => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerCode($core.String v) { $_setString(1, v); }
  
  @$pb.TagNumber(3)
  $core.double get latitude => $_getN(2);
  @$pb.TagNumber(3)
  set latitude($core.double v) { $_setDouble(2, v); }

  @$pb.TagNumber(4)
  $core.double get longitude => $_getN(3);
  @$pb.TagNumber(4)
  set longitude($core.double v) { $_setDouble(3, v); }
}

class RegisterProviderResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RegisterProviderResponse', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..aOS(2, 'message')
    ..hasRequiredFields = false;

  RegisterProviderResponse._() : super();
  factory RegisterProviderResponse({
    $core.bool? success,
    $core.String? message,
  }) {
    final _result = create();
    if (success != null) _result.success = success;
    if (message != null) _result.message = message;
    return _result;
  }
  factory RegisterProviderResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  RegisterProviderResponse clone() => RegisterProviderResponse()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static RegisterProviderResponse create() => RegisterProviderResponse._();
  static RegisterProviderResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterProviderResponse>(create);
  static RegisterProviderResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
  
  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
}

class SetAvailabilityRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SetAvailabilityRequest', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOS(1, 'providerId')
    ..aOB(2, 'isAvailable')
    ..hasRequiredFields = false;

  SetAvailabilityRequest._() : super();
  factory SetAvailabilityRequest({
    $core.String? providerId,
    $core.bool? isAvailable,
  }) {
    final _result = create();
    if (providerId != null) _result.providerId = providerId;
    if (isAvailable != null) _result.isAvailable = isAvailable;
    return _result;
  }
  factory SetAvailabilityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  SetAvailabilityRequest clone() => SetAvailabilityRequest()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static SetAvailabilityRequest create() => SetAvailabilityRequest._();
  static SetAvailabilityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetAvailabilityRequest>(create);
  static SetAvailabilityRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
  
  @$pb.TagNumber(2)
  $core.bool get isAvailable => $_getBF(1);
  @$pb.TagNumber(2)
  set isAvailable($core.bool v) { $_setBool(1, v); }
}

class SetAvailabilityResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SetAvailabilityResponse', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..hasRequiredFields = false;

  SetAvailabilityResponse._() : super();
  factory SetAvailabilityResponse({ $core.bool? success }) {
    final _result = create();
    if (success != null) _result.success = success;
    return _result;
  }
  factory SetAvailabilityResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  SetAvailabilityResponse clone() => SetAvailabilityResponse()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static SetAvailabilityResponse create() => SetAvailabilityResponse._();
  static SetAvailabilityResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetAvailabilityResponse>(create);
  static SetAvailabilityResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
}

class IncomingCallsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('IncomingCallsRequest', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOS(1, 'providerId')
    ..hasRequiredFields = false;

  IncomingCallsRequest._() : super();
  factory IncomingCallsRequest({ $core.String? providerId }) {
    final _result = create();
    if (providerId != null) _result.providerId = providerId;
    return _result;
  }
  factory IncomingCallsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  IncomingCallsRequest clone() => IncomingCallsRequest()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static IncomingCallsRequest create() => IncomingCallsRequest._();
  static IncomingCallsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IncomingCallsRequest>(create);
  static IncomingCallsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) { $_setString(0, v); }
}

class IncomingCallEvent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('IncomingCallEvent', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOS(1, 'callId')
    ..aOS(2, 'consumerId')
    ..aOS(3, 'consumerName')
    ..aOS(4, 'purpose')
    ..hasRequiredFields = false;

  IncomingCallEvent._() : super();
  factory IncomingCallEvent({
    $core.String? callId,
    $core.String? consumerId,
    $core.String? consumerName,
    $core.String? purpose,
  }) {
    final _result = create();
    if (callId != null) _result.callId = callId;
    if (consumerId != null) _result.consumerId = consumerId;
    if (consumerName != null) _result.consumerName = consumerName;
    if (purpose != null) _result.purpose = purpose;
    return _result;
  }
  factory IncomingCallEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  IncomingCallEvent clone() => IncomingCallEvent()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static IncomingCallEvent create() => IncomingCallEvent._();
  static IncomingCallEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IncomingCallEvent>(create);
  static IncomingCallEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get callId => $_getSZ(0);
  @$pb.TagNumber(1)
  set callId($core.String v) { $_setString(0, v); }
  
  @$pb.TagNumber(2)
  $core.String get consumerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set consumerId($core.String v) { $_setString(1, v); }

  @$pb.TagNumber(3)
  $core.String get consumerName => $_getSZ(2);
  @$pb.TagNumber(3)
  set consumerName($core.String v) { $_setString(2, v); }

  @$pb.TagNumber(4)
  $core.String get purpose => $_getSZ(3);
  @$pb.TagNumber(4)
  set purpose($core.String v) { $_setString(3, v); }
}

class AnswerCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AnswerCallRequest', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOS(1, 'callId')
    ..aOS(2, 'providerId')
    ..hasRequiredFields = false;

  AnswerCallRequest._() : super();
  factory AnswerCallRequest({ $core.String? callId, $core.String? providerId }) {
    final _result = create();
    if (callId != null) _result.callId = callId;
    if (providerId != null) _result.providerId = providerId;
    return _result;
  }
  factory AnswerCallRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  AnswerCallRequest clone() => AnswerCallRequest()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static AnswerCallRequest create() => AnswerCallRequest._();
  static AnswerCallRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnswerCallRequest>(create);
  static AnswerCallRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get callId => $_getSZ(0);
  @$pb.TagNumber(1)
  set callId($core.String v) { $_setString(0, v); }
  
  @$pb.TagNumber(2)
  $core.String get providerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerId($core.String v) { $_setString(1, v); }
}

class AnswerCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('AnswerCallResponse', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..aOS(2, 'sessionId')
    ..hasRequiredFields = false;

  AnswerCallResponse._() : super();
  factory AnswerCallResponse({ $core.bool? success, $core.String? sessionId }) {
    final _result = create();
    if (success != null) _result.success = success;
    if (sessionId != null) _result.sessionId = sessionId;
    return _result;
  }
  factory AnswerCallResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  AnswerCallResponse clone() => AnswerCallResponse()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static AnswerCallResponse create() => AnswerCallResponse._();
  static AnswerCallResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnswerCallResponse>(create);
  static AnswerCallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }

  @$pb.TagNumber(2)
  $core.String get sessionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionId($core.String v) { $_setString(1, v); }
}

class DeclineCallRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DeclineCallRequest', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOS(1, 'callId')
    ..aOS(2, 'providerId')
    ..aOS(3, 'reason')
    ..hasRequiredFields = false;

  DeclineCallRequest._() : super();
  factory DeclineCallRequest({ $core.String? callId, $core.String? providerId, $core.String? reason }) {
    final _result = create();
    if (callId != null) _result.callId = callId;
    if (providerId != null) _result.providerId = providerId;
    if (reason != null) _result.reason = reason;
    return _result;
  }
  factory DeclineCallRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  DeclineCallRequest clone() => DeclineCallRequest()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static DeclineCallRequest create() => DeclineCallRequest._();
  static DeclineCallRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineCallRequest>(create);
  static DeclineCallRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get callId => $_getSZ(0);
  @$pb.TagNumber(1)
  set callId($core.String v) { $_setString(0, v); }
  
  @$pb.TagNumber(2)
  $core.String get providerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set providerId($core.String v) { $_setString(1, v); }

  @$pb.TagNumber(3)
  $core.String get reason => $_getSZ(2);
  @$pb.TagNumber(3)
  set reason($core.String v) { $_setString(2, v); }
}

class DeclineCallResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('DeclineCallResponse', package: const $pb.PackageName('xeniq'), createEmptyInstance: create)
    ..aOB(1, 'success')
    ..hasRequiredFields = false;

  DeclineCallResponse._() : super();
  factory DeclineCallResponse({ $core.bool? success }) {
    final _result = create();
    if (success != null) _result.success = success;
    return _result;
  }
  factory DeclineCallResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  DeclineCallResponse clone() => DeclineCallResponse()..mergeFromMessage(this);
  $pb.BuilderInfo get info_ => _i;
  static DeclineCallResponse create() => DeclineCallResponse._();
  static DeclineCallResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeclineCallResponse>(create);
  static DeclineCallResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool v) { $_setBool(0, v); }
}
