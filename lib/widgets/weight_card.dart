import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WeightCard extends StatefulWidget {

  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {

  late int weight;

  @override
  void initState() {
    super.initState();
    //weight = widget.initialWeight ?? 70;
    weight = 70;
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("WEIGHT"),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _drawSlider(),
              ),
            ), //TODO: draw slider
          ],
        ),
      ),
    );
  }

  Widget _drawSlider() {
    return WeightBackground(
      child: LayoutBuilder(
        builder: (context, constraints) => WeightSlider(
          minValue: 30,
          maxValue: 40,
          value: weight,
          onChanged: (val) => setState(() => weight = val),
          width: constraints.maxWidth,
        ),
      ),
    );
  }
}

class WeightBackground extends StatelessWidget {
  final Widget? child;

  const WeightBackground({this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color.fromRGBO(244, 244, 244, 1.0),
            borderRadius:
            BorderRadius.circular(40),
          ),
          child: child,
        ),
        Icon(Icons.arrow_upward, size: 30)
      ],
    );
  }
}



class WeightSlider extends StatelessWidget {
  WeightSlider({
    required this.minValue,
    required this.maxValue,
    required this.width,
    required this.value,
    required this.onChanged,
  }) ;

  final int minValue;
  final int maxValue;
  final double width;
  final int value;
  final ValueChanged<int> onChanged;
  final ScrollController _scrollController = ScrollController();

  double get itemExtent => width / 3;

  int _indexToValue(int index) => minValue + (index - 1);

  @override
  build(BuildContext context) {

    int itemCount = (maxValue - minValue) + 3;
    return NotificationListener<ScrollNotification>(onNotification: _onNotification,

      child: new ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemExtent: itemExtent,
        itemCount: itemCount,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final int value = _indexToValue(index);
          bool isExtra = index == 0 || index == itemCount - 1;

          return isExtra
              ? Container() //empty first and last element
              : Center(
                child: FittedBox(
                  child: Text(
                    value.toString(),
                    style: _getTextStyle(value),
                  ),
                  fit: BoxFit.scaleDown,

                ),
          );
        },
      ),
    );

  }

  int _offsetToMiddleIndex(double offset) => (offset + width / 2) ~/ itemExtent;

  int _offsetToMiddleValue(double offset) {
    int indexOfMiddleElement = _offsetToMiddleIndex(offset);
    int middleValue = _indexToValue(indexOfMiddleElement);
    return middleValue;
  }
  bool _userStoppedScrolling(Notification notification) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        _scrollController.position.activity is! HoldScrollActivity;
  }

  _animateTo(int valueToSelect, {int durationMillis = 200}) {
    double targetExtent = (valueToSelect - minValue) * itemExtent;
    _scrollController.animateTo(
      targetExtent,
      duration: new Duration(milliseconds: durationMillis),
      curve: Curves.decelerate,
    );
  }
  bool _onNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int middleValue = _offsetToMiddleValue(notification.metrics.pixels);

      if(_userStoppedScrolling(notification)) {
        _animateTo(middleValue);
      }

      if (middleValue != value) {
        onChanged(middleValue); //update selection
      }
    }
    return true;
  }

  TextStyle _getDefaultTextStyle() {
    return new TextStyle(
      color: Color.fromRGBO(196, 197, 203, 1.0),
      fontSize: 14.0,
    );
  }

  TextStyle _getHighlightTextStyle() {
    return new TextStyle(
      color: Color.fromRGBO(77, 123, 243, 1.0),
      fontSize: 28.0,
    );
  }

  TextStyle _getTextStyle(int itemValue) {
    return itemValue == value
        ? _getHighlightTextStyle()
        : _getDefaultTextStyle();
  }
}