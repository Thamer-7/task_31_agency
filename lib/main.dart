import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:task_31_agency/blocs/coin_bloc.dart';
import 'package:task_31_agency/model/coin.dart';
import 'package:task_31_agency/product_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  await initialFireBaseMessages();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $fcmToken');
  runApp(const MyApp());
}


Future<void> sendNotification(String registrationToken) async {
  final String serverKey =
      'AAAAc9Z5GAE:APA91bEFXI1LuRCL1giUx3oGXxNmGo6i36pCUJGhE2dPbsf-kvas_pgo5gB19PbMF4b4NdkC_vcRxfBVEbPUP3PL5jCpSlAo8OIype6cmM8o00pPiIhNT62wW4IurU-jUBse5d1Vggh1'; // Replace with your FCM Server Key

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverKey',
  };

  final notification = {
    'title': 'Notification Title',
    'body': 'This is the notification body.',
  };

  final data = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    // Add any additional data you want to send with the notification
  };

  final body = {
    'notification': notification,
    'data': data,
    'to': registrationToken,
  };

  final response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: headers,
    body: json.encode(body),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully!');
  } else {
    print('Failed to send notification. Error: ${response.body}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Coins',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CoinBloc(), // Register the CoinBloc here
        child: MyHomePage(title: 'Digital Coins'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CoinBloc _coinBloc = CoinBloc();

  @override
  void initState() {
    super.initState();
    _coinBloc.fetchCoinData(); // Fetch initial coin data
    Timer.periodic(
        const Duration(seconds: 5),
        (Timer t) =>
            _coinBloc.fetchCoinData()); // Fetch coin data every 10 seconds
  }

  @override
  void dispose() {
    _coinBloc.dispose(); // Dispose the CoinBloc
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            padding: EdgeInsets.all(5),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => ProductScreen()));
            },
            color: Colors.black,
            child: const Center(
                child: Icon(
              Icons.add,
              color: Colors.white,
            )),
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<List<Coin>>(
        stream: _coinBloc.coinStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final coins = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(80),
              itemCount: coins.length,
              itemBuilder: (context, index) {
                final coin = coins[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Image.network(
                      coin.image,
                    ),
                  ),
                  title: Text(
                    coin.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    'Price: \$${coin.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
