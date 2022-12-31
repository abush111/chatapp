import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';

class ClientSide extends StatefulWidget {
  const ClientSide({super.key});

  @override
  State<ClientSide> createState() => _ClientSideState();
}

class _ClientSideState extends State<ClientSide> {
  PusherClient? pusher;

  Channel? channel;

  int so = 0;

  @override
  void initState() {
    super.initState();

    String token = getToken();

    pusher = new PusherClient(
      API_keys,
      PusherOptions(
        // if local on android use 10.0.2.2
        host: ' https://candidate.yewubetsalone.com/api/send-message',
        encrypted: false,
        auth: PusherAuth(
          'http://example.com/broadcasting/auth',
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      ),
      enableLogging: true,
    );

    channel = pusher?.subscribe("private-orders");

    pusher?.onConnectionStateChange((state) {
      log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });

    pusher?.onConnectionError((error) {
      log("error: ${error?.message}");
    });

    channel?.bind('status-update', (event) {
      if (mounted) {
        final data = json.decode(event!.data.toString());
        so += int.parse(data['normal']);
      }
    });

    channel?.bind('order-filled', (event) {
      log("Order Filled Event${event?.data}");
    });
  }

  String getToken() => "super-secret-token";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: 49,
          child: Text(" Message  send from server" + so.toString())),
    );
  }
}
