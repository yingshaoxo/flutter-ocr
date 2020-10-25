#!usr/bin/python3

from flutter_ocr_server import Server
from time import sleep
import os

from multiprocessing import Process

server = Server()

p = Process(target=server.start, args=())
p.start()

sleep(0.5)

os.system("$SNAP/bin/flutter_ocr")

p.terminate()
exit()
