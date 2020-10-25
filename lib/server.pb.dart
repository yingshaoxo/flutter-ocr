///
//  Generated code. Do not modify.
//  source: server.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TextRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TextRequest', createEmptyInstance: create)
    ..aOS(1, 'text')
    ..hasRequiredFields = false
  ;

  TextRequest._() : super();
  factory TextRequest() => create();
  factory TextRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TextRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TextRequest clone() => TextRequest()..mergeFromMessage(this);
  TextRequest copyWith(void Function(TextRequest) updates) => super.copyWith((message) => updates(message as TextRequest));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TextRequest create() => TextRequest._();
  TextRequest createEmptyInstance() => create();
  static $pb.PbList<TextRequest> createRepeated() => $pb.PbList<TextRequest>();
  @$core.pragma('dart2js:noInline')
  static TextRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextRequest>(create);
  static TextRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);
}

class TextReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('TextReply', createEmptyInstance: create)
    ..aOS(1, 'text')
    ..hasRequiredFields = false
  ;

  TextReply._() : super();
  factory TextReply() => create();
  factory TextReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TextReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  TextReply clone() => TextReply()..mergeFromMessage(this);
  TextReply copyWith(void Function(TextReply) updates) => super.copyWith((message) => updates(message as TextReply));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TextReply create() => TextReply._();
  TextReply createEmptyInstance() => create();
  static $pb.PbList<TextReply> createRepeated() => $pb.PbList<TextReply>();
  @$core.pragma('dart2js:noInline')
  static TextReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextReply>(create);
  static TextReply _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);
}

