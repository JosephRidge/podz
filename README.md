# podz

Providers return cached values.

## declare a [provider](https://riverpod.dev/docs/concepts2/providers)
Provider is a read only element
Must be declared at the top level 
you can create multiple providers without an issue

```
final counterProvider = Provider<int>((ref) => 0);
final nameProvider = Provider<String>((ref)=>"Hellow JayR");
final numbersProvider = Provider<List<int>>((ref) => [1, 2, 3, 4, 5,6]);


```

## Accessing them
- Approach 1: Inheriting the Consumerwidget

```
class Trial3 extends ConsumerWidget {
  const Trial3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numbers = ref.watch(numbersProvider);
    return Scaffold(body: Center(child: Text(numbers.toString())));
  }
}
```

- Approach 2: Using the [Consumer widget](https://riverpod.dev/docs/concepts2/consumers)

Good approach where you only apply the consumer to the entity that uses it in this below case its the Text widget alone. But if the whole Scaffold used it we would wrap it all. 

``` 
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
```

## Reading data

`ref.watch(providerName);` : read and watch or ather listen for changes on the provider. Best used inside the widget build function 

`ref.read(providerName);` : read once on the provider, used outside the build function

## Updating data (using stateProvider -old way)
- define the provider
```
final namesProvider = StateProvider<List<String>>((ref)=>['John Doe', 'Liz Lizo', 'Moreli Myles']);

```
- update the data(we define the stateprovider but this time round access the notifier such that it triggers the update)

```

class _SchoolRegisterState extends ConsumerState<SchoolRegister> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
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
```

## Updating data (using NotifierProvider - new way)

- define a separate class that extends a Notifier

```
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoesProvider extends Notifier<List<String>> {
  @override
  List<String> build() => [];

  void addShoe(String shoe) {
    List<String> shoes = [...state, shoe];
    state = shoes; 
  }
}

```

- intialize the notifier
```

final shoesProvider = NotifierProvider<ShoesProvider, List<String>>(
  ShoesProvider.new,
); 

```
- watch for changes and update the items
```
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

```


A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
