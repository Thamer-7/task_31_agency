import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String name;
  final String image;
  final num currentPrice;

  Coin({required this.name, required this.image, required this.currentPrice});

  @override
  List<Object?> get props => [name, image, currentPrice];
}

