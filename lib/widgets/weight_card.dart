import 'package:flutter/material.dart';

class WeightCard extends StatefulWidget {

  @override
  _WeightCardState createState() => _WeightCardState();
}

class _WeightCardState extends State<WeightCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("WEIGHT"),
            Container(), //TODO: draw slider
          ],
        ),
      ),
    );
  }
}