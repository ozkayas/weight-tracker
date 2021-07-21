import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'package:weight_tracker/views/add_record.dart';
import 'package:weight_tracker/views/graph.dart';
import 'package:weight_tracker/views/history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final List<Widget> screens = [GraphScreen(), HistoryScreen()];
  Widget currentScreen = GraphScreen();
  final PageStorageBucket bucket = PageStorageBucket();
  final Controller _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    //_controller.fetchRecordsFromStorage();

    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade800,
        onPressed: () {
          Get.to(AddRecordScreen());
          //_controller.addRecord(Record(dateTime: DateTime.now(), weight: 30.0));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          //height: 50,
          height: Get.height / 12,
          color: Colors.blue.shade700,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.auto_graph,
                        color: Colors.white,
                      ),
                      Text('Graph'),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      currentScreen = GraphScreen();
                      currentTab = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.history, color: Colors.white),
                      Text('History'),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      currentScreen = HistoryScreen();
                      currentTab = 1;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
