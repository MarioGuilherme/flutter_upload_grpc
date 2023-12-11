//
//  Generated code. Do not modify.
//  source: upload.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'upload.pb.dart' as $0;

export 'upload.pb.dart';

@$pb.GrpcServiceName('upload.Uploader')
class UploaderClient extends $grpc.Client {
  static final _$uploadFile = $grpc.ClientMethod<$0.UploadFileRequest, $0.UploadFileResponse>(
      '/upload.Uploader/UploadFile',
      ($0.UploadFileRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UploadFileResponse.fromBuffer(value));

  UploaderClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.UploadFileResponse> uploadFile($async.Stream<$0.UploadFileRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$uploadFile, request, options: options).single;
  }
}

@$pb.GrpcServiceName('upload.Uploader')
abstract class UploaderServiceBase extends $grpc.Service {
  $core.String get $name => 'upload.Uploader';

  UploaderServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.UploadFileRequest, $0.UploadFileResponse>(
        'UploadFile',
        uploadFile,
        true,
        false,
        ($core.List<$core.int> value) => $0.UploadFileRequest.fromBuffer(value),
        ($0.UploadFileResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.UploadFileResponse> uploadFile($grpc.ServiceCall call, $async.Stream<$0.UploadFileRequest> request);
}
