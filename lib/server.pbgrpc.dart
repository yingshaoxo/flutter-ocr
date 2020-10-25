///
//  Generated code. Do not modify.
//  source: server.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'server.pb.dart' as $0;
export 'server.pb.dart';

class OCR_ServerClient extends $grpc.Client {
  static final _$print = $grpc.ClientMethod<$0.TextRequest, $0.TextReply>(
      '/OCR_Server/Print',
      ($0.TextRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TextReply.fromBuffer(value));
  static final _$load = $grpc.ClientMethod<$0.TextRequest, $0.TextReply>(
      '/OCR_Server/Load',
      ($0.TextRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TextReply.fromBuffer(value));
  static final _$scan = $grpc.ClientMethod<$0.TextRequest, $0.TextReply>(
      '/OCR_Server/Scan',
      ($0.TextRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TextReply.fromBuffer(value));

  OCR_ServerClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.TextReply> print($0.TextRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$print, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.TextReply> load($0.TextRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$load, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.TextReply> scan($0.TextRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$scan, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class OCR_ServerServiceBase extends $grpc.Service {
  $core.String get $name => 'OCR_Server';

  OCR_ServerServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TextRequest, $0.TextReply>(
        'Print',
        print_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TextRequest.fromBuffer(value),
        ($0.TextReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TextRequest, $0.TextReply>(
        'Load',
        load_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TextRequest.fromBuffer(value),
        ($0.TextReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TextRequest, $0.TextReply>(
        'Scan',
        scan_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TextRequest.fromBuffer(value),
        ($0.TextReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.TextReply> print_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TextRequest> request) async {
    return print(call, await request);
  }

  $async.Future<$0.TextReply> load_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TextRequest> request) async {
    return load(call, await request);
  }

  $async.Future<$0.TextReply> scan_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TextRequest> request) async {
    return scan(call, await request);
  }

  $async.Future<$0.TextReply> print(
      $grpc.ServiceCall call, $0.TextRequest request);
  $async.Future<$0.TextReply> load(
      $grpc.ServiceCall call, $0.TextRequest request);
  $async.Future<$0.TextReply> scan(
      $grpc.ServiceCall call, $0.TextRequest request);
}
