# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
import grpc

import helloworld_pb2 as helloworld__pb2


class HelloWorldServiceStub(object):
  """define a service
  """

  def __init__(self, channel):
    """Constructor.

    Args:
      channel: A grpc.Channel.
    """
    self.SayHello = channel.unary_unary(
        '/rpc_package.HelloWorldService/SayHello',
        request_serializer=helloworld__pb2.HelloRequest.SerializeToString,
        response_deserializer=helloworld__pb2.HelloReply.FromString,
        )


class HelloWorldServiceServicer(object):
  """define a service
  """

  def SayHello(self, request, context):
    """define the interface and data type
    """
    context.set_code(grpc.StatusCode.UNIMPLEMENTED)
    context.set_details('Method not implemented!')
    raise NotImplementedError('Method not implemented!')


def add_HelloWorldServiceServicer_to_server(servicer, server):
  rpc_method_handlers = {
      'SayHello': grpc.unary_unary_rpc_method_handler(
          servicer.SayHello,
          request_deserializer=helloworld__pb2.HelloRequest.FromString,
          response_serializer=helloworld__pb2.HelloReply.SerializeToString,
      ),
  }
  generic_handler = grpc.method_handlers_generic_handler(
      'rpc_package.HelloWorldService', rpc_method_handlers)
  server.add_generic_rpc_handlers((generic_handler,))
