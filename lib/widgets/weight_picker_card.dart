import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class WeightPickerCard extends StatefulWidget {
  const WeightPickerCard({Key? key, required this.setWeight}) : super(key: key);
  final Function setWeight;

  @override
  _WeightPickerCardState createState() => _WeightPickerCardState();
}

class _WeightPickerCardState extends State<WeightPickerCard> {
  int _currentHorizontalIntValue = 70;


  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text('WEIGHT - kg'),
          SizedBox(height: 20),
          NumberPicker(
            textStyle: TextStyle(fontSize: 20),
            selectedTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.blueAccent),

            itemWidth: 100,
            itemCount: 3,
            value: _currentHorizontalIntValue,
            minValue: 40,
            maxValue: 130,
            step: 1,
            itemHeight:70,
            axis: Axis.horizontal,
            onChanged: (value)
            {

              print(value);
              setState(() => _currentHorizontalIntValue = value);
              widget.setWeight(value);},
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black26),
            ),
          ),
        ],
      ),
    ),);
  }
}
