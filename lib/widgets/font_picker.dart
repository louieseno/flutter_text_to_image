import 'package:flutter/material.dart';

class FontPickerController extends StatelessWidget {
  FontPickerController({
    required this.font,
    required this.onChange,
  });
  final String font;
  final Function onChange;

  final List<String> _fonts = [
    'Roboto',
    'Alex Brush',
    'Alfa Slab One',
    'Heaters',
    'Squealer'
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(
        hint: _textChild(font), // Not necessary for Option 1
        value: font,
        onChanged: (newValue) => onChange(newValue),
        items: _fonts.map((font) {
          return DropdownMenuItem(
            child: _textChild(font),
            value: font,
          );
        }).toList(),
      ),
    );
  }
}

Widget _textChild(String value) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Text(
      value,
      style: TextStyle(fontFamily: value, fontSize: 20.0),
    ),
  );
}
