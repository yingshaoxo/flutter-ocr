from concurrent import futures
from .rpc import server_pb2, server_pb2_grpc
import grpc
import easyocr

server = None


class Server(server_pb2_grpc.OCR_Server):
    def __init__(self):
        self.reader = None
        super().__init__()

    def Load(self, request, context):
        try:
            self.reader = easyocr.Reader(['ch_sim', 'en'])
            return server_pb2.TextReply(text="ok")
        except Exception as e:
            return server_pb2.TextReply(text=str(e))

    def Print(self, request, context):
        print(f"print: {request.text}")
        return server_pb2.TextReply(text=request.text)


    def do(self):
        result = self.reader.readtext('chinese.jpg')

    def start(self):
        global server, reader
        server = grpc.server(futures.ThreadPoolExecutor(max_workers=5))
        server_pb2_grpc.add_OCR_ServerServicer_to_server(Server(), server)
        server.add_insecure_port('[::]:50051')
        server.start()
        print("server started.")
        server.wait_for_termination()

    def stop(self):
        global server
        server.stop()


if __name__ == "__main__":
    s = Server()
    s.start()
