import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/data/count_data.dart';
import 'package:flutter_new/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

  class _MyHomePageState extends ConsumerState<MyHomePage>{
    @override
  Widget build(BuildContext context) {
    print('home page');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(ref.watch(titleProvider)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(ref.watch(messageProvider)),
            Text(
              ref.watch(countDataProvider).count.toString(),
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: (){
                    CountData countData = ref.read(countDataProvider.notifier).state;
                    ref.read(countDataProvider.notifier).state = countData.copyWith(
                          count: countData.count + 1,
                          countUp: countData.countUp + 1,
                        );
                  },
                  child: const Icon(CupertinoIcons.add),
                ),
                FloatingActionButton(
                  onPressed: (){
                    CountData countData = ref.read(countDataProvider.notifier).state;
                    ref.read(countDataProvider.notifier).state = countData.copyWith(
                          count: countData.count - 1,
                          countDown: countData.countDown + 1,
                        );
                  },
                  child: const Icon(CupertinoIcons.minus),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(ref.read(countDataProvider.select((value) => value.countUp)).toString()),
                Text(ref.read(countDataProvider.select((value) => value.countDown)).toString()),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          ref.read(countDataProvider.notifier).state = const CountData(
            count: 0,
            countUp: 0,
            countDown: 0,
          );
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
