import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class ColorPickerController extends StatefulWidget {
  ColorPickerController({
    required this.color,
    required this.onChange,
  });
  final Color color;
  final Function onChange;

  @override
  _ColorPickerControllerState createState() => _ColorPickerControllerState();
}

class _ColorPickerControllerState extends State<ColorPickerController> {
  late Color dialogPickerColor; //

  @override
  void initState() {
    dialogPickerColor = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Choose a color scheme:'),
        SizedBox(width: 10.0),
        GestureDetector(
          onTap: () => _showColorPickerDialog(
            context,
            dialogPickerColor,
            (color) {
              dialogPickerColor = Color(color.value);
              widget.onChange(Color(color.value));
            },
          ),
          child: ColorIndicator(
            color: dialogPickerColor,
          ),
        ),
      ],
    );
  }
}

void _showColorPickerDialog(
    BuildContext context, Color color, Function(Color) onChanged) {
  ColorPicker(color: color, onColorChanged: onChanged)
      .showPickerDialog(context);
}
