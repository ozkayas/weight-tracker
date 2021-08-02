import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weight_tracker/common/constants.dart';


class WeightPickerCard extends StatefulWidget {
  const WeightPickerCard({Key? key, required this.onChanged}) : super(key: key);
  final Function onChanged;

  @override
  _WeightPickerCardState createState() => _WeightPickerCardState();
}

class _WeightPickerCardState extends State<WeightPickerCard> {
  int _currentHorizontalIntValue = 70;


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Constants.cornerRadii)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(child: Icon(FontAwesomeIcons.weight, size: 40,),),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
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
                    setState(() => _currentHorizontalIntValue = value);
                    widget.onChanged(value);},
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black26),
                  ),
                ),
                Icon(FontAwesomeIcons.chevronUp, size: 16,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
