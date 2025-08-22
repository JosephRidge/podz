import 'package:flutter_riverpod/flutter_riverpod.dart';

class SportsProvider extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void addSport(String sport) {
    List<String> sports = [...state, sport];
    state = sports; 
  }
}
