import 'package:flutter/material.dart';
import 'package:store_rate/store_rate.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(''),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text('Rate'),
          onPressed: (){
            StoreRate.rate(RateType.RateTypeInApp
            ,null);
          },
        ),
      ),
    );
  }
}
