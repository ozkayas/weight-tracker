import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/common/constants.dart';
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
  int _currentTab = 0;
  final List<Widget> screens = [GraphScreen(), HistoryScreen()];
  Widget currentScreen = GraphScreen();
  final PageStorageBucket bucket = PageStorageBucket();
  final Controller _controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {

    /*return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.to(() => AddRecordScreen());
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
          color: Colors.black87,
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
                      Text('Graph', style: TextStyle(color: Colors.white),),
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
                      Text('History', style: TextStyle(color: Colors.white)),
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
    );*/
    return Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Get.to(() => AddRecordScreen());
            //_controller.addRecord(Record(dateTime: DateTime.now(), weight: 30.0));
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          height: Get.height / 12,
          leftCornerRadius: Constants.cornerRadii,
          rightCornerRadius: Constants.cornerRadii,
          icons: [FontAwesomeIcons.chartLine, FontAwesomeIcons.history],
          activeColor: Colors.white,
          inactiveColor: Colors.grey.shade400,
          iconSize: 26,
          activeIndex: _currentTab,
          onTap: (int) {
            setState(() {
              setScreen(int);
              _currentTab = int;
            });
          },
          gapLocation: GapLocation.center,
          backgroundColor: Colors.black,
        )

        );
  }

  void setScreen(int tabIndex){
    if (tabIndex == 0 ){
      currentScreen=GraphScreen();
    }else{
      currentScreen=HistoryScreen();
    }
  }
}
