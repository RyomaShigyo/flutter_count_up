import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/data/count_data.dart';
import 'package:flutter_new/logic/button_animation_logic.dart';
import 'package:flutter_new/provider.dart';
import 'package:flutter_new/view_model.dart';
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
      home:  MyHomePage(ViewModel()),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  final ViewModel viewModel;
  MyHomePage(this.viewModel,{Key? key}) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

  class _MyHomePageState extends ConsumerState<MyHomePage>
      with TickerProviderStateMixin{

    late ViewModel _viewModel;

    @override
    void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    _viewModel.setRef(ref, this);
  }

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
              _viewModel.count,
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: _viewModel.onIncrease,
                  child: ButtonAnimation(
                      animationCombination: _viewModel.animationPlusCombination,
                    child: const Icon(CupertinoIcons.plus),
                  ),
                ),
                FloatingActionButton(
                  onPressed: _viewModel.onDecrease,
                  child: ButtonAnimation(
                    animationCombination: _viewModel.animationMinusCombination,
                    child: const Icon(CupertinoIcons.minus),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(_viewModel.countUp),
                Text(_viewModel.countDown),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewModel.onReset,
        child: ButtonAnimation(
          animationCombination: _viewModel.animationResetCombination,
          child: const Icon(CupertinoIcons.refresh),
        ),
      ),
    );
  }
}

class ButtonAnimation extends StatelessWidget {
  final AnimationCombination animationCombination;
  final Widget child;
  ButtonAnimation({
    super.key,
    required this.animationCombination,
    required this.child,
  }) ;


  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: animationCombination.animationScale,
        child: RotationTransition(
            turns: animationCombination.animationRotation,
            child: child,
        )
    );
  }
}
