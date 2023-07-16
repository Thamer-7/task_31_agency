import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task_31_agency/model/coin.dart';

abstract class CoinEvent {}

class FetchCoinDataEvent extends CoinEvent {}

class CoinState {
  final List<Coin> coins;

  CoinState(this.coins);
}

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  CoinBloc() : super(CoinState([]));

  final _coinStreamController = StreamController<List<Coin>>();
  Stream<List<Coin>> get coinStream => _coinStreamController.stream;

  Future<void> fetchCoinData() async {
    try {
      final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,litecoin'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Coin> coins = data.map((coin) => Coin(
          name: coin['name'],
          currentPrice: coin['current_price'],
          image: coin['image'],
        )).toList();

        _coinStreamController.add(coins);
      } else {
        throw Exception('Failed to load coin data');
      }
    } catch (e) {
      print('Error fetching coin data: $e');
    }
  }

  void dispose() {
    _coinStreamController.close();
  }
}





