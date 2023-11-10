import 'package:easy_dynamic_link/easy_dynamic_link.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    _easyDL.initFbd();
    super.initState();
    _easyDL.handler(_listenFunction);
  }

  late Uri? uri;
  late List? data;

  void _listenFunction(Uri uri, List<dynamic> data) {
    print('Uri : $uri from Dynamic Link Data');
    print('Data : $data from Dynamic Link Data');
    setState(() {
      uri = uri;
      data = data;
    });
  }

  final EasyDL _easyDL = EasyDL();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$uri',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '$data',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
