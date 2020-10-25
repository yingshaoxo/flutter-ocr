from concurrent import futures
try:
    from .rpc import server_pb2, server_pb2_grpc
except Exception as e:
    print(e)
    from rpc import server_pb2, server_pb2_grpc
import grpc
import easyocr
import json
import numpy as np

server = None


def convert(o):
    if isinstance(o, np.int64):
        return int(o)
    raise TypeError


class OCR():
    def __init__(self):
        self.reader = None

    def get_ready(self):
        self.reader = easyocr.Reader(['ch_sim', 'en'])

    def _raw_to_mature(self, raw_list):
        raw_result = []
        text = ""
        for t in raw_list:
            text += t[1] + "\n"
            raw_result.append({
                "box": t[0],
                "text": t[1],
                "accuracy": float(round(t[2], 2)),
            })
        result = {
            "raw": raw_result,
            "text": text
        }
        result = json.loads(json.dumps(result, default=convert))
        return result

    def scan(self, file_path):
        return self._raw_to_mature(self.reader.readtext(file_path))


class Server(server_pb2_grpc.OCR_Server):
    def __init__(self):
        self.ocr = OCR()
        super().__init__()

    def Print(self, request, context):
        print(f"print: {request.text}")
        return server_pb2.TextReply(text=request.text)

    def Load(self, request, context):
        try:
            print("loading...")
            self.ocr.get_ready()
            print("loading finished...")
            return server_pb2.TextReply(text="ok")
        except Exception as e:
            return server_pb2.TextReply(text=str(e))

    def Scan(self, request, context):
        print("scaning...")
        result = self.ocr.scan(request.text)
        result = json.dumps(result)
        print(result)
        print("scaning finished...")
        return server_pb2.TextReply(text=result)

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


"""
if __name__ == "__main__":
    from pprint import pprint
    ocr = OCR()
    ocr.get_ready()
    result = ocr.scan("./saying.png")
    pprint(result)
"""
if __name__ == "__main__":
    s = Server()
    s.start()
