import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsTab extends StatefulWidget {
  final Function(String) onUpdate;
  const SharedPrefsTab({Key? key, required this.onUpdate}) : super(key: key);

  @override
  _SharedPrefsTabState createState() => _SharedPrefsTabState();
}

class _SharedPrefsTabState extends State<SharedPrefsTab> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('test_key', 'Hello SharedPrefs!');
    widget.onUpdate('Hello SharedPrefs!');
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('test_key') ?? 'No data';
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
          Text('SharedPreferences: Simple key-value storage'),
        ],
      ),
    );
  }
}
