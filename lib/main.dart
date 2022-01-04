import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  @override
  Widget build(BuildContext context) {
    return new MediaQuery(
        data: new MediaQueryData(),
        child: MaterialApp(
          home: builderApp(
            title: 'StreamBuilderApp',
          ),
        ));
  }
}

class builderApp extends StatefulWidget {
  const builderApp({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _builderAppState createState() => _builderAppState();
}

//FAKE FIRECASE STREAM
Stream<int> generateStream = (() async* {
  await Future<void>.delayed(const Duration(seconds: 2));
  yield 1;

  await Future<void>.delayed(const Duration(seconds: 1));
  yield 2;

  await Future<void>.delayed(const Duration(seconds: 1));
  yield 3;
})();

class _builderAppState extends State<builderApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
            stream: generateStream,
            initialData: 0,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator.adaptive();
              }
              if (snapshot.hasError) {
                return const Text('Error');
              } else {
                return Text(
                  snapshot.data.toString(),
                  style: const TextStyle(fontSize: 40),
                );
              }
            }),
      ),
    );
  }
}
