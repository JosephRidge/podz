import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:podz/pages/secondScreen/second.dart';

///
/// providerscope keeps track of all providers
/// providers are immutable in riverpod aprat from()
///
/// types:
/// provider (object tat provides data its immutable)

// define the provider - must be done at top level and decalred as a final
final numbersProvider = Provider<List<int>>((ref) => [1, 2, 3, 4, 5, 6]);

// reading or using a provider
// wrap the mainapp with a provider scope

// aproach 1
class Trial3 extends ConsumerWidget {
  const Trial3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numbers = ref.watch(numbersProvider);
    return Scaffold(body: Center(child: Text(numbers.toString())));
  }
}

//aproach 2:
class Trial4 extends StatelessWidget {
  const Trial4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final numbers = ref.watch(numbersProvider);
            return Text(numbers.toString());
          },
        ),
      ),
    );
  }
}

// creating the proider
final counterProvider = Provider<int>((ref) => 0);

// approach 1
class TrialPage extends ConsumerWidget {
  const TrialPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(body: Center(child: Text(count.toString())));
  }
}

// approach 2
class TrialPage2 extends StatelessWidget {
  const TrialPage2({super.key});

  @override
  Widget build(BuildContext context) {
    // final count = ref.watch(counterProvider);
    return Center(
      child: Consumer(
        builder: (context, ref, child) {
          final count = ref.watch(counterProvider);
          return Text("$count");
        },
      ),
    );
  }
}

// creating the proider
final countProvider = StateProvider<List<int>>((ref) => [0]);

class TrialPage5 extends ConsumerStatefulWidget {
  const TrialPage5({super.key});

  @override
  ConsumerState<TrialPage5> createState() => _TrialPage5State();
}

class _TrialPage5State extends ConsumerState<TrialPage5> {
  @override
  Widget build(BuildContext context) {
    final count = ref.watch(countProvider);
    return Scaffold(
      body: Center(child: Container(child: Text(count.toString()))),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         IconButton(
            onPressed: () {
              final notifier = ref.read(countProvider.notifier);
              final newList = [...notifier.state, notifier.state.last + 1];
              notifier.state = newList;
            },
            icon: Text("add"),
          ),
          SizedBox(height: 20,),
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => Second()));
            },
            icon: Text("next"),
          ),
        ],
      ),
    );
  }
}
