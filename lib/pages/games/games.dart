import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podz/utility/providers/games_provider.dart';

class GamesPage extends ConsumerStatefulWidget {
  const GamesPage({super.key});

  @override
  ConsumerState<GamesPage> createState() => _GamesPageState();
}

final gameListProvider = NotifierProvider<GamesProvider, List<String>>(
  GamesProvider.new,
);

class _GamesPageState extends ConsumerState<GamesPage> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final games = ref.watch(gameListProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amber),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              onSubmitted: (value) {
                ref.read(gameListProvider.notifier).udpateList(value);
                controller.clear();
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return Text(games[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
