import 'package:flutter/material.dart';
import 'package:invite_user/theme/theme.dart' as theme;

class DropdownItem extends StatefulWidget {
  DropdownItem({this.dataMap}) : super();

  final dynamic dataMap;

//  final String value;
  @override
  _DropdownItemState createState() => _DropdownItemState();
}

class _DropdownItemState extends State<DropdownItem> {
  String selectedValue = "1";
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Admin"), value: "1"),
    const DropdownMenuItem(child: Text("Approver"), value: "2"),
    const DropdownMenuItem(child: Text("Preparer"), value: "3"),
    const DropdownMenuItem(child: Text("Viewer"), value: "4"),
    const DropdownMenuItem(child: Text("Employee"), value: "5"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.0,
        margin: const EdgeInsets.fromLTRB(0.0, 13.0, 6.0, 6.0),
        child: InputDecorator(
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
              ),
              iconSize: 20,
              iconEnabledColor: Colors.blue,
              iconDisabledColor: Colors.grey,
              value: selectedValue,
              items: menuItems,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: theme.iconPrimary),
              dropdownColor: Colors.grey.shade200,
              onChanged: (String? value) {
                setState(() {});
                selectedValue = value!;
                widget.dataMap['role'] = value;
              },
            ))));
  }
}
