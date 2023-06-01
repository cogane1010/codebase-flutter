import 'package:flutter/material.dart';

import '../../resources/color.dart';
import '../../resources/dimens.dart';

class StatusProject extends StatelessWidget {
  const StatusProject(
      {Key? key,
      this.width,
      this.height,
      this.borderWidth,
      this.borderColor = AppColors.grayLineOpacity,
      this.backgroundColor = AppColors.whiteColor,
      this.padding,
      this.margin,
      this.topLeftRadius = Radius.zero,
      this.bottomRightRadius = const Radius.circular(Dimens.size12),
      this.elevation = 0,
      this.backgroundImageUrl,
      this.data})
      : super(key: key);

  final double? width;
  final double? height;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Radius topLeftRadius;
  final Radius bottomRightRadius;
  final int elevation;
  final String? backgroundImageUrl;
  final List<String>? data;

  @override
  Widget build(BuildContext context) {
    String? dropdownValue = data?.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        // setState(() {
        //   dropdownValue = value!;
        // });
        print("status combobox:" + value.toString());
      },
      items: data?.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
