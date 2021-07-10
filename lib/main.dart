import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:text_to_image/widgets/color_picker.dart';
import 'package:text_to_image/widgets/font_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save image to gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey _globalKey = GlobalKey();
  Color colorScheme = Colors.amber;
  String fontFamily = 'Roboto';
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = 'Enter Message Here';
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mobile Slab"),
          actions: [
            OutlinedButton(
              onPressed: _saveScreen,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              RepaintBoundary(
                  key: _globalKey,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      color: colorScheme,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Text(
                        _controller.text,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: fontFamily,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  )),
              // Image Decorators
              ColorPickerController(
                color: colorScheme,
                onChange: (value) {
                  setState(() {
                    colorScheme = value;
                  });
                },
              ),
              FontPickerController(
                font: fontFamily,
                onChange: (value) {
                  setState(() {
                    fontFamily = value;
                  });
                },
              ),
              // Input
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Hint Text',
                    border: OutlineInputBorder(),
                  ),
                  controller: _controller,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              )
            ],
          ),
        ));
  }

  void _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  void _showSnackBar(content) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  void _saveScreen() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final result =
            await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        if (result['isSuccess']) {
          _showSnackBar('Image save!');
        } else {
          _showSnackBar('Image failed to save!');
        }
      }
    } catch (err) {
      _showSnackBar(err.toString());
    }
  }
}
