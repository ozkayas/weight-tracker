import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(child: Icon(FontAwesomeIcons.weight, size: 40,),),
            NumberPicker(
              textStyle: TextStyle(fontSize: 16, color: Colors.black45),
              selectedTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.black),
              itemWidth: 80,
              itemCount: 3,
              value: _currentHorizontalIntValue,
              minValue: 40,
              maxValue: 130,
              step: 1,
              itemHeight:50,
              axis: Axis.horizontal,
              onChanged: (value)
              {
                print(value);
                setState(() => _currentHorizontalIntValue = value);
                widget.setWeight(value);},
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
