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
from time import sleep

from pdf2image import convert_from_path

from auto_everything.disk import Disk
from auto_everything.base import Terminal
disk = Disk()
t = Terminal()

server = None


def convert(o):
    if isinstance(o, np.int64):
        return int(o)
    raise TypeError


class OCR():
    def __init__(self):
        self.reader = None

        #{t.split("\t")[0]:t.split("\t")[1] for t in lists}
        self.language_dict = {'Abaza': 'abq',
                              'Adyghe': 'ady',
                              'Afrikaans': 'af',
                              'Angika': 'ang',
                              'Arabic': 'ar',
                              'Assamese': 'as',
                              'Avar': 'ava',
                              'Azerbaijani': 'az',
                              'Belarusian': 'be',
                              'Bulgarian': 'bg',
                              'Bihari': 'bh',
                              'Bhojpuri': 'bho',
                              'Bengali': 'bn',
                              'Bosnian': 'bs',
                              'Simplified Chinese': 'ch_sim',
                              'Traditional Chinese': 'ch_tra',
                              'Chechen': 'che',
                              'Czech': 'cs',
                              'Welsh': 'cy',
                              'Danish': 'da',
                              'Dargwa': 'dar',
                              'German': 'de',
                              'English': 'en',
                              'Spanish': 'es',
                              'Estonian': 'et',
                              'Persian (Farsi)': 'fa',
                              'French': 'fr',
                              'Irish': 'ga',
                              'Goan Konkani': 'gom',
                              'Hindi': 'hi',
                              'Croatian': 'hr',
                              'Hungarian': 'hu',
                              'Indonesian': 'id',
                              'Ingush': 'inh',
                              'Icelandic': 'is',
                              'Italian': 'it',
                              'Japanese': 'ja',
                              'Kabardian': 'kbd',
                              'Korean': 'ko',
                              'Kurdish': 'ku',
                              'Latin': 'la',
                              'Lak': 'lbe',
                              'Lezghian': 'lez',
                              'Lithuanian': 'lt',
                              'Latvian': 'lv',
                              'Magahi': 'mah',
                              'Maithili': 'mai',
                              'Maori': 'mi',
                              'Mongolian': 'mn',
                              'Marathi': 'mr',
                              'Malay': 'ms',
                              'Maltese': 'mt',
                              'Nepali': 'ne',
                              'Newari': 'new',
                              'Dutch': 'nl',
                              'Norwegian': 'no',
                              'Occitan': 'oc',
                              'Polish': 'pl',
                              'Portuguese': 'pt',
                              'Romanian': 'ro',
                              'Russian': 'ru',
                              'Serbian (cyrillic)': 'rs_cyrillic',
                              'Serbian (latin)': 'rs_latin',
                              'Nagpuri': 'sck',
                              'Slovak (need revisit)': 'sk',
                              'Slovenian': 'sl',
                              'Albanian': 'sq',
                              'Swedish': 'sv',
                              'Swahili': 'sw',
                              'Tamil': 'ta',
                              'Tabassaran': 'tab',
                              'Thai': 'th',
                              'Tagalog': 'tl',
                              'Turkish': 'tr',
                              'Uyghur': 'ug',
                              'Ukranian': 'uk',
                              'Urdu': 'ur',
                              'Uzbek': 'uz',
                              'Vietnamese (need revisit)': 'vi'}

    def get_ready(self, language_list):
        print(language_list)
        language_list = [self.language_dict[l] for l in language_list]
        self.reader = easyocr.Reader(language_list)

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

    def handle_a_pdf(self, file_path):
        print(file_path)
        hash_tag = disk.get_hash_of_a_file(file_path)
        hash_tag = hash_tag[:10]
        root_folder = t.run_command("echo ~/.flutter_ocr")
        if not disk.exists(root_folder):
            t.run_command(f"mkdir -p {root_folder}")
        pdf_folder = t.run_command("echo ~/.flutter_ocr/pdf")
        if not disk.exists(pdf_folder):
            t.run_command(f"mkdir -p {pdf_folder}")
        working_folder = t.run_command(f"echo ~/.flutter_ocr/pdf/{hash_tag}")
        print(working_folder)
        if not disk.exists(working_folder):
            t.run_command(f"mkdir -p {working_folder}")
            convert_from_path(file_path, output_folder=working_folder, fmt="jpeg")
        #sleep(2)
        print("done")
        files = disk.get_files(working_folder, type_limiter=[".jpg"])
        files.sort()
        return files



class Server(server_pb2_grpc.OCR_Service):
    def __init__(self):
        self.ocr = OCR()
        super().__init__()

    def Print(self, request, context):
        print(f"print: {request.text}")
        return server_pb2.TextReply(text=request.text)

    def Load(self, request, context):
        try:
            print("loading...")
            languages = json.loads(request.text)
            self.ocr.get_ready(languages)
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

    def GetImagesFromPDF(self, request, context):
        list_of_image_path = self.ocr.handle_a_pdf(request.text)
        for path in list_of_image_path:
            yield server_pb2.TextReply(text=path)

    def start(self):
        global server, reader
        server = grpc.server(futures.ThreadPoolExecutor(max_workers=5))
        server_pb2_grpc.add_OCR_ServiceServicer_to_server(Server(), server)
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
