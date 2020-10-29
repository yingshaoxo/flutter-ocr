import 'package:flutter_ocr/main.dart';
import 'package:grpc/grpc.dart';
import 'server.pb.dart';
import 'server.pbgrpc.dart';
import 'dart:convert';

class Service {
  var channel;
  var stub;

  Service() {
    channel = ClientChannel(
      'localhost',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    stub = OCR_ServiceClient(channel);
  }

  void shutdown() async {
    await channel.shutdown();
  }

  void say_hi() async {
    try {
      final response =
          await stub.print(TextRequest()..text = "client started.");
      print(response.text);
    } on GrpcError {
      print("an grpc error");
    } catch (e) {
      print(e);
    }
  }

  Future<bool> load(List<String> languages) async {
    bool status = false;
    try {
      final response =
          await stub.load(TextRequest()..text = jsonEncode(languages));
      if (response.text == "ok") {
        return true;
      }
    } catch (e) {
      print(e);
    }
    return status;
  }

  Future<String> scan(String file_path) async {
    String result = "";
    try {
      final response = await stub.scan(TextRequest()..text = file_path);
      //Map<String, dynamic> data = jsonDecode(response.text);
      Map data = jsonDecode(response.text);
      result = data["text"];
    } catch (e) {
      print(e);
    }
    return result;
  }
}
