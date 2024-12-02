import 'dart:async';
import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketSetup {
  static final SocketSetup _instance = SocketSetup._internal();
  factory SocketSetup() => _instance;

  SocketSetup._internal();

  IO.Socket? socket;
  final _dataStreamController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get dataStream => _dataStreamController.stream;

  Future<void> initSocket() async {
    socket = IO.io(
      "http://62.72.42.129:8090",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket?.onConnect((_) {
      log('Connected to WebSocket server');
    });

    socket?.on("updateTransRoute", (data) {
      log('Received data: $data');
      _dataStreamController.add(data); // Send data to the stream
    });

    socket?.onDisconnect((_) {
      log('Disconnected from WebSocket server');
      Future.delayed(const Duration(seconds: 5), () {
        if (socket?.disconnected == true) {
          socket?.connect();
        }
      });
    });

    socket?.connect();
  }

  void dispose() {
    _dataStreamController.close();
    socket?.disconnect();
  }
}

var socketSetup = SocketSetup();
