import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketConnection{
  static IO.Socket? _socket;

  static IO.Socket? getSocket() {
    // _socket ??= IO.io('https://chatspotbackendnodejs-504426a064e1.herokuapp.com', <String, dynamic>{
    //     "transports": ["websocket"],
    //     "autoConnect": false,
    //   });
    _socket ??= IO.io('http://192.168.15.215:2000', <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      });
    return _socket;
  }

}