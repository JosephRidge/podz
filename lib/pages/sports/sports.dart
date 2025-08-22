import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podz/utility/providers/sports_provider.dart';

class SportsPage extends ConsumerStatefulWidget {
  const SportsPage({super.key});

  @override
  ConsumerState<SportsPage> createState() => _SportsPageState();
}

final sportsProvider = NotifierProvider<SportsProvider, List<String>>(
  SportsProvider.new,
);

class _SportsPageState extends ConsumerState<SportsPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sports = ref.watch(sportsProvider);
    String placeholder = "add sport";
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber),
      body: Column(
        children: [
          TextField(
            controller: controller,
            onSubmitted: (value) {
              ref.read(sportsProvider.notifier).addSport(value);
              controller.clear();
                         },
            decoration: InputDecoration(hintText: placeholder),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sports.length,
              itemBuilder: (context, index) {
                return Text(sports[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
