# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
"""Client and server classes corresponding to protobuf-defined services."""
import grpc

import server_pb2 as server__pb2


class OCR_ServiceStub(object):
    """Missing associated documentation comment in .proto file."""

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.Print = channel.unary_unary(
                '/OCR_Service/Print',
                request_serializer=server__pb2.TextRequest.SerializeToString,
                response_deserializer=server__pb2.TextReply.FromString,
                )
        self.Load = channel.unary_unary(
                '/OCR_Service/Load',
                request_serializer=server__pb2.TextRequest.SerializeToString,
                response_deserializer=server__pb2.TextReply.FromString,
                )
        self.Scan = channel.unary_unary(
                '/OCR_Service/Scan',
                request_serializer=server__pb2.TextRequest.SerializeToString,
                response_deserializer=server__pb2.TextReply.FromString,
                )
        self.GetImagesFromPDF = channel.unary_stream(
                '/OCR_Service/GetImagesFromPDF',
                request_serializer=server__pb2.TextRequest.SerializeToString,
                response_deserializer=server__pb2.TextReply.FromString,
                )


class OCR_ServiceServicer(object):
    """Missing associated documentation comment in .proto file."""

    def Print(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def Load(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def Scan(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetImagesFromPDF(self, request, context):
        """Missing associated documentation comment in .proto file."""
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_OCR_ServiceServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'Print': grpc.unary_unary_rpc_method_handler(
                    servicer.Print,
                    request_deserializer=server__pb2.TextRequest.FromString,
                    response_serializer=server__pb2.TextReply.SerializeToString,
            ),
            'Load': grpc.unary_unary_rpc_method_handler(
                    servicer.Load,
                    request_deserializer=server__pb2.TextRequest.FromString,
                    response_serializer=server__pb2.TextReply.SerializeToString,
            ),
            'Scan': grpc.unary_unary_rpc_method_handler(
                    servicer.Scan,
                    request_deserializer=server__pb2.TextRequest.FromString,
                    response_serializer=server__pb2.TextReply.SerializeToString,
            ),
            'GetImagesFromPDF': grpc.unary_stream_rpc_method_handler(
                    servicer.GetImagesFromPDF,
                    request_deserializer=server__pb2.TextRequest.FromString,
                    response_serializer=server__pb2.TextReply.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'OCR_Service', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class OCR_Service(object):
    """Missing associated documentation comment in .proto file."""

    @staticmethod
    def Print(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/OCR_Service/Print',
            server__pb2.TextRequest.SerializeToString,
            server__pb2.TextReply.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def Load(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/OCR_Service/Load',
            server__pb2.TextRequest.SerializeToString,
            server__pb2.TextReply.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def Scan(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/OCR_Service/Scan',
            server__pb2.TextRequest.SerializeToString,
            server__pb2.TextReply.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetImagesFromPDF(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            insecure=False,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_stream(request, target, '/OCR_Service/GetImagesFromPDF',
            server__pb2.TextRequest.SerializeToString,
            server__pb2.TextReply.FromString,
            options, channel_credentials,
            insecure, call_credentials, compression, wait_for_ready, timeout, metadata)
