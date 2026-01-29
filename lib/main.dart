import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'storage_tabs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('testBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storage Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StorageTabs(),
    );
  }
}
