import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:podz/pages/trial_codes.dart';

class Second extends ConsumerStatefulWidget {
  const Second({super.key});

  @override
  ConsumerState<Second> createState() => _SecondState();
}

class _SecondState extends ConsumerState<Second> {
  @override
  Widget build(BuildContext context) {
    final count = ref.watch(countProvider);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amberAccent),
      body: Center(
        child: Container(color: Colors.amber, child: Text(count.toString())),
      ),
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
          SizedBox(height: 20),
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

final namesProvider = StateProvider<List<String>>(
  (ref) => ['John Doe', 'Liz Lizo', 'Moreli Myles'],
);

 
class SchoolRegister extends ConsumerStatefulWidget {
  const SchoolRegister({super.key});

  @override
  ConsumerState<SchoolRegister> createState() => _SchoolRegisterState();
}

class _SchoolRegisterState extends ConsumerState<SchoolRegister> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }

  void updateData(ref, name) {
    final students = ref.read(namesProvider.notifier);
    List<String> newStudents = [...students.state, name];
    students.state = newStudents;
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final students = ref.watch(namesProvider);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              onSubmitted: (value) => {updateData(ref, value)},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter student names',
              ),
            ),
            Text(students.toString()),
          ],
        ),
      ), 
    );
  }
}
