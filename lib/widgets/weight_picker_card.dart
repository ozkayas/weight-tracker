import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:weight_tracker/common/constants.dart';

class WeightPickerCard extends StatefulWidget {
  const WeightPickerCard(
      {Key? key, required this.onChanged, required this.initialValue})
      : super(key: key);
  final Function onChanged;
  final int initialValue;

  @override
  _WeightPickerCardState createState() => _WeightPickerCardState();
}

class _WeightPickerCardState extends State<WeightPickerCard> {
  late int _currentHorizontalIntValue;

  @override
  void initState() {
    super.initState();
    _currentHorizontalIntValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.cornerRadii)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Icon(
                FontAwesomeIcons.weight,
                size: 40,
              ),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                NumberPicker(
                  //textStyle: TextStyle(fontSize: 16, color: Colors.grey),
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  /* selectedTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black), */
                  selectedTextStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  itemWidth: 80,
                  itemCount: 3,
                  value: _currentHorizontalIntValue,
                  minValue: 40,
                  maxValue: 130,
                  step: 1,
                  itemHeight: 50,
                  axis: Axis.horizontal,
                  onChanged: (value) {
                    setState(() => _currentHorizontalIntValue = value);
                    widget.onChanged(value);
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                Icon(
                  FontAwesomeIcons.chevronUp,
                  size: 16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
