import 'package:flutter/material.dart';
import 'tabs/shared_prefs_tab.dart';
import 'tabs/hive_tab.dart';
import 'tabs/sqlite_tab.dart';
import 'tabs/file_tab.dart';

class StorageTabs extends StatefulWidget {
  @override
  _StorageTabsState createState() => _StorageTabsState();
}

class _StorageTabsState extends State<StorageTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String loadedData = 'No data yet';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateData(String data) {
    setState(() => loadedData = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'SharedPrefs'),
            Tab(text: 'Hive'),
            Tab(text: 'SQLite'),
            Tab(text: 'File'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Last loaded: $loadedData', 
                style: TextStyle(fontSize: 16)),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SharedPrefsTab(onUpdate: updateData),
                HiveTab(onUpdate: updateData),
                SqliteTab(onUpdate: updateData),
                FileTab(onUpdate: updateData),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
