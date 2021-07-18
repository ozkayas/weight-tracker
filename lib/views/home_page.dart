import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
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
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.addRecord(Record(dateTime: DateTime.now(), weight: 30.0));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          //height: 50,
          height: Get.height / 12,
          color: Colors.deepOrangeAccent,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  //hoverColor: Colors.deepOrangeAccent,
                  //splashColor: Colors.lightGreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_graph),
                      Text('Home'),
                    ],
                  ),
                  onTap: () {
                    print('pressed');
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
                      Icon(Icons.history),
                      Text('History'),
                    ],
                  ),
                  onTap: () {
                    print('history selected');
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