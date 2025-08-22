import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamesProvider extends Notifier<List<String>> {
  @override
  List<String> build() => ["God Of War", "Fifa 2019"];

  void udpateList(String game) {
    List<String> games = [...state, game];
    state = games;
  }
}


