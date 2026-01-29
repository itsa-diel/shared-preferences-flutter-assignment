import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileTab extends StatefulWidget {
  final Function(String) onUpdate;
  const FileTab({Key? key, required this.onUpdate}) : super(key: key);

  @override
  _FileTabState createState() => _FileTabState();
}

class _FileTabState extends State<FileTab> {
  Future<void> saveData() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/test.txt');
    await file.writeAsString('Hello File!');
    widget.onUpdate('Hello File!');
  }

  Future<void> loadData() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/test.txt');
      final data = await file.readAsString();
      widget.onUpdate(data);
    } catch (e) {
      widget.onUpdate('No data');
    }
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
          Text('File: Raw file I/O'),
        ],
      ),
    );
  }
}
