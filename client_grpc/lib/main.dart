import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:client_grpc/src/generated/upload.pbgrpc.dart";
import "dart:io";
import "package:grpc/grpc.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Stream<UploadFileRequest> getStream() async* {
    final file = File((await FilePicker.platform.pickFiles())!.files.single.path!);
    final stream = file.openRead();//.map((chunk) => UploadFileRequest()..chunk = chunk);

    await for (final bytes in stream) {
      final request = UploadFileRequest();
      request.chunk = bytes;
      yield request;
    }
  }

  Future<void> streamVideo() async {
    final stream = getStream().asBroadcastStream();
    final channel = ClientChannel(
      "192.168.0.109",
      port: 5224,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(),
        codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
      ),
    );
    final stub = UploaderClient(channel);

    try {
      final response = await stub.uploadFile(stream);
      print("Nome do video: ${response.fileName}");
    } catch (e) {
      print("Caught error: $e");
    }
    await channel.shutdown();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async => await streamVideo(),
            child: const Text("as")
          )
        ),
      ),
    );
  }
}