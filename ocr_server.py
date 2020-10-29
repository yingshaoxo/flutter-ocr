#!usr/bin/python3

from flutter_ocr_server import Server
import os

from multiprocessing import Process

server = Server()

p = Process(target=server.start, args=())
p.start()

os.system("$SNAP/bin/flutter_ocr")

p.terminate()
exit()
