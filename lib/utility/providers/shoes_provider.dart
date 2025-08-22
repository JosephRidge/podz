import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoesProvider extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void addShoe(String shoe) {
    List<String> shoes = [...state, shoe];
    state = shoes; 
  }
}
