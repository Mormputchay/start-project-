import 'package:flutter/material.dart';
import 'package:start_project1/color.dart';

class SingleChoiceDialog extends StatefulWidget {
  const SingleChoiceDialog({Key? key}) : super(key: key);

  @override
  SingleChoiceDialogState createState() => SingleChoiceDialogState();
}

class SingleChoiceDialogState extends State<SingleChoiceDialog> {
  String selectedGender = "None";
  List<String> ringtone = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: TColor.black,
      title: const Center(
          child: Text(
        'Gender',
        style: TextStyle(color: Colors.white),
      )),
      children: ringtone
          .map((r) => RadioListTile(
                title: Text(r, style: const TextStyle(color: Colors.white)),
                groupValue: selectedGender,
                activeColor: TColor.primary,
                selected: r == selectedGender,
                fillColor:
                    MaterialStateColor.resolveWith((states) => TColor.primary),
                value: r,
                onChanged: (dynamic val) {
                  setState(() {
                    selectedGender = val;
                    selectedGender = val.toString();
                    // Navigator.of(context).pop();
                  });
                },
              ))
          .toList(),
    );
  }
}
