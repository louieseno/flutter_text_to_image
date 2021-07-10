import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class ColorPickerController extends StatelessWidget {
  ColorPickerController({
    required this.color,
    required this.onChange,
  });
  final Color color;
  final Function onChange;
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
            color,
            (color) {
              onChange(Color(color.value));
            },
          ),
          child: ColorIndicator(
            color: color,
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
