import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podz/utility/providers/shoes_provider.dart';

class ShoesPage extends ConsumerStatefulWidget {
  const ShoesPage({super.key});

  @override
  ConsumerState<ShoesPage> createState() => _ShoesPageState();
}

final shoesProvider = NotifierProvider<ShoesProvider, List<String>>(
  ShoesProvider.new,
); 

class _ShoesPageState extends ConsumerState<ShoesPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final shoes = ref.watch(shoesProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber),
      body: Column(
        children: [
          SizedBox(height: 40),
          TextField(
            controller: controller,
            onSubmitted: (value) {
              ref.read(shoesProvider.notifier).addShoe(value);
              controller.clear();
            },
          ),
          SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemCount: shoes.length,
              itemBuilder: (context, index) {
                return Text(shoes[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
