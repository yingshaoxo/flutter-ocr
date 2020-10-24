import easyocr
class Server():
    def __init__(self):
        self.reader = easyocr.Reader(['ch_sim','en']) # need to run only once to load model into memory
    def print(self):
        print("hi")

    def do(self):
        result = reader.readtext('chinese.jpg')
