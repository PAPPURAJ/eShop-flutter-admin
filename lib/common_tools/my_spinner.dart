import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpinnerItem {
  const SpinnerItem(this.name, this.icon);
  final String name;
  final Icon icon;
}

class MySpinner extends StatefulWidget {
  SpinnerItem? selectItem;
  List<SpinnerItem> spnItem;
  Function function;

  MySpinner(this.spnItem, this.function);

  @override
  State<MySpinner> createState() => _MySpinnerState();
}

class _MySpinnerState extends State<MySpinner> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<SpinnerItem>(
      hint: Text("Select Item"),
      dropdownColor: Colors.indigoAccent,
      style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.indigoAccent),
      value: widget.selectItem,
      onChanged: (value) {
        setState(() {
          widget.selectItem = value;
          widget.function(value);
        });
      },
      items: widget.spnItem.map((SpinnerItem user) {
        return DropdownMenuItem<SpinnerItem>(
          value: user,
          child: Row(
            children: <Widget>[
              user.icon,
              const SizedBox(
                width: 10,
              ),
              Text(
                user.name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
