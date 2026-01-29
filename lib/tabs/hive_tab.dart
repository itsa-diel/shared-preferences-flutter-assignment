import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveTab extends StatefulWidget {
  final Function(String) onUpdate;
  const HiveTab({Key? key, required this.onUpdate}) : super(key: key);

  @override
  _HiveTabState createState() => _HiveTabState();
}

class _HiveTabState extends State<HiveTab> {
  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('testBox');
    loadData();
  }

  Future<void> saveData() async {
    await box.put('test_key', 'Hello Hive!');
    widget.onUpdate('Hello Hive!');
  }

  void loadData() {
    final data = box.get('test_key')?.toString() ?? 'No data';
    widget.onUpdate(data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: saveData, child: Text('Save')),
          SizedBox(height: 20),
          ElevatedButton(onPressed: loadData, child: Text('Load')),
          SizedBox(height: 20),
          Text('Hive: Fast NoSQL key-value store'),
        ],
      ),
    );
  }
}
