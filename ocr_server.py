#!usr/bin/python3

from flutter_ocr_server import Server
from time import sleep
import os

from multiprocessing import Process

server = Server()

def a_fake_server():
    while 1:
        server.print()
        sleep(1)


p = Process(target=a_fake_server, args=())
p.start()

os.system("$SNAP/bin/flutter_ocr")

p.terminate()
exit()
